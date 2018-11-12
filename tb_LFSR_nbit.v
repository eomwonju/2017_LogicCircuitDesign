`timescale 1ns/1ns
module tb_LFSR_nbit;
reg Clock;
reg Reset;
wire[4:0] Y;
LFSR_nbit LFSR_nbit_1(.Clock(Clock),.Reset(Reset),.Y(Y));
always #100 Clock=~Clock;
initial begin
Reset=0; Clock=1;
#50 Reset=1;
end
endmodule