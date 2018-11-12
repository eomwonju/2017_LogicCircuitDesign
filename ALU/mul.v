
module MUL(sel, clock, reset, CarryIn, multiplicand, multiplier, done, product);
    parameter W_multiplicand = 11, W_multiplier = 11, W_count = 4;
    input clock, reset;
    input [W_multiplicand-1:0] multiplicand;
    input [W_multiplier-1:0] multiplier;
    input [5:0] sel;
    input CarryIn;
    output done;
    output [W_multiplicand + W_multiplier -1:0] product;
    reg [W_multiplicand-1:0] Reg_A;
    reg [W_multiplicand-1:0] Reg_B;
    reg [W_multiplier-1:0] Reg_Q;
    reg E;
    reg [W_multiplicand + W_multiplier -1:0] temp;
    reg add_shift_B;
    reg [W_count-1:0] sequencecount;
    reg comp_flag, load_flag, delay, set;
    reg done;
    reg [13:0] cnt;
    wire CarryIn;
    reg Mul_Load=0;
    reg delay1, delay2;
    reg Load;
    integer i;
     
     
    always @(posedge clock)
    begin
    if(sel[5:0]==6'b100000)
    begin
    Load <= CarryIn;
    delay1 <= Load;
    delay2 <= delay1;
    
       if(delay1 == 1 && delay2 == 0)
       begin
           Mul_Load <= 1;
       end
       else Mul_Load <= 0;
    end
    end 

  
      //Shift and multiplier
      always@(posedge clock)
      begin : SHIFT_ADD_MULT
          //synchronous reset
          if(!reset)
          begin
              Reg_A = 0;
              Reg_B = 0;
              Reg_Q = 0;
              E = 0;
              add_shift_B = 0;
              comp_flag = 0;
              sequencecount = W_multiplier-1;
              done = 0;
              load_flag=0;
              delay = 0;
              set = 0;
              temp=0;
          end
          
          else
          if(sel[5:0] == 6'b100000)
          begin
             if(Load)
             begin
                 if(!load_flag)
                   begin
                       //-------------------------------- delay   
                         if(!set)  begin
                             cnt<=0;
                             set=1;
                           end
                           else if(cnt==16000)begin  //12499
                                delay = 1;
                            end
                           else
                              cnt<=cnt+1;
                        //--------------------------------
                         if(delay)begin  
                                comp_flag = 0;
                                Reg_A = 0;   
                                         if(multiplicand[10] == 1)         //sign bit=1 => convert positive number
                                                     begin
                                                      for(i=0; i<W_multiplicand; i=i+1)
                                                          Reg_B[i] = ~multiplicand[i];
                     
                                                       Reg_B = Reg_B + 1'b1;
                                                      comp_flag = ~comp_flag;
                                                     end
                                         else
                                                   Reg_B = multiplicand[W_multiplicand-1:0];
              
                                         if(multiplier[10] == 1)          //sign bit=1 => convert positive number
                                                   begin
                                                      for(i=0; i<W_multiplier; i=i+1)
                                                         Reg_Q[i] = ~multiplier[i];
                                                      Reg_Q = Reg_Q + 1'b1;
                                                      comp_flag = ~comp_flag;
                                                   end
                                          else
                                                    Reg_Q = multiplier[W_multiplier-1:0];  
                     
                       E=0;
                       add_shift_B = multiplier[0];      //LSB of multiplier is control signal which determines shfit
                       sequencecount = W_multiplier-1;
                       done = 0;
                       load_flag=1;
                       end
                end
                else
                  if(add_shift_B && done==0)         //add
                      begin
                          {E,Reg_A} = Reg_A + Reg_B;
                          add_shift_B = 0;
                      end
                else if(done==0)                        //shift
                begin
                          {E, Reg_A, Reg_Q} = {E, Reg_A, Reg_Q} >> 1;
                          if(Reg_Q[0])
                                add_shift_B = 1;
                          else
                                add_shift_B = 0;
              
                          if(sequencecount == 0)
                              done = 1;
                          else
                              sequencecount = sequencecount - 1;
                  end
                  else 
                      begin
                            temp = {Reg_A, Reg_Q};
                            if(comp_flag)                 // determine the sign of output
                                      begin
                                          for(i=0; i< 22; i=i+1)
                                              temp[i] = ~temp[i];
                                          temp = temp + 1'b1;
                                      end
                           load_flag=0;
                      end
             end
         end
         
     end
     assign product = temp;   
  endmodule
