module FSM_MEALY (Clock, Reset, Red, Green, Blue, NewColor);
input Clock, Reset;
input Red, Green, Blue;
output NewColor;
reg NewColor;
parameter RedState = 2'b 00,
	GreenState = 2'b 01,
	BlueState = 2'b 10,
	WhiteState = 2'b 11;
reg [1:0] CurrentState, NextState;

always @(Red or Green or Blue or CurrentState)
begin : FSM_COMB
case (CurrentState)
	RedState : 
	if(Red)
	begin
		NewColor = 0;
		NextState = RedState;
	end
	else
	begin
	if(Green || Blue)
		NewColor = 1;
	else
		NewColor = 0;
		NextState = WhiteState;
	end
	
	GreenState : 
	if(Red)
	begin
		NewColor = 0;
		NextState = GreenState;
	end
	else
	begin
	if(Red || Blue)
		NewColor = 1;
	else
		NewColor = 0;
		NextState = WhiteState;
	end
	
	BlueState : 
	if(Blue)
	begin
		NewColor = 0;
		NextState = BlueState;
	end
	else
	begin
	if(Green || Red)
		NewColor = 1;
	else
		NewColor = 0;
		NextState = WhiteState;
	end
	
	WhiteState : 
	if(Red)
	begin
		NewColor = 1;
		NextState = RedState;
	end
	else if(Green)
	begin
		NewColor = 1;
		NextState = GreenState;
	end
	else if(Blue)
	begin
		NewColor = 1;
		NextState = BlueState;
	end
	else
	begin
		NewColor = 0;
		NextState = WhiteState;
	end
	default :
	NextState = WhiteState;
	endcase
	end
	
	always @(posedge Clock or negedge Reset)
	begin : FSM_SEQ
	if(! Reset)
		CurrentState = WhiteState;
	else
		CurrentState = NextState;
	end
endmodule

	