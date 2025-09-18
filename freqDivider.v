module downCounter(clk, rst, base, carry);
	parameter n = 1;
	input clk, rst;
	input [n-1:0] base;
	reg [n-1:0] out;
	output carry;
	
	always @(posedge clk, posedge rst) begin
		if (rst) begin
			out <= base -1;
		end
		else begin
			if (out==0)begin
				out = base - 1;
			end
			else begin
				out = out - 1;
			end
		end
	end
	assign carry = &(~out);

endmodule

module freqDiv(clk, rst, load, msb, cnt, out);
	parameter n = 9;
	input clk;
	input rst;
	input load;
	input [2:0] cnt;
	input msb;
	output reg out;
	wire carry;
	
	
	downCounter #(n) count(clk, rst,{msb, cnt, 5'b0}, carry);
	
	
	always @(posedge clk, posedge rst) begin
		if(rst)begin
			out = 0;
		end
		else if (carry)begin
			out = ~out;
		end
	end
	
endmodule