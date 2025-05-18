`timescale 1ns/1ns
module counter(clk, rst, out, carry);
	parameter n = 1;
	input clk, rst;
	output logic [n-1:0] out;
	output logic carry;
	
	always @(posedge clk, posedge rst) begin
		if (rst) begin
			out <= 0;
			// carry <= 0;
		end
		else begin
			out = out + 1;
		end
	end
	assign carry = &out;
endmodule
module phase_Top(clk, rst, cnt, p, s);

    input clk, rst;
    output p,s;
    output [5:0] cnt;
    wire carry;

    counter #(6) c(clk, rst, cnt, carry);
	phase_FSM fsm(clk, rst, carry, p, s);

endmodule


module phase_FSM(clk, rst, carry, p, s);
    input clk, rst, carry;
    output logic p, s;

	typedef enum logic [1:0]{A, B, C, D} state;
	state ps, ns;
	
	always @(posedge clk, posedge rst)begin
		if(rst)
			ps <= A;
		else
			ps <= ns;
	end
	
	always@(*) begin
		
		
		case(ps)
			A: begin
				if(~carry)
					ns <= A;
				else
					ns <= B;
			end
			
			B: begin
				if(~carry)
					ns <= B;
				else
					ns <= C;
			end
			
			C: begin
				if(~carry)
					ns <= C;
				else
					ns <= D;
			end
			
			D: begin
				if(~carry)
					ns <= D;
				else
					ns <= A;
			end
					
		endcase
	
	end
	
	
	always@(*)begin
		case(ps)
			A: begin
                p = 0;
                s = 0;
			end
			
			B: begin
				p = 1;
                s = 0;
			end
			
			C: begin
				p = 0;
                s = 1;
			end
            D:begin
                p = 1;
                s = 1;
			end 
					
		endcase
	end
endmodule