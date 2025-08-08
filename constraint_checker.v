module constraint_checker (num_to_place, cell_index, valid);

input [3:0] num_to_place;
input [6:0] cell_index;
reg [3:0] board [0:80];
output reg valid;     

integer row, col;
integer index;
integer start_row, start_col;
integer i, j;

always @(*) begin

    row = (cell_index) / 9;
    col = (cell_index) % 9;

//  For ROW checking
    for (integer i = 0; i < 9; i = i + 1) begin
        index = row*9 + i;
        if((board[index] == num_to_place) && index!= cell_index) begin
            valid = 0;
        end
    end

//  For COLUMN checking
    for (integer i = 0; i < 9; i = i + 1) begin
        index = i*9 + col;
        if((board[index] == num_to_place) && index!= cell_index) begin
            valid = 0;
        end
    end

    start_row = (row / 3)*3;
    start_col = (col / 3)*3;

//  For 3x3 box checking
    for (i = start_row; i < start_row + 3; i = i + 1) begin
        for (j = start_col; j < start_col + 3; j = j + 1) begin
            index = i*9 + j;
            if((board[index] == num_to_place) && index!= cell_index) begin
                valid = 0;
        end
    end
end






end



endmodule