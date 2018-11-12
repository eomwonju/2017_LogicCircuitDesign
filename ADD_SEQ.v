module ADD_SEQ (Clock, Reset, ParaLoad, CoeffData, SerialIn, EnableShiftAdd, ShiftRegA, ShiftRegB, ParallelOut);
input Clock, Reset;
input ParaLoad, SerialIn, EnableShiftAdd;
input [7:0] CoeffData;
output [7:0] ParallelOut;
output [7:0] 
ShiftRegA,ShiftRegB;
reg [7:0] ParallelOut;
reg ShiftRegA_LSB;
reg [7:0] ShiftRegA, ShiftRegB;
reg HoldCout;
wire Sum,Cout;
always @(negedge Reset)
begin
ShiftRegA<=8'b0;ShiftRegB<=8'b0;
end
always @(posedge Clock)
begin: REG_AB
if (ParaLoad)
ShiftRegA = CoeffData;
else if (EnableShiftAdd)
begin
ShiftRegA_LSB = ShiftRegA[0];
ShiftRegA = ShiftRegA >> 1;
ShiftRegA[7] = ShiftRegA_LSB;
end
if (EnableShiftAdd)
begin
ShiftRegB = ShiftRegB >> 1;
ShiftRegB[7] = Sum;
ParallelOut = ShiftRegB;
end
end
FULL_ADD FA1
(.A(SerialIn),.B(ShiftRegA[0]),.Cin(HoldCout),.Sum(Sum),.Cout(Cout));
always @(posedge Clock or negedge Reset)
begin : HOLD_COUT
if (!Reset)
HoldCout = 0;
else if (EnableShiftAdd)
HoldCout = Cout;
else
HoldCout = HoldCout;
end 
endmodule

module HALF_ADD (A, B, Sum, Cout);
input A,B;
output Sum, Cout;
assign Sum = A ^ B;
assign Cout = A & B;
endmodule

module FULL_ADD (A, B, Cin, Sum, Cout);
input A,B, Cin;
output Sum, Cout;

wire AplusB, CoutHA1, CoutHA2;

HALF_ADD HA1 (.A(A), .B(B), .Sum(AplusB), .Cout(CoutHA1));
HALF_ADD HA2 (.A(AplusB), .B(Cin), .Sum(Sum), .Cout(CoutHA2));

assign Cout = CoutHA1 | CoutHA2;
endmodule