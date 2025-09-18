`timescale 1ns/1ns
module one_Pulser(input clk, input rst, input clk_PB, output reg clk_EN);
	localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
	reg [1:0] ps, ns;
	always@(posedge clk, posedge rst)begin
		if(rst)
			ps <= A;
		else
			ps <= ns;
	
	end
	
	always@(*)begin
		case (ps)
			A: begin
				if(clk_PB)
					ns <= B;
				else
					ns <= A;
			end
			
			B: begin
				ns <= C;
			end
			C:begin
				if(clk_PB)
					ns <= C;
				else
					ns <= A;
			end
		endcase	
			
	end
	
	always@(*)begin
		clk_EN = 0;
		case (ps)
			B:
			clk_EN = 1; 
		endcase
		
	end
	
	

endmodule