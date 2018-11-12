`define  TAP5 5'b10010

`define  TAPS  `TAP5

module LFSR_nbit(Clock, Reset, Y);
 parameter  Width = 5;
 
 input  Clock, Reset;
 output  [Width - 1:0] Y;
 wire  [Width - 1:0] Taps;
 
 integer  N;
 
 reg  Bits0_Nminus1_Zero, Feedback;
 reg  [Width - 1:0] LFSR_Reg, Next_LFSR_Reg;
assign   Taps[Width - 1:0] = `TAPS;

always@(negedge Reset or posedge Clock)
 begin : LFSR_Register
  if(!Reset)
   LFSR_Reg = 0;
  else
   LFSR_Reg = Next_LFSR_Reg;
 end

always@(LFSR_Reg)

 begin : LFSR_Feedback
  
  Bits0_Nminus1_Zero = ~| LFSR_Reg[Width - 2:0];
  Feedback = LFSR_Reg[Width-1] ^Bits0_Nminus1_Zero;
  
 for(N=Width-1;N>=1;N=N-1)
  if(Taps[N-1] == 1)
   Next_LFSR_Reg[N] = LFSR_Reg[N-1]^Feedback;
  else
   Next_LFSR_Reg[N] = LFSR_Reg[N-1];
 Next_LFSR_Reg[0] = Feedback;
 
 end
 
 assign Y = LFSR_Reg;
endmodule
