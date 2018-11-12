`timescale 1ns/1ns
module tb_Multiplexer;

reg [1:0] Sel;
reg A,B,C,D;
wire Y;

Multiplexer Multiplexer_1 (.Sel(Sel), .A(A), .B(B), .C(C), .D(D), .Y(Y));

always #100 A=~A;
always #200 B=~B;
always #300 C=~C;
always #400 D=~D;

initial begin
A=0; B=0; C=0; D=0;
Sel = 2'b00; #100;
Sel = 2'b01; #100;
Sel = 2'b00; #100;
Sel = 2'b10; #100;
Sel = 2'b00; #100;
Sel = 2'b11; #100;
Sel = 2'b01; #100;
Sel = 2'b00; #100;
Sel = 2'b10; #100;
Sel = 2'b00; #100;
Sel = 2'b11; #100;

$stop;

end
endmodule