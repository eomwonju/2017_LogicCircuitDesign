module ALU_arith(Sel, Carryin, A,B, ArithUnit);

input [1:0] Sel;
input Carryin;
input [7:0] A,B;
output [7:0] ArithUnit;

reg [7:0] ArithUnit;

always @(Sel or A or B or Carryin)
	case ({Sel[1:0],Carryin})
		3'b 000 : ArithUnit=A;
		3'b 001 : ArithUnit=A+1;
		3'b 010 : ArithUnit=A+B;
		3'b 011 : ArithUnit=A+B+1;
		3'b 100 : ArithUnit=A+ ~B;
		3'b 101 : ArithUnit=A-B;
		3'b 110 : ArithUnit=A-1;
		3'b 111 : ArithUnit=A;
		default : ArithUnit=8'b X;
	endcase
endmodule 
