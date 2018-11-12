
`timescale 1ns/1ns
module tb_ALU_arith;
reg [1:0] Sel;
reg Carryin;
reg [7:0] A,B;
wire [7:0] ArithUnit;

ALU_arith ALU_arith_1 (.Sel(Sel),.Carryin(Carryin),.A(A),.B(B),.ArithUnit(ArithUnit));

always #50 Sel=Sel+2'b01;
always #50 A=A+1;
always #50 B=B+2;

initial begin
Sel=2'b00; A=0; B=0; Carryin=0;

#450 Carryin=1;
#100 Carryin=0;
#150 Carryin=1;
#50 Carryin=0;
end
endmodule