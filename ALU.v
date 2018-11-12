
module ALU_logic(Sel,A,B,LogicUnit);

input [1:0] Sel;
input [7:0] A,B;
output [7:0] LogicUnit;

reg [7:0] LogicUnit;
always @(Sel or A or B)
	case (Sel[1:0])
		2'b 00 : LogicUnit=A&B;
		2'b 01 : LogicUnit=A|B;
		2'b 10 : LogicUnit=A^B;
		2'b 11 : LogicUnit=~A;
		default : LogicUnit =8'b X;
	endcase 
endmodule

