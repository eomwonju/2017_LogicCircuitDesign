`timescale 1ns/1ns
 module tb_FSM_MEALY;
 
 reg Clock, Reset;
 reg Red, Green, Blue;
 wire NewColor;
 
 FSM_MEALY FSM_MEALY_U1 (.Clock(Clock),.Reset(Reset),.Red(Red),.Green(Green),.Blue(Blue),.NewColor(NewColor));
 initial Clock=1'b0;
 always #50 Clock=~Clock;
 
 initial
 begin
 Reset=1'b1; Red=1'b0; Green=1'b0; Blue=1'b1;
 #50 Green=1'b1;
 #50 Red=1'b1;
 #50 Green=1'b0; Blue=1'b0;
 #50 Red=1'b0;
 #50 Green=1'b1;
 #100 Blue=1'b1;
 #50  Reset=1'b0; 
 Blue=1'b0;
 #50  Green=1'b0;
 #100 Red=1'b1;
 #50 Green=1'b1; Blue=1'b1;
 #50 Red=1'b0;
 #100 Green=1'b0; Blue=1'b0;
 #100 Green=1'b1;
 #50 Green=1'b0; Blue=1'b1;
 #50 Blue=1'b0;
 end
 endmodule
