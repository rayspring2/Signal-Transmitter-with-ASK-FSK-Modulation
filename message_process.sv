`timescale 1ns/1ns

moduel messageProcess_TOP(
    input clk,
    input rst,
    input send,
    input [4:0] msg,
    output SerOut);

    
    counter #(4) counter4(clk, rst, out, carry);
    counter #(4) counter10(clk, rst, out, carry);
    


endmodule
