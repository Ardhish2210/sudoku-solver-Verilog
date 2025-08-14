module sudoku_controller (clk, rst, start, valid_from_checker, data_out_mem, read_en, write_en, 
done, unsolvable, cell_index, cell_index_to_checker, data_in_mem, num_to_checker);

input clk, rst, start, valid_from_checker;
input [3:0] data_out_mem;
output reg read_en, write_en, done, unsolvable;
output reg [6:0] cell_index, cell_index_to_checker;
output reg [3:0] data_in_mem, num_to_checker;

reg [3:0] state, next_state;
reg [3:0] try_num, next_try_num;
reg [6:0] next_cell_index;
reg [6:0] backtrack_stack [0:80];
reg [6:0] next_sp, sp; 
    
reg next_read_en, next_write_en;
reg next_done, next_unsolvable;
reg [6:0] next_cell_index_to_checker;
reg [3:0] next_data_in_mem, next_num_to_checker;

parameter IDLE = 4'b0000, READ_CELL = 4'b0001, CHECK_CELL = 4'b0010, TRY_NUMBER = 4'b0011, VALIDATE = 4'b0100, PLACE_NUMBER = 4'b0101,
NEXT_CELL = 4'b0110, BACKTRACK_PREP = 4'b0111, BACKTRACK_CLEAR = 4'b1000, BACKTRACK_RESTORE = 4'b1001, DONE_STATE = 4'b1010, UNSOLVABLE_STATE = 4'b1011;

always @(posedge clk) begin
    if (rst) begin
        state <= IDLE;
        cell_index <= 7'd0;
        try_num <= 4'd1;
        sp <= 7'd0;
        read_en <= 1'b0;
        write_en <= 1'b0;
        done <= 1'b0;
        unsolvable <= 1'b0;
        cell_index_to_checker <= 7'd0;
        data_in_mem <= 4'd0;
        num_to_checker <= 4'd1;
    end else begin
        state <= next_state;
        cell_index <= next_cell_index;
        try_num <= next_try_num;
        sp <= next_sp;
        read_en <= next_read_en;
        write_en <= next_write_en;
        done <= next_done;
        unsolvable <= next_unsolvable;
        cell_index_to_checker <= next_cell_index_to_checker;
        data_in_mem <= next_data_in_mem;
        num_to_checker <= next_num_to_checker;
    end
end

always @(*) begin
    next_state = state;
    next_cell_index = cell_index;
    next_try_num = try_num;
    next_sp = sp;
    next_read_en = 1'b0;
    next_write_en = 1'b0;
    next_done = done;
    next_unsolvable = unsolvable;
    next_cell_index_to_checker = cell_index_to_checker;
    next_data_in_mem = data_in_mem;
    next_num_to_checker = num_to_checker;

    case (state)
        IDLE: begin
            if (start) begin
                next_state = READ_CELL;
                next_cell_index = 7'd0;
                next_try_num = 4'd1;
                next_sp = 7'd0;
                next_done = 1'b0;
                next_unsolvable = 1'b0;
            end
        end

        READ_CELL: begin
            next_read_en = 1'b1;
            next_state = CHECK_CELL;
        end

        CHECK_CELL: begin
            if (cell_index >= 81) begin
                next_state = DONE_STATE;
                next_done = 1'b1;
            end else if (data_out_mem != 0) begin
                next_state = NEXT_CELL;
            end else begin
                next_state = TRY_NUMBER;
                next_try_num = 4'd1;
            end
        end

        TRY_NUMBER: begin
            if (try_num > 9) begin                    
                next_state = BACKTRACK_PREP;
            end else begin
                next_state = VALIDATE;
                next_cell_index_to_checker = cell_index;
                next_num_to_checker = try_num;
            end
        end

        VALIDATE: begin
            if (valid_from_checker) begin
                next_state = PLACE_NUMBER;
                next_data_in_mem = try_num;
            end else begin
                next_try_num = try_num + 1;
                next_state = TRY_NUMBER;
            end
        end

        PLACE_NUMBER: begin
            next_write_en = 1'b1;                
            next_sp = sp + 1;
            next_state = NEXT_CELL;
        end

        NEXT_CELL: begin
            next_cell_index = cell_index + 1;
            next_try_num = 4'd1;
            next_state = READ_CELL;
        end

        BACKTRACK_PREP: begin
            if (sp == 0) begin                    
                next_state = UNSOLVABLE_STATE;
                next_unsolvable = 1'b1;
            end else begin
                next_sp = sp - 1;
                next_cell_index = backtrack_stack[sp - 1];
                next_state = BACKTRACK_CLEAR;
            end
        end

        BACKTRACK_CLEAR: begin                    
            next_write_en = 1'b1;
            next_data_in_mem = 4'd0;
            next_state = BACKTRACK_RESTORE;
        end

        BACKTRACK_RESTORE: begin
            next_read_en = 1'b1;
            next_state = TRY_NUMBER;
            next_try_num = data_out_mem + 1;
        end

        DONE_STATE: begin
            next_done = 1'b1;
        end

        UNSOLVABLE_STATE: begin
        next_unsolvable = 1'b1;
        end
    endcase
end

always @(posedge clk) begin
    if (rst) begin
    end else if (state == PLACE_NUMBER) begin
        backtrack_stack[sp] <= cell_index;
    end
end

endmodule