`timescale 1ns/1ns
 module tb_SAS;
 
 reg Clock, Reset;
 reg ParaLoad, SerialIn, EnableShiftAdd;
 reg [7:0] CoeffData;
 wire [7:0] ParallelOut;
 wire [7:0] ShiftRegA, ShiftRegB;
 
 ADD_SEQ ADD_SEQ_U1 (.Clock(Clock), .Reset(Reset), .ParaLoad(ParaLoad), .CoeffData(CoeffData), .SerialIn(SerialIn), .EnableShiftAdd(EnableShiftAdd), .ShiftRegA(ShiftRegA), .ShiftRegB(ShiftRegB), .ParallelOut(ParallelOut));
 initial
 Clock=1'b0;
 always
 #50 Clock=~Clock;
 
 initial begin
 Reset=1'b1; ParaLoad=1'b0; EnableShiftAdd=1'b0; SerialIn=1'b0; CoeffData=8'b01010110;
 #100 Reset=1'b0;
 #100 Reset=1'b1; ParaLoad=1'b1;
 #100 ParaLoad=1'b0; EnableShiftAdd=1'b1; SerialIn=1'b1;
 #100 SerialIn=1'b0;
 #100 SerialIn=1'b1;
 #200 SerialIn=1'b0;
 #200 SerialIn=1'b1;
 #100 SerialIn=1'b0;
 #100 EnableShiftAdd=1'b0;
 
 end
 endmodule
