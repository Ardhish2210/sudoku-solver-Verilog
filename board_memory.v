module board_memory (clk, rst, read_en, write_en, cell_index, data_in, data_out);

input clk, rst, read_en, write_en;
input [6:0] cell_index;
input [3:0] data_in;
output reg [3:0] data_out;

reg [3:0] board [0:80]; // 9x9 Sudoku Solver

always @(posedge clk or negedge rst) begin
  if(rst) begin
    read_en <= 0;
    write_en <=0;
    cell_index <= 7'b0000000;
    data_in <= 4'b0000;
  end else begin
    
  end
end
    
endmodule