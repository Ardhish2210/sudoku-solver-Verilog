module board_memory (clk, rst, read_en, write_en, cell_index, data_in, data_out);

input clk, rst, read_en, write_en;
input [6:0] cell_index;
input [3:0] data_in;
output reg [3:0] data_out;

always @(posedge clk or negedge rst) begin
  if(rst) begin
    read_en <= 0;
    write_en <=0;
  end
end
    
endmodule