module GCD_LCM(clock,reset,GCD_Load,A,B,Y,L);
	parameter width=11;
	input clock,reset,GCD_Load;
	input [width-1:0] A,B;
	output [width-1:0] Y,L;
	reg A_lessthan_B,done;
	reg [width-1:0] A_new, A_hold, B_hold, Y, L;

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
		L = (A*B)/Y;
	  end
endmodule 

