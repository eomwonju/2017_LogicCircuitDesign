
`timescale 1ns/1ns
module tb_ALU_logic;
reg [1:0] Sel;
reg [7:0] A,B ;
wire [7:0] LogicUnit;

ALU_logic ALU_logic (.Sel(Sel),.A(A),.B(B),.LogicUnit(LogicUnit));

always #50 Sel=Sel+2'b01;
always #50 A=A+1;
always #50 B=B+1;

initial begin 
Sel=2'b00; A=0; B=0;
end
endmodule
