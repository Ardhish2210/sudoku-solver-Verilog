`timescale 1ns/1ps
`include "board_memory.v"
`include "sudoku_controller.v"
`include "constraint_checker.v"

module tb_sudoku_controller_debug;

reg clk, rst, start;
wire done, unsolvable;

wire [6:0] cell_index_mem, cell_index_cc;
wire [3:0] data_out_mem, data_in_mem, num_to_checker;
wire read_en, write_en;
wire valid_from_checker;
wire [323:0] board_flat;

reg init_mode;
reg [6:0] init_addr;
reg [3:0] init_data;
reg init_write;

wire [6:0] final_cell_index = init_mode ? init_addr : cell_index_mem;
wire [3:0] final_data_in = init_mode ? init_data : data_in_mem;
wire final_write_en = init_mode ? init_write : write_en;
wire final_read_en = init_mode ? 1'b0 : read_en;

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

board_memory BM (.clk(clk), .rst(rst), .read_en(final_read_en), .write_en(final_write_en), .cell_index(final_cell_index), .data_in(final_data_in), .data_out(data_out_mem), .board_flat(board_flat));
constraint_checker CC (.num_to_place(num_to_checker), .cell_index(cell_index_cc), .valid(valid_from_checker), .board_flat(board_flat));
sudoku_controller SC (.clk(clk), .rst(rst), .start(start), .valid_from_checker(valid_from_checker), .data_out_mem(data_out_mem), .read_en(read_en), .write_en(write_en), .done(done), .unsolvable(unsolvable), .cell_index(cell_index_mem), .cell_index_to_checker(cell_index_cc), .data_in_mem(data_in_mem), .num_to_checker(num_to_checker));

function [3:0] get_puzzle_value;
    input [6:0] index;
    begin
        case (index)
            0: get_puzzle_value = 5; 1: get_puzzle_value = 3; 2: get_puzzle_value = 0;
            3: get_puzzle_value = 0; 4: get_puzzle_value = 7; 5: get_puzzle_value = 0;
            6: get_puzzle_value = 0; 7: get_puzzle_value = 0; 8: get_puzzle_value = 0;
            9: get_puzzle_value = 6; 10: get_puzzle_value = 0; 11: get_puzzle_value = 0;
            12: get_puzzle_value = 1; 13: get_puzzle_value = 9; 14: get_puzzle_value = 5;
            15: get_puzzle_value = 0; 16: get_puzzle_value = 0; 17: get_puzzle_value = 0;
            default: get_puzzle_value = 0; 
        endcase
    end
endfunction

task print_board;
    integer r, c;
    reg [3:0] val;
    begin
        $display("Current Board:");
        for (r = 0; r < 9; r = r + 1) begin
            for (c = 0; c < 9; c = c + 1) begin
                val = board_flat[(r*9+c)*4 +: 4];
                if (val == 0)
                    $write(". ");
                else if (val >= 1 && val <= 9)
                    $write("%0d ", val);
                else
                    $write("X ");
            end
            $write("\n");
        end
        $display("");
    end
endtask

always @(posedge clk) begin
    if (!init_mode && start && (write_en || SC.state != SC.IDLE)) begin
        if (write_en) begin
            $display("Time %0t: WRITE cell[%0d] = %0d", $time, cell_index_mem, data_in_mem);
        end
    end
end

integer i, step_count;
initial begin
    init_mode = 1;
    init_addr = 0;
    init_data = 0;
    init_write = 0;
    rst = 1; 
    start = 0;
    step_count = 0;
        
    #20 rst = 0;

        // Load simplified puzzle
    $display("Loading puzzle...");
    for (i = 0; i < 18; i = i + 1) begin
        init_addr = i;
        init_data = get_puzzle_value(i);
        init_write = 1;
        #10;
        init_write = 0;
        #10;
    end
        
    init_mode = 0;
    #20;

    $display("=== INITIAL PUZZLE ===");
    print_board();

    $display("=== STARTING SOLVER ===");
    start = 1;
    #10 start = 0;

        // Wait for completion or timeout
    while (!done && !unsolvable && step_count < 1000) begin
        #100;
        step_count = step_count + 1;
        if (step_count % 50 == 0) begin
            $display("=== STEP %0d ===", step_count);
            print_board();
        end
    end

    if (done) begin
        $display("=== SOLVED! ===");
        print_board();
    end else if (unsolvable) begin
        $display("=== UNSOLVABLE ===");
    end else begin
        $display("=== TIMEOUT ===");
    end

    $stop;
end

endmodule