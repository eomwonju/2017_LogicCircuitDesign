`include "ALU_arith.v"
`include "ALU_logic.v"

module ALU_total(Sel,Carryin,A,B,Y,ALU_NoShift);

input [4:0] Sel;
input Carryin;
input [7:0] A,B;
output [7:0] Y;
output [7:0] ALU_NoShift; 
reg [7:0] Y;
reg [7:0] ALU_NoShift;
reg C,D;
wire [7:0] LogicUnit, ArithUnit;
ALU_logic M1 (Sel[1:0],A,B,LogicUnit);
ALU_arith M2 (Sel[1:0],Carryin,A,B,ArithUnit);

always @(Sel or A or B or Carryin or LogicUnit or ArithUnit)

	begin : ALU_PROC
	if (Sel[2])
		ALU_NoShift=LogicUnit;
	else 
		ALU_NoShift=ArithUnit;
		
	case (Sel[4:3])
		2'b 00 : Y=ALU_NoShift;
		2'b 01 : begin
			C=ALU_NoShift[7];
			Y=ALU_NoShift<<1;
			Y[0]=C;
			end
		2'b 10 : begin
			D=ALU_NoShift[0];
			Y=ALU_NoShift>>1;
			Y[7]=D;
			end
		2'b 11 : Y=8'b 0;
		default : Y=8'b X;
	endcase
end
endmodule
