module Encoder(A,Valid,Y);

input[7:0] A;
output Valid;
output [2:0] Y;

integer N;
reg Valid;
reg [2:0] Y;

always @(A)
begin
Valid=0;
Y=3'b X;

for(N=0;N<8;N=N+1)
if(A[N])
begin
Valid=1;
Y=N;
end
end
endmodule
