`timescale 1ns/1ns
module comp(in , out);

    parameter n = 6;
    input [n-1:0] in;
    output [n-1:0] out;
    assign out = ~in + 1;

endmodule

module mux(sel, in1, in2, out);
    parameter n = 6;
    input sel;
    input [n-1:0] in1, in2;

    output [n-1:0] out;
    assign out = sel? in2: in1; 


endmodule
module SignToComp (sign, in, out);
    parameter n = 8;
    input sign;
    input [n-1:0] in;
    output [n-1:0] out;

    assign out = sign? (~in + 1): in;
    
endmodule
module ROM(in, out);

    input [5:0] in;
    output [7:0] out;
    reg[7:0] rom[0:63];

    initial begin
        $readmemb("sine.mem", rom);
    end
    assign out = rom[in];

endmodule
module dds(clk, rst, out);
    input clk, rst;
    wire p, s;
    wire [5:0] cnt;
    wire [5:0] cntcmp;
    wire [5:0] add;
    wire [7:0] value;
    wire [7:0] mag;
    wire sel;
    output [7:0] out;

    phase_Top phase(clk, rst, cnt, p, s);
    comp #(6) compl(cnt, cntcmp);
    mux #(6) mux1(p, cnt, cntcmp, add);

    ROM sinROM(add, value);

    assign sel = (~(|cnt)) & p;  
    mux #(8) mux2(sel, value, 8'b11111111, mag);
    SignToComp scmp(s, mag, out);

endmodule