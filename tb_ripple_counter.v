`timescale 1ns/1ns

module tb_ripple_counter;

reg Clock, Reset;
wire Y;
reg Div2, Div4, Div8, Div16;

ripple_counter ripple_counter_1 (Clock, Reset, Y);

always # 10 Clock=~Clock;

initial begin 
Reset=0; Clock=0;
#5 Reset=1;
end

endmodule
