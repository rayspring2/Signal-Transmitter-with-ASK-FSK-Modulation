`timescale 1ns/1ns

module top_tb();
    logic clk, rst, send;
    logic [2:0] cnt;
    logic [4:0] msg;
    logic mode;
    wire out;

    top top(clk, rst, send, cnt, msg, mode, out);
    initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end

    initial begin
        rst = 1;
        msg = 5'b11010;
        cnt = 0;
        mode = 0;
        #5;
        rst = 0;

        #2;
        send = 1;


	#3000;
	#100 $stop;
    end

endmodule