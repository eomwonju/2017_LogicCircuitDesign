`timescale 1ns/1ns
module tb_Encoder;
reg [7:0] A;
wire Valid;
wire [2:0] Y;
Encoder Encoder_1 (.A(A), .Valid(Valid), .Y(Y));
initial begin
A=0;
#100 A[7]=1;
#100 A[7]=0;A[6]=1;
#100 A[6]=0;A[5]=1;
#100 A[5]=0;A[4]=1;
#100 A[4]=0;A[3]=1;
#100 A[3]=0;A[2]=1;
#100 A[2]=0;A[1]=1;
#100 A[1]=0;A[0]=1;
#100 A[0]=1;
$stop;
end
endmodule