module FSM1_GOOD (Clock, Reset, SlowRAM, Read, Write);
  
  input Clock, Reset, SlowRAM;
  output Read, Write;
  
  reg Read, Write;
  
  parameter [1:0] ST_Read = 0, ST_Write = 1, ST_Delay = 2;
  reg [1:0] CurrentState, NextState;
  
  always @(posedge Clock)
    begin: SEQ
      if(Reset)
        CurrentState = ST_Read;
      else
        CurrentState = NextState;
    end
    
  always @(CurrentState)
    begin: COMB
      case (CurrentState)
        ST_Read:
          begin
            Read = 1;
            Write = 0;
            NextState = ST_Write;
        end
        ST_Write:
        begin
          Read = 0;
          Write = 1;
          if(SlowRAM)
            NextState = ST_Delay;
        else
          NextState = ST_Read;
      end
      ST_Delay:
      begin
          Read = 0;
          Write = 0;
          NextState = ST_Read;
        end
      default
      begin
          Read = 0;
          Write = 0;
          NextState = ST_Read;
        end
    endcase
  end
endmodule
            
