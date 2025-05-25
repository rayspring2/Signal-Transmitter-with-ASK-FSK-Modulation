module top(
    input clk, 
    input rst,
    input send, 
    input [2:0] cnt,
    input [4:0] msg,
    input mode,
    output out

);
    wire freq_one, freq_half;
    freqDiv one(clk, rst, 0, 1'b1, cnt, freq_one);
    freqDiv half(clk, rst, 0, 1'b0, cnt, freq_half);

    wire freq;
    wire SerOut;
    wire [7:0] ddsout;
    assign freq =  (SerOut) ? freq_one : freq_half;
    messageProcess_TOP messageProcess_TOP(freq_one, rst, send, msg, SerOut);
    dds dds(freq, rst, ddsout);

    wire sel;
    assign sel = mode| SerOut;
    wire [7:0] pwm_input;
    assign pwm_input = (sel)? ddsout : 8'd128;
    pwm pwm(clk, rst,  pwm_input, out);

endmodule