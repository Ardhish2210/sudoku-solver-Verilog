module constraint_checker (num_to_place, cell_index, board, valid);

input [3:0] num_to_place;
input [6:0] cell_index;
input [3:0] board [0:80];
output valid;     

row = cell_index/9;
col = (cell_index % 9);


endmodule