module tb_GCD();
parameter width=11;
reg clock,reset,load;
reg[width-1:0] A,B;
wire done;
wire[width-1:0] Y;
GCD GCD_U0(clock,reset,load,A,B,done,Y);

always #50 clock = ~clock;

initial begin
clock=1'b1;
reset=1'b0;
load=1'b0;
A=11'd280;
B=11'd30;
#150 reset = 1'b1;
#100 load = 1'b1;
#200 load = 1'b0;
end 
endmodule 