`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2014/07/28 15:03:27
// Design Name:
// Module Name: top
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


module top(
    resetn,
    lcdclk,
    PB,
    Sel,
    in_switching,
    CarryIn,
    lcd_rs,
    lcd_rw,
    lcd_en,
    lcd_data
 
);

input resetn;
input lcdclk;
input [2:0] PB;
input [5:0] Sel;
input in_switching;
input CarryIn;
output lcd_rs;
output lcd_rw;
output lcd_en;
output [7:0] lcd_data;


wire resetn, lcdclk, lcd_rs, lcd_rw, lcd_en;
wire [7:0]lcd_data;
wire [2:0] PB;
wire [5:0] Sel;
wire CarryIn;
wire [11:0] key_value_a;
wire [11:0] key_value_b;
wire [11:0] alu_out_value;
wire [10:0] gcd_out_value; // for gcd
wire [10:0] lcm_out_value; // for lcm


wire done;
wire done_div;

reg Load;
reg GCD_Load=0;
reg delay1,delay2;

textlcd utextlcd(
    .resetn(resetn),
    .lcdclk(lcdclk),
    .alu_out_value(alu_out_value),
    .gcd_out_value(gcd_out_value),
    .lcm_out_value(lcm_out_value),
    .PB(PB),
    .Sel(Sel),
    .in_switching(in_switching),
    .CarryIn(CarryIn),
    .lcd_rs(lcd_rs),
    .lcd_rw(lcd_rw),
    .lcd_en(lcd_en),
    .lcd_data(lcd_data),
    .key_value_a(key_value_a),
    .key_value_b(key_value_b)
   );
   
 ALU uALU (
   .Sel(Sel),
   .CarryIn(CarryIn),
   .A_1(key_value_a),
   .B_1(key_value_b),
   .Y(alu_out_value)
   );
   
 GCD_LCM uGCD_LCM (
   .clock(lcdclk),
   .reset(resetn),
   .GCD_Load(CarryIn),
   .A(key_value_a),
   .B(key_value_b),
   .Y(gcd_out_value),
   .L(lcm_out_value)
   );
 
  always @(posedge lcdclk)
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
