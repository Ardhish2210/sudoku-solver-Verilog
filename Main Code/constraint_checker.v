module constraint_checker (num_to_place, cell_index, valid, board_flat);

input [3:0] num_to_place;
input [6:0] cell_index;
input [323:0] board_flat;
output reg valid;     
reg [3:0] cell_val;

integer row, col;
integer index;
integer start_row, start_col;
integer i, j;

always @(*) begin
    row = (cell_index) / 9;
    col = (cell_index) % 9;
    valid = 1'b1;

    // Row checking
    for (i = 0; i < 9; i = i + 1) begin
        index = row*9 + i;
        cell_val = board_flat[index*4 +: 4];
        if((cell_val == num_to_place) && index != cell_index) begin
            valid = 1'b0;
        end
    end

    // Column checking
    for (i = 0; i < 9; i = i + 1) begin
        index = i*9 + col;
        cell_val = board_flat[(index*4) +: 4];
        if((cell_val == num_to_place) && index != cell_index) begin
            valid = 1'b0;
        end
    end

    start_row = (row / 3)*3;
    start_col = (col / 3)*3;

    // 3x3 box checking
    for (i = start_row; i < start_row + 3; i = i + 1) begin
        for (j = start_col; j < start_col + 3; j = j + 1) begin
            index = i*9 + j;
            cell_val = board_flat[(index*4) +: 4];
            if((cell_val == num_to_place) && index != cell_index) begin
                valid = 1'b0;
            end
        end
    end
end
endmodule