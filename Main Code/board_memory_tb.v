`timescale 1ns/1ns
`include "board_memory.v"

module board_memory_tb; 

reg clk, rst, read_en, write_en;
reg [6:0] cell_index;
reg [3:0] data_in;
wire [3:0] data_out;
wire [323:0] board_flat;

board_memory uut (clk, rst, read_en, write_en, cell_index, data_in, data_out, board_flat);

always #5 clk = ~clk;

initial begin
    $dumpfile("board_memory.vcd");
    $dumpvars(0, board_memory_tb);

    $monitor("clk: %0b || rst: %0b || read_en: %0b || write_en: %0b || data_in: %0d || cell_index: %0d || data_out: %0d", clk, rst, read_en, write_en, data_in, cell_index, data_out);

    clk = 0;
    rst = 1;
    #8 rst = 0;

    // Write Phase
    #2  write_en = 1; data_in = 1; cell_index = 3;
    #10 write_en = 1; data_in = 6; cell_index = 23;
    #10 write_en = 1; data_in = 4; cell_index = 30;
    #10 write_en = 0;

    // Read Phase
    #5  read_en = 1; cell_index = 3;
    #10 read_en = 1; cell_index = 23;
    #10 read_en = 1; cell_index = 30;
    #10 $finish;
    
end
endmodule