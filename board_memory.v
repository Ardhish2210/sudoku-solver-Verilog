module board_memory (clk, rst, read_en, write_en, cell_index, data_in, data_out, board_flat);

input clk, rst, read_en, write_en;
input [6:0] cell_index;
input [3:0] data_in;
output reg [3:0] data_out;
output [323:0] board_flat; // This is the flattened version of the 9x9 sudoku board
integer k;

reg [3:0] board [0:80]; // 9x9 Sudoku Solver

always @(posedge clk or negedge rst) begin
  if(rst) begin
    for(k = 0; k < 81; k = k +1) begin
      board[k] <= 4'b0000;
    end
  end else begin
    if (write_en) begin
        board[cell_index] <= data_in;
    end else begin
        data_out <= board[cell_index]; 
    end
  end
end
  
genvar index;
generate 
  for(index = 0; index < 81; index = index + 1) begin: flatten_loop
    assign board_flat[index*4 +: 4] = board[index];
  end
endgenerate

endmodule