
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2014/07/28 14:57:38
// Design Name: 
// Module Name: textlcd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define lcd_blank 8'b00100000
`define lcd_dash 8'b00101101
`define lcd_colon 8'b00111010
`define lcd_comma 8'b00101100
`define lcd_Dot 8'b00101110
`define lcd_0 8'b00110000
`define lcd_1 8'b00110001
`define lcd_2 8'b00110010
`define lcd_3 8'b00110011
`define lcd_4 8'b00110100
`define lcd_5 8'b00110101
`define lcd_6 8'b00110110
`define lcd_7 8'b00110111
`define lcd_8 8'b00111000
`define lcd_9 8'b00111001
`define lcd_a 8'b01000001
`define lcd_b 8'b01000010
`define lcd_c 8'b01000011
`define lcd_d 8'b01000100
`define lcd_e 8'b01000101
`define lcd_f 8'b01000110
`define lcd_g 8'b01000111
`define lcd_h 8'b01001000
`define lcd_i 8'b01001001
`define lcd_j 8'b01001010
`define lcd_k 8'b01001011
`define lcd_l 8'b01001100
`define lcd_m 8'b01001101
`define lcd_n 8'b01001110
`define lcd_o 8'b01001111
`define lcd_p 8'b01010000
`define lcd_q 8'b01010001
`define lcd_r 8'b01010010
`define lcd_s 8'b01010011
`define lcd_t 8'b01010100
`define lcd_u 8'b01010101
`define lcd_v 8'b01010110
`define lcd_w 8'b01010111
`define lcd_x 8'b01011000
`define lcd_y 8'b01011001
`define lcd_z 8'b01011010
`define lcd_under 8'b01011111
`define lcd_s_a 8'b01100001
`define lcd_s_b 8'b01100010
`define lcd_s_c 8'b01100011
`define lcd_s_d 8'b01100100
`define lcd_s_e 8'b01100101
`define lcd_s_f 8'b01100110
`define lcd_s_g 8'b01100111
`define lcd_s_h 8'b01101000
`define lcd_s_i 8'b01101001
`define lcd_s_j 8'b01101010
`define lcd_s_k 8'b01101011
`define lcd_s_l 8'b01101100
`define lcd_s_m 8'b01101101
`define lcd_s_n 8'b01101110
`define lcd_s_o 8'b01101111
`define lcd_s_p 8'b01110000
`define lcd_s_q 8'b01110001
`define lcd_s_r 8'b01110010
`define lcd_s_s 8'b01110011
`define lcd_s_t 8'b01110100
`define lcd_s_u 8'b01110101
`define lcd_s_v 8'b01110110
`define lcd_s_w 8'b01110111
`define lcd_s_x 8'b01111000
`define lcd_s_y 8'b01111001
`define lcd_s_z 8'b01111010
`define add_line_1 8'b10000000
`define add_line_2 8'b11000000
`define add_line_3 8'b10010100
`define add_line_4 8'b11010100
module textlcd(
	resetn,
	lcdclk,
	alu_out_value,
	PB,
	Sel,
	in_switching,
	CarryIn,
	lcd_rs,
	lcd_rw,
	lcd_en,
	lcd_data,
	key_value_a,
	key_value_b
	);

input  resetn;
input  lcdclk;
input [11:0] alu_out_value;
input  [2:0] PB;
input  [5:0] Sel;
input in_switching;
input CarryIn;

output lcd_rs;
output lcd_rw;
output lcd_en;
output [7:0] lcd_data;
output [11:0] key_value_a;
output [11:0] key_value_b;

wire [31:0] reg_a;
reg [31:0] reg_b;
wire [31:0] reg_c;
reg [31:0] reg_d;
wire [31:0] reg_e;
wire [31:0] reg_f;
reg [31:0] reg_g;
reg [31:0] reg_h;
reg [23:0] delay_lcdclk; //clock
reg [15:0] count_lcd;
reg lcd_en;	       // Text-LCD Device enable signal 
reg  [4:0] lcd_mode = 0;
wire [4:0] mode_pwron = 1 ;  // power on
wire [4:0] mode_fnset = 2 ;  // function set
wire [4:0] mode_onoff = 3 ;  // display on/off Control
wire [4:0] mode_entr1 = 4 ;  // 
wire [4:0] mode_entr2 = 5 ;  // 
wire [4:0] mode_entr3 = 6 ;  // 
wire [4:0] mode_seta1 = 7 ;  // set addr 1st line
wire [4:0] mode_wr1st = 8 ;  // Write 1st line
wire [4:0] mode_seta2 = 9 ;  // set addr 2nd line
wire [4:0] mode_wr2nd = 10;  // Write 2nd line
wire [4:0] mode_delay = 11;  // dealy
wire [4:0] mode_actcm = 12;  // user command
reg [9:0] set_data;

wire [11:0] alu_out_value;

reg [11:0] temp_out_value;
reg [21:0] temp_out_mul_value;
reg [11:0] temp_a_1;
reg [11:0] temp_a_10;
reg [11:0] temp_a_100;
reg [11:0] temp_b_1;
reg [11:0] temp_b_10;
reg [11:0] temp_b_100;
reg [4:0] digit_6, digit_5, digit_4, digit_3, digit_2, digit_1;

reg [11:0] key_value_a;
reg [11:0] key_value_b;
assign reg_a = {`lcd_blank, `lcd_blank, `lcd_a, `lcd_dash } ;
assign reg_c = {`lcd_blank, `lcd_blank, `lcd_b, `lcd_dash } ;
assign reg_e = {`lcd_r, `lcd_e, `lcd_s, `lcd_u } ;
assign reg_f = {`lcd_l, `lcd_t, `lcd_dash, `lcd_dash } ;

reg [7:0] cnt_in_a1;
reg [7:0] cnt_in_b1;

reg [7:0] cnt_in_a10;
reg [7:0] cnt_in_b10;

reg [7:0] cnt_in_a100;
reg [7:0] cnt_in_b100;

// Counterx2000 & //Conterx40
always @(posedge lcdclk)
begin  
	if (resetn == 0)
	begin
		delay_lcdclk <= 0;
		count_lcd <= 0;
		lcd_en <= 1'b0;


	end
	else 
	begin
        // Counterx2000
		if (delay_lcdclk < 1999)
			delay_lcdclk <=  delay_lcdclk + 1;
		else
			delay_lcdclk <= 0;

			
        // Counterx40
		if (delay_lcdclk == 0) 
		begin
			if (count_lcd < 40)
				count_lcd <= count_lcd + 1;
			else
				count_lcd <= 6;
		end
	
		if (delay_lcdclk == 200)
			lcd_en <= 1'b1;
		else if (delay_lcdclk == 1800)
			lcd_en <= 1'b0;
                    
	end
end

always @(negedge PB[0] or negedge resetn)
begin

	    reg_b[31:24] = `lcd_dash;
		reg_d[31:24] = `lcd_dash;
		reg_g[31:24] = `lcd_dash;
		reg_g[23:16] = `lcd_dash;

		if(resetn == 0)
		begin
			cnt_in_a1 <= 0;
			cnt_in_b1 <= 0;
		end
		
		else if(in_switching==0)   // INPUT A -->> xx1 set
		begin
                    if(PB[0] ==0)
                    begin
                           cnt_in_a1 <= cnt_in_a1 + 1;   
                            if(cnt_in_a1 == 10) // // over cnt reset
                            cnt_in_a1<=0;
                    end
		
		end
		else begin
                   if(PB[0] ==0)  // INPUT B -->> xx1 set
                            begin
                                    cnt_in_b1 <= cnt_in_b1 + 1;
                                    if(cnt_in_b1 == 10)
                                     cnt_in_b1<=0;
                            end
        end
end





always @(negedge PB[1] or negedge resetn)
begin

		if(resetn == 0)
		begin
			cnt_in_a10 <= 0;
			cnt_in_b10 <= 0;
		
		end
		
		else if(in_switching==0)   // INPUT A -->> 10 set
		begin
                    if(PB[1] ==0)
                    begin
                           cnt_in_a10 <= cnt_in_a10 + 1;   
                            if(cnt_in_a10 == 10) // // over cnt reset
                            cnt_in_a10<=0;
                    end
		
		end
		else begin
                   if(PB[1] ==0)  // INPUT B -->> 10set
                            begin
                                    cnt_in_b10 <= cnt_in_b10 + 1;
                                    if(cnt_in_b10 == 10)
                                     cnt_in_b10<=0;
                            end
        end
end



always @(negedge PB[2] or negedge resetn)
begin

		if(resetn == 0)
		begin
			cnt_in_a100 <= 0;
			cnt_in_b100 <= 0;
		
		end
		
		else if(in_switching==0)   // INPUT A -->> 100 set
		begin
                    if(PB[2] ==0)
                    begin
                           cnt_in_a100 <= cnt_in_a100 + 1;   
                            if(cnt_in_a100 == 10) // // over cnt reset
                            cnt_in_a100<=0;
                    end
		
		end
		else begin
                   if(PB[2] ==0)  // INPUT B -->> 100set
                            begin
                                    cnt_in_b100 <= cnt_in_b100 + 1;
                                    if(cnt_in_b100 == 10)
                                     cnt_in_b100<=0;
                            end
        end
end
 
 always@(negedge lcdclk ) 
 begin 
                  
         if(resetn == 0)
         begin
             temp_a_100 <= 0;
             temp_a_10 <= 0;
             temp_a_1 <= 0;
             temp_b_100 <= 0;
             temp_b_10 <= 0;
             temp_b_1 <= 0;
         end                                                                                 
     //////////////////////////////
     // calculate variable/////////
     //////////////////////////////
     case(cnt_in_a100)
              0: begin temp_a_100[11:0] <= 12'b000000000000;
                       reg_b[23:16] <= `lcd_0; end 
             
              1: begin temp_a_100[11:0] <= 12'b000001100100;
                       reg_b[23:16] <= `lcd_1; end
                
              2: begin temp_a_100[11:0] <= 12'b000011001000;
                       reg_b[23:16] <= `lcd_2; end
                
              3: begin temp_a_100[11:0] <= 12'b000100101100;
                       reg_b[23:16] <= `lcd_3; end
                    
              4: begin temp_a_100[11:0] <= 12'b000110010000;
                       reg_b[23:16] <= `lcd_4; end
                   
              5: begin temp_a_100[11:0] <= 12'b000111110100;
                       reg_b[23:16] <= `lcd_5; end
                   
              6: begin temp_a_100[11:0] <= 12'b001001011000;
                       reg_b[23:16] <= `lcd_6; end
                     
              7: begin temp_a_100[11:0] <= 12'b001010111100;
                       reg_b[23:16] <= `lcd_7; end
                       
              8: begin temp_a_100[11:0] <= 12'b001100100000;
                        reg_b[23:16] <= `lcd_8; end
              
              9: begin temp_a_100[11:0] <= 12'b001110000100;
                       reg_b[23:16] <= `lcd_9; end
                
              default : begin temp_a_100[11:0] <= 12'b000000000000;
                       reg_b[23:16] <= `lcd_0; end
              endcase
      
         case(cnt_in_a10)
            0: begin temp_a_10[11:0] <= 12'b000000000000;
                reg_b[15:8] <= `lcd_0;  end
                
            1: begin temp_a_10[11:0] <= 12'b000000001010;
                reg_b[15:8] <= `lcd_1;  end
                
            2: begin temp_a_10[11:0] <= 12'b000000010100;
                reg_b[15:8] <= `lcd_2;  end
                
            3: begin temp_a_10[11:0] <= 12'b000000011110;
                reg_b[15:8] <= `lcd_3;  end
                
            4: begin temp_a_10[11:0] <= 12'b000000101000;
             reg_b[15:8] <= `lcd_4;  end
             
            5: begin temp_a_10[11:0] <= 12'b000000110010;
             reg_b[15:8] <= `lcd_5;  end
             
            6: begin temp_a_10[11:0] <= 12'b000000111100;
                reg_b[15:8] <= `lcd_6;  end
                
            7: begin temp_a_10[11:0] <= 12'b000001000110;
             reg_b[15:8] <= `lcd_7;  end
             
            8: begin temp_a_10[11:0] <= 12'b000001010000;
             reg_b[15:8] <= `lcd_8;  end
             
            9: begin temp_a_10[11:0] <= 12'b000001011010;
             reg_b[15:8] <= `lcd_9;  end
             
         default : begin temp_a_10[11:0] <= 12'b000000000000;
          reg_b[15:8] <= `lcd_0;  end
         endcase
     
          
          case(cnt_in_a1)
          0 :begin temp_a_1[11:0] <= 12'b000000000000;
          reg_b[7:0] <= `lcd_0; end
          
          1: begin temp_a_1[11:0] <= 12'b000000000001;
             reg_b[7:0] <= `lcd_1; end
         
          2: begin temp_a_1[11:0] <= 12'b000000000010;
            reg_b[7:0] <= `lcd_2; end
            
          3: begin temp_a_1[11:0] <= 12'b000000000011;
            reg_b[7:0] <= `lcd_3; end
            
          4: begin temp_a_1[11:0] <= 12'b000000000100;
            reg_b[7:0] <= `lcd_4; end
          
          5: begin temp_a_1[11:0] <= 12'b000000000101;
            reg_b[7:0] <= `lcd_5; end
            
          6: begin temp_a_1[11:0] <= 12'b000000000110;
            reg_b[7:0] <= `lcd_6; end
            
          7: begin temp_a_1[11:0] <= 12'b000000000111;
            reg_b[7:0] <= `lcd_7; end
            
          8: begin temp_a_1[11:0] <= 12'b000000001000;
            reg_b[7:0] <= `lcd_8; end
   
          9: begin temp_a_1[11:0] <= 12'b000000001001;
            reg_b[7:0] <= `lcd_9; end
            
        default : begin temp_a_1[11:0] <= 12'b000000000000;
          reg_b[7:0] <= `lcd_0; end
          endcase
                      
                   
           key_value_a = temp_a_1 + temp_a_10 + temp_a_100;    
 
  
    case(cnt_in_b100)
        0: begin temp_b_100[11:0] <= 12'b000000000000;
        reg_d[23:16] <= `lcd_0; end
        
        1: begin temp_b_100[11:0] <= 12'b000001100100;
                reg_d[23:16] <= `lcd_1; end
                
        2: begin temp_b_100[11:0] <= 12'b000011001000;
                reg_d[23:16] <= `lcd_2; end
                
        3: begin temp_b_100[11:0] <= 12'b000100101100;
                reg_d[23:16] <= `lcd_3; end
                
        4: begin temp_b_100[11:0] <= 12'b000110010000;
                reg_d[23:16] <= `lcd_4; end
                
        5: begin temp_b_100[11:0] <= 12'b000111110100;
                reg_d[23:16] <= `lcd_5; end
                
        6: begin temp_b_100[11:0] <= 12'b001001011000;
                reg_d[23:16] <= `lcd_6; end
                
        7: begin temp_b_100[11:0] <= 12'b001010111100;
                reg_d[23:16] <= `lcd_7; end
                
        8: begin temp_b_100[11:0] <= 12'b001100100000;
                reg_d[23:16] <= `lcd_8; end
                
        9: begin temp_b_100[11:0] <= 12'b001110000100;
                reg_d[23:16] <= `lcd_9; end
                
        default : begin temp_b_100[11:0] <= 12'b000000000000;
                reg_d[23:16] <= `lcd_0; end
        endcase

    case(cnt_in_b10)
      0: begin temp_b_10[11:0] <= 12'b000000000000;
      reg_d[15:8] <= `lcd_0; end
      
      1: begin temp_b_10[11:0] <= 12'b000000001010;
            reg_d[15:8] <= `lcd_1; end
            
      2: begin temp_b_10[11:0] <= 12'b000000010100;
            reg_d[15:8] <= `lcd_2; end
            
      3: begin temp_b_10[11:0] <= 12'b000000011110;
            reg_d[15:8] <= `lcd_3; end
            
      4: begin temp_b_10[11:0] <= 12'b000000101000;
            reg_d[15:8] <= `lcd_4; end
            
      5: begin temp_b_10[11:0] <= 12'b000000110010;
            reg_d[15:8] <= `lcd_5; end
            
      6: begin temp_b_10[11:0] <= 12'b000000111100;
            reg_d[15:8] <= `lcd_6; end
            
      7: begin temp_b_10[11:0] <= 12'b000001000110;
            reg_d[15:8] <= `lcd_7; end
            
      8: begin temp_b_10[11:0] <= 12'b000001010000;
            reg_d[15:8] <= `lcd_8; end
            
      9: begin temp_b_10[11:0] <= 12'b000001011010;
            reg_d[15:8] <= `lcd_9; end
            
   default : begin temp_b_10[11:0] <= 12'b000000000000;
         reg_d[15:8] <= `lcd_0; end
   
   endcase

    
     case(cnt_in_b1)
    0 :begin temp_b_1[11:0] <= 12'b000000000000;
    reg_d[7:0] <= `lcd_0; end
    
    1: begin temp_b_1[11:0] <= 12'b000000000001;
        reg_d[7:0] <= `lcd_1; end
        
    2: begin temp_b_1[11:0] <= 12'b000000000010;
        reg_d[7:0] <= `lcd_2; end
        
    3: begin temp_b_1[11:0] <= 12'b000000000011;
        reg_d[7:0] <= `lcd_3; end
        
    4: begin temp_b_1[11:0] <= 12'b000000000100;
        reg_d[7:0] <= `lcd_4; end
        
    5: begin temp_b_1[11:0] <= 12'b000000000101;
        reg_d[7:0] <= `lcd_5; end
        
    6: begin temp_b_1[11:0] <= 12'b000000000110;
        reg_d[7:0] <= `lcd_6; end
        
    7: begin temp_b_1[11:0] <= 12'b000000000111;
        reg_d[7:0] <= `lcd_7; end
        
    8: begin temp_b_1[11:0] <= 12'b000000001000;
        reg_d[7:0] <= `lcd_8; end
        
    9: begin temp_b_1[11:0] <= 12'b000000001001;
        reg_d[7:0] <= `lcd_9; end
  default : begin temp_b_1[11:0] <= 12'b000000000000;
      reg_d[7:0] <= `lcd_0; end
    endcase
                
                
        key_value_b = temp_b_1 + temp_b_10 + temp_b_100;    
             
             
 
             // Output result//
             /////////////////
             /////////////////            
       
             temp_out_value <= alu_out_value;
                        
             digit_6=0;
             digit_5=0;
             digit_4=0;
             digit_3=0;
             digit_2=0;
             digit_1=0;
                       
           if(Sel[5:0]==6'b100_000)
           begin
             digit_6 = temp_out_mul_value/22'b0000011000011010100000;
             temp_out_mul_value = temp_out_mul_value - (22'b0000011000011010100000 * digit_6);
             digit_5 = temp_out_mul_value/22'b0000000010011100010000;
             temp_out_mul_value = temp_out_mul_value - (22'b0000000010011100010000 * digit_5);
             digit_4 = temp_out_mul_value/22'b0000000000001111101000;
             temp_out_mul_value = temp_out_mul_value - (22'b0000000000001111101000 * digit_4);
             digit_3 = temp_out_mul_value/22'b0000000000000001100100;
             temp_out_mul_value = temp_out_mul_value - (22'b0000000000000001100100 * digit_3);
             digit_2 = temp_out_mul_value/22'b0000000000000000001010;
             temp_out_mul_value = temp_out_mul_value - (22'b0000000000000000001010 * digit_2);
              digit_1 = temp_out_mul_value;
           end
                   
                   
            else begin
            
             digit_6 = temp_out_value/12'd100000;
             temp_out_value = temp_out_value - (12'd100000 * digit_6);
             digit_5 = temp_out_value/12'd10000;
             temp_out_value = temp_out_value - (12'd10000 * digit_5);
             digit_4 = temp_out_value/12'd1000;
             temp_out_value = temp_out_value - (12'd1000 * digit_4);
             digit_3 = temp_out_value/12'd100;
             temp_out_value = temp_out_value - (12'd100 * digit_3);
             digit_2 = temp_out_value/12'd10;
             temp_out_value = temp_out_value - (12'd10 * digit_2);
               digit_1 = temp_out_value;
           end
                   
            case(digit_6) 
            0 : reg_g[15:8]<=`lcd_0;//0
            1 : reg_g[15:8]<=`lcd_1;//1
            2 : reg_g[15:8]<=`lcd_2;//2
            3 : reg_g[15:8]<=`lcd_3;//3
            4 : reg_g[15:8]<=`lcd_4;//4
            5 : reg_g[15:8]<=`lcd_5;//5
            6 : reg_g[15:8]<=`lcd_6;//6
            7 : reg_g[15:8]<=`lcd_7;//7
            8 : reg_g[15:8]<=`lcd_8;//8
            9 : reg_g[15:8]<=`lcd_9;//9                
            default : reg_g[15:8]<=`lcd_0;
            endcase    
            
            case(digit_5) 
            0 : reg_g[7:0]<=`lcd_0;//0
            1 : reg_g[7:0]<=`lcd_1;//1
            2 : reg_g[7:0]<=`lcd_2;//2
            3 : reg_g[7:0]<=`lcd_3;//3
            4 : reg_g[7:0]<=`lcd_4;//4
            5 : reg_g[7:0]<=`lcd_5;//5
            6 : reg_g[7:0]<=`lcd_6;//6
            7 : reg_g[7:0]<=`lcd_7;//7
            8 : reg_g[7:0]<=`lcd_8;//8
            9 : reg_g[7:0]<=`lcd_9;//9                
            default : reg_g[7:0]<=`lcd_0;
            endcase    
            
            
            case(digit_4)
            0 : reg_h[31:24]<=`lcd_0;//0
            1 : reg_h[31:24]<=`lcd_1;//1
            2 : reg_h[31:24]<=`lcd_2;//2
            3 : reg_h[31:24]<=`lcd_3;//3
            4 : reg_h[31:24]<=`lcd_4;//4
            5 : reg_h[31:24]<=`lcd_5;//5
            6 : reg_h[31:24]<=`lcd_6;//6
            7 : reg_h[31:24]<=`lcd_7;//7
            8 : reg_h[31:24]<=`lcd_8;//8
            9 : reg_h[31:24]<=`lcd_9;//9                
            default : reg_h[31:24]<=`lcd_0;
            endcase    
            
            
            case(digit_3)  
            0 : reg_h[23:16]<=`lcd_0;//0
            1 : reg_h[23:16]<=`lcd_1;//1
            2 : reg_h[23:16]<=`lcd_2;//2
            3 : reg_h[23:16]<=`lcd_3;//3
            4 : reg_h[23:16]<=`lcd_4;//4
            5 : reg_h[23:16]<=`lcd_5;//5
            6 : reg_h[23:16]<=`lcd_6;//6
            7 : reg_h[23:16]<=`lcd_7;//7
            8 : reg_h[23:16]<=`lcd_8;//8
            9 : reg_h[23:16]<=`lcd_9;//9                
            default : reg_h[23:16]<=`lcd_0;
            endcase               
            
            case(digit_2) 
            0 : reg_h[15:8]<=`lcd_0;//0
            1 : reg_h[15:8]<=`lcd_1;//1
            2 : reg_h[15:8]<=`lcd_2;//2
            3 : reg_h[15:8]<=`lcd_3;//3
            4 : reg_h[15:8]<=`lcd_4;//4
            5 : reg_h[15:8]<=`lcd_5;//5
            6 : reg_h[15:8]<=`lcd_6;//6
            7 : reg_h[15:8]<=`lcd_7;//7
            8 : reg_h[15:8]<=`lcd_8;//8
            9 : reg_h[15:8]<=`lcd_9;//9                
            default : reg_h[15:8]<=`lcd_0;
            endcase               
            
            case(digit_1)
            0 : reg_h[7:0]<=`lcd_0;//0
            1 : reg_h[7:0]<=`lcd_1;//1
            2 : reg_h[7:0]<=`lcd_2;//2
            3 : reg_h[7:0]<=`lcd_3;//3
            4 : reg_h[7:0]<=`lcd_4;//4
            5 : reg_h[7:0]<=`lcd_5;//5
            6 : reg_h[7:0]<=`lcd_6;//6
            7 : reg_h[7:0]<=`lcd_7;//7
            8 : reg_h[7:0]<=`lcd_8;//8
            9 : reg_h[7:0]<=`lcd_9;//9                
            default : reg_h[7:0]<=`lcd_0;
            endcase        
                        
end
 

 
// decoder switch
always @(posedge lcdclk)
begin
	if (resetn == 0)
		lcd_mode <= mode_pwron;
	else 
		begin
			case (count_lcd)
				0  : lcd_mode <= mode_pwron ;
				1  : lcd_mode <= mode_fnset ;
				2  : lcd_mode <= mode_onoff ;
				3  : lcd_mode <= mode_entr1 ;
				4  : lcd_mode <= mode_entr2 ;
				5  : lcd_mode <= mode_entr3 ;
				6  : lcd_mode <= mode_seta1 ;
				7  : lcd_mode <= mode_wr1st ;
				23 : lcd_mode <= mode_seta2 ;
				24 : lcd_mode <= mode_wr2nd ;
				40 : lcd_mode <= mode_delay ;
				41 : lcd_mode <= mode_actcm ;
				default : begin end 
			endcase	
		end
end
           
assign lcd_rs = set_data[9];
assign lcd_rw = set_data[8];
assign lcd_data = set_data[7:0];

// decoder output
always @(lcdclk or lcd_mode or count_lcd)
begin 
	if (resetn == 0)
		set_data <= 10'b0000000000;
	else
		begin
		case (lcd_mode)
		    mode_pwron : set_data <= {2'b00, 8'h38};
		    mode_fnset : set_data <= {2'b00, 8'h38};
		    mode_onoff : set_data <= {2'b00, 8'h0f};
		    mode_entr1 : set_data <= {2'b00, 8'h06};
		    mode_entr2 : set_data <= {2'b00, 8'h02};
		    mode_entr3 : set_data <= {2'b00, 8'h01};			    
		    mode_seta1 : set_data <= {2'b00, 8'h80};
		    mode_wr1st : 
			begin 
			case (count_lcd)
			 7 : set_data <= {1'b1, 1'b0, reg_a[31:24]};
			 8 : set_data <= {1'b1, 1'b0, reg_a[23:16]};
			 9 : set_data <= {1'b1, 1'b0, reg_a[15: 8]}; 
			10 : set_data <= {1'b1, 1'b0, reg_a[7 : 0]}; 
			11 : set_data <= {1'b1, 1'b0, reg_b[31:24]};
			12 : set_data <= {1'b1, 1'b0, reg_b[23:16]};
			13 : set_data <= {1'b1, 1'b0, reg_b[15: 8]}; 
			14 : set_data <= {1'b1, 1'b0, reg_b[7 : 0]}; 
			15 : set_data <= {1'b1, 1'b0, reg_c[31:24]};
			16 : set_data <= {1'b1, 1'b0, reg_c[23:16]};
			17 : set_data <= {1'b1, 1'b0, reg_c[15: 8]}; 
			18 : set_data <= {1'b1, 1'b0, reg_c[7 : 0]}; 
			19 : set_data <= {1'b1, 1'b0, reg_d[31:24]};
			20 : set_data <= {1'b1, 1'b0, reg_d[23:16]};
			21 : set_data <= {1'b1, 1'b0, reg_d[15: 8]};
			22 : set_data <= {1'b1, 1'b0, reg_d[7 : 0]};
			endcase
		end
		   mode_seta2 : set_data <= {2'b00, 8'hc0};
		   mode_wr2nd : 
			begin
			case (count_lcd)
			24 : set_data <= {1'b1, 1'b0, reg_e[31:24]};
			25 : set_data <= {1'b1, 1'b0, reg_e[23:16]};
			26 : set_data <= {1'b1, 1'b0, reg_e[15: 8]}; 
			27 : set_data <= {1'b1, 1'b0, reg_e[7 : 0]}; 
			28 : set_data <= {1'b1, 1'b0, reg_f[31:24]};
			29 : set_data <= {1'b1, 1'b0, reg_f[23:16]};
			30 : set_data <= {1'b1, 1'b0, reg_f[15: 8]}; 
			31 : set_data <= {1'b1, 1'b0, reg_f[7 : 0]}; 
			32 : set_data <= {1'b1, 1'b0, reg_g[31:24]};
			33 : set_data <= {1'b1, 1'b0, reg_g[23:16]};
			34 : set_data <= {1'b1, 1'b0, reg_g[15: 8]}; 
   		    35 : set_data <= {1'b1, 1'b0, reg_g[7 : 0]}; 
    		36 : set_data <= {1'b1, 1'b0, reg_h[31:24]};
    		37 : set_data <= {1'b1, 1'b0, reg_h[23:16]};
    		38 : set_data <= {1'b1, 1'b0, reg_h[15: 8]};
    		39 : set_data <= {1'b1, 1'b0, reg_h[7 : 0]};
	    		endcase
	    	end
		    mode_delay : set_data <= {2'b00, 8'h02};
		    mode_actcm : set_data <= {2'b00, 8'h02};
		    default : begin end
		endcase
	end
end

endmodule
