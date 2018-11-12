module Decoder(A,Y);

input [2:0] A;
output [7:0] Y;

reg[7:0] Y;
integer N;

always @(A)
begin
for(N=0;N<7;N=N+1)
if(A==N)
Y[N]=1;
else Y[N]=0;

end
endmodule