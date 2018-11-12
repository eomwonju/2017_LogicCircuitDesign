`timescale 1ns/1ns
module tb_simpleFSM;

reg Clock, Reset, SlowRAM;
wire  Read, Write;

FSM1_GOOD FSM1_GOOD_U0(.Clock(Clock),.Reset(Reset),
		.SlowRAM(SlowRAM),.Read(Read),.Write(Write));
		
		initial Clock=1'b0;						 
always #50 Clock=~Clock;

initial
begin
Reset=1'b1; SlowRAM=1'b0;
#100 Reset=1'b0;
#300 SlowRAM=1'b1;
#100 SlowRAM=1'b0;
end
endmodule