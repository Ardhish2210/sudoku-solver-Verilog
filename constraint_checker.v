module constraint_checker (num_to_place, cell_index, board, valid);

input [3:0] num_to_place;
input [6:0] cell_index;
input [3:0] board [0:80];
output valid;     

assign row = cell_index/9;
assign col = (cell_index % 9);

always @(*) begin
    for (integer i = 0; i < 9; i = i + 1) begin // i = ROW
        for(integer j = 0; j < 9; j = j + 1) begin // j = COLUMN
            integer index = i * 9 + j;
            if((board[index] == num_to_place) && (index != cell_index)) begin
                valid = 0;
            end else begin
                valid = 1;
            end
        end
    end
end


endmodule