module pwm(clk, rst, in , out);
    input clk, rst;
    input [7:0] in;
    wire [7:0] cnt;
    wire carry;
    output out;

    counter #(8) c(clk, rst, cnt, carry);
    assign out = (cnt<=in)? 1:0;
endmodule