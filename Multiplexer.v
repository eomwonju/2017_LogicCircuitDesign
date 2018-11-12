module Multiplexer(Sel,A,B,C,D,Y);

input [1:0] Sel;
input A,B,C,D;
output Y;

reg Y;

always @(Sel or A or B or C or D)
if(Sel[1]==0)
if(Sel[0]==0)
Y=A;
else
Y=B;
else
if(Sel[0]==0)
Y=C;
else Y=D;

endmodule