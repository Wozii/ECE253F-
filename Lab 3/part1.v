`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[9:7] MuxSelect
//Sw[6:0] Input

//LEDR[0] Out


module part1(MuxSelect, Input, Out);
	
	input [2:0] MuxSelect;
	input [6:0] Input; 
	output reg Out;
	
	always@(*)
	begin
		case (MuxSelect[2:0])
			3'b000: Out = Input[0]; // case 0
			3'b001: Out = Input[1]; // case 1
			3'b010: Out = Input[2]; // case 2
			3'b011: Out = Input[3]; // case 3
			3'b100: Out = Input[4]; // case 4
			3'b101: Out = Input[5]; // case 5
			3'b110: Out = Input[6]; // case 6
			default: Out = 1'b0; // default case
		endcase
	end
endmodule