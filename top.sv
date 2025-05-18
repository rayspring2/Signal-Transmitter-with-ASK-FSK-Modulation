module top(
    input clk, 
    input rst,
    input send, 
    input [2:0] cnt,
    input [4:0] msg,
    input mode

);
    wire freq_one, freq_half;
    freqDiv one(clk, rst, send, 1'b1, cnt, freq_one);
    freqDiv half(clk, rst, send, 1'b0, cnt, freq_half);

    wire freq;
    wire SerOut;
    wire ddsout;
    assign freq =  (SerOut) ? freq_one : freq_half;
    messageProcess_TOP messageProcess_TOP(freq_one, rst, send, msg, SerOut);
    dds dds(freq, rst, ddsout);

    wire sel;
    assign sel = mode| SerOut;
    pwm pwm(clk, rst, (sel)? ddsout : 9'd0 , out);

endmodule