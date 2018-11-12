`timescale 1ns/1ns

module tb_Decoder;

reg[2:0] A;
wire[7:0] y;

Decoder Decoder_1 (.A(A), .Y(Y));

always #50 A[0]=~A[0];
always #100 A[1]=~A[1];
always #150 A[2]=~A[2];

initial begin
A[2:0]=0;
end
endmodule