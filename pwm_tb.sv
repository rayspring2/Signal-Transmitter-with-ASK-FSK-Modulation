`timescale 1ns/1ns

module pwm_tb();
    logic clk, rst;
    logic  out;
    logic [7:0] in;
    pwm pwm(clk, rst, in, out);
    initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end

    initial begin
        rst = 1;
        in = 7;
        #5;
        rst = 0;

	
	#10000 $stop;
    end

endmodule