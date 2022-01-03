`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part2 (ClockIn, Reset, Speed, CounterValue);
	input ClockIn, Reset;	
	input [1:0] Speed;
	output reg [3:0] CounterValue; 
	reg [11:0] RateDivider;
	wire Enable;
	
	
		
	assign Enable = (RateDivider == 11'b00000000000) ? 1:0;
	
	always @(posedge ClockIn)
	begin		
		RateDivider <= RateDivider - 1;
				
		
		if (Reset == 1'b1 | Speed == 2'b00)
			RateDivider <= 11'b00000000000;
		else if (Speed == 2'b01 & RateDivider == 11'b00000000000)
			RateDivider <= 11'b00111110011; //499
		else if (Speed == 2'b10 & RateDivider == 11'b00000000000)
			RateDivider <= 11'b01111100111; //999
		else if (Speed == 2'b11 & RateDivider == 11'b00000000000)
			RateDivider <= 11'b11111001111; //1999
			
			
		if (Reset == 1'b1 | CounterValue == 4'b1111)
			CounterValue <= 4'b0000;
		else if (Enable == 1'b1)
			CounterValue <= CounterValue + 1;
	end

endmodule