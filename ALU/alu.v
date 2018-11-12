


module ALU(Sel, CarryIn, A_1, B_1, Y);


	input[5:0] Sel;
	input CarryIn;
	input[11:0] A_1, B_1;
	
	output [11:0] Y;
	reg[11:0] A, B;
	reg[11:0] Y;
	reg[11:0] LogicUnit, ArithUnit, ALU_NoShift;
	
	always@(Sel or A_1 or B_1 or CarryIn)
	begin
		if(A_1[10])
			A = {11'b111_1111_1111, A_1};
		
		else
			A = {11'b000_0000_0000, A_1};
			
		if(B_1[10])
			B = {11'b111_1111_1111, B_1};
		
		else
			B = {11'b000_0000_0000, B_1};
		
		
		if(!Sel[5]) begin
			//------------------
			//Logic Unit
			//------------------
			
			case(Sel[1:0])
				2'b00 : LogicUnit = A & B;
				2'b01 : LogicUnit = A | B;
				2'b10 : LogicUnit = A ^ B;
				2'b11 : LogicUnit = ~A + 1;
				default : LogicUnit = 22'bX;
			endcase
			
			//------------------
			//Arithmatic Unit
			//------------------
			
			case({Sel[1:0], CarryIn})
				3'b000 : ArithUnit = A;
				3'b001 : ArithUnit = A + 1;
				3'b010 : ArithUnit = A + B;
				3'b011 : ArithUnit = A + B + 1;
				3'b100 : ArithUnit = A + ~B;
				3'b101 : ArithUnit = A - B;
				3'b110 : ArithUnit = A - 1;
				3'b111 : ArithUnit = A;
				default : ArithUnit = 22'bX;
			endcase
			
			//--------------------------------------------
			//Multiplex between logic & arithmatic units
			//--------------------------------------------
			
			if(Sel[2])
				ALU_NoShift = LogicUnit;
				
			else
				ALU_NoShift = ArithUnit;
				
			//------------------
			//Shift operations
			//------------------
			
			case(Sel[4:3])
				2'b00 : Y = ALU_NoShift;
				2'b01 : Y = ALU_NoShift << 1;
				2'b10 : Y = ALU_NoShift >> 1;
				2'b11 : Y = 22'b0;
				default : Y = 22'bX;
			endcase
		end
	end
	
endmodule
