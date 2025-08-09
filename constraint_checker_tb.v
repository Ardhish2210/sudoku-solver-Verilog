`timescale 1ns/1ns
`include "constraint_checker.v"

module constraint_checker_tb;

reg [3:0] num_to_place;
reg [6:0] cell_index;
reg [323:0] board_flat;
wire valid;

constraint_checker uut (num_to_place, cell_index, valid, board_flat);

integer r, c;

initial begin 
    $dumpfile("constrain_checker.vcd");
    $dumpvars(0, constraint_checker_tb);

    #5 board_flat = {324{1'b0}}; 
    num_to_place = 4'd5; 
    cell_index = 7'd0; 
    #1;
    print_board();

    #5 board_flat[4*3 +: 4] = 4'd5; 
    num_to_place = 4'd5; 
    cell_index = 7'd0; 
    #1;
    print_board();

    #5 board_flat = {324{1'b0}};
    board_flat[4*(0 + 9*2) +: 4] = 4'd5;
    num_to_place = 4'd5; 
    cell_index = 7'd0; 
    #1;
    print_board();

    #5 board_flat = {324{1'b0}};
    board_flat[4*(1 + 9*1) +: 4] = 4'd5;
    num_to_place = 4'd5; 
    cell_index = 7'd0; 
    #1;
    print_board();

    #10 $finish;
end

task print_board;
    begin
        $display("Time: %0t || num_to_place: %0d || cell_index: %0d || valid: %0b", 
                  $time, num_to_place, cell_index, valid);
        for (r = 0; r < 9; r = r + 1) begin
            for (c = 0; c < 9; c = c + 1) begin
                $write("%0d ", board_flat[((r*9 + c)*4) +: 4]);
            end
            $write("\n");
        end
        $display("");
    end
endtask

    
endmodule