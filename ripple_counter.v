module ripple_counter(Clock, Reset, Y);
input Clock, Reset;
output Y;
reg Div2, Div4, Div8, Div16, Y;
	
always@(posedge Clock or negedge Reset)
if(!Reset)
Div2 = 0;
else 
Div2 =! Div2;

always@(posedge Div2 or negedge Reset)
if(!Reset)
Div4 = 0;
else 
Div4 =! Div4;
		
always@(posedge Div4 or negedge Reset)
if(!Reset)
Div8 = 0;
else 
Div8 =! Div8;

always@(posedge Div8 or negedge Reset)
if(!Reset)
Div16 = 0;
else 
Div16 =! Div16;
		
always@(posedge Clock or negedge Reset)
if(!Reset)
Y = 0;
else 
Y = Div16;

endmodule
