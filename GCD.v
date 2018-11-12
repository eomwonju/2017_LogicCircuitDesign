
module GCD(clock,reset,Sel,CarryIn,A,B,Y);

parameter width=11;
input[5:0] Sel;
input clock,reset,CarryIn;
input [width-1:0] A,B;
output [width-1:0] Y;

reg A_lessthan_B,done;
reg [width-1:0] A_new, A_hold, B_hold, Y;

reg delay1, delay2;
reg GCD_Load = 0;
wire [5:0] Sel;
wire CarryIn;
reg Load;


always@(posedge clock)

begin: LOAD_SWAP
if(!reset)
begin
A_hold=0;
B_hold=0;
end

else if(GCD_Load)
begin
A_hold=A;
B_hold=B;
end

else if(A_lessthan_B)
begin
A_hold=B_hold;
B_hold=A_new;
end
else
A_hold=A_new;
end


always@(A_hold or B_hold)
begin:SUBTRACT
if(A_hold>=B_hold)
begin
A_lessthan_B=0;
A_new=A_hold-B_hold;
end
else
begin
A_lessthan_B=1;
A_new=A_hold;
end
end


always@(A_hold or B_hold)
begin:WRITE_OUTPUT
if(B_hold==0)
begin
done=1;
Y=A_hold;
end
else
begin
done=0;
Y=0;
end
end 

always @(posedge clock)
    begin
    if(Sel[5:0]==6'b101_000)
    begin
    Load <= CarryIn;
    delay1 <= Load;
    delay2 <= delay1;
        if(delay1 == 1 && delay2 == 0)
            GCD_Load <= 1;
        else 
            GCD_Load <= 0;
    end
    end

endmodule