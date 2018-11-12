
`timescale 1ns/1ns
module tb_ALU_total;
	reg[4:0] Sel;
	reg Carryin; 
	reg[7:0] A,B;
	wire [7:0] Y;
	wire [7:0] ALU_NoShift;
	integer i;
	
ALU_total ALU_total_1 (.Sel(Sel),.Carryin(Carryin),.A(A),.B(B),.Y(Y),.ALU_NoShift(ALU_NoShift));
	always #100 A=A+2;
	always #100 B=B+1;
	
	initial begin 
	Sel=0;A=1;B=1; Carryin=0;
	#50 A=A+8'b1000_0001;
	#450 Carryin=1;
	#100 Carryin=0;
	#150 Carryin=1;
	#50 Carryin=0;
	end
	
	always
	begin
	for (i=0;i<32;i=i+1)
	#50 Sel =Sel+1;
	end
endmodule 
