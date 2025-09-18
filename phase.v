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
    output reg p, s;

	localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;
	
	reg [1:0] ps, ns;
	
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