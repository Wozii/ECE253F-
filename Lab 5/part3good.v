`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part3(ClockIn, Resetn, Start, Letter, DotDashOut);
	input ClockIn, Resetn, Start; 
	input [2:0] Letter;	
	output reg DotDashOut;
	wire [11:0] Q; 
	reg [11:0] code;
	wire go;
	
	
	parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101, G = 3'b110, H = 3'b111;
	
	newClk u0(.clk(ClockIn), .new_clk(go));
	
	
	always@(posedge ClockIn)
	begin
		if (Start) begin
			case(Letter)
				A: code <= 12'b101110000000;
				B: code <= 12'b111010101000;
				C: code <= 12'b111010111010;
				D: code <= 12'b111010100000;
				E: code <= 12'b100000000000;
				F: code <= 12'b101011101000;
				G: code <= 12'b111011101000;
				H: code <= 12'b101010100000;
				default: code <= 12'b111111111110;
			endcase
		end
		
		if (go) begin
			DotDashOut <= code[11];
			code[11] <= code[10]; 
			code[10] <= code[9];
			code[9] <= code[8];
			code[8] <= code[7];
			code[7] <= code[6];
			code[6] <= code[5];
			code[5] <= code[4];
			code[4] <= code[3];
			code[3] <= code[2];
			code[2] <= code[1];
			code[1] <= code[0];
			code[0] <= code[11];
		end
		else if (!Resetn) 
			code <= 0;
		
	end

endmodule

module newClk (clk, new_clk);
	input clk;
	output reg new_clk;
	reg [11:0] RateDivider = 0; 
	
	always@(posedge clk)
	begin
		if (RateDivider == 249) begin
			new_clk <= 1; 
			RateDivider <= 0; 
		end
		else begin
			new_clk <= 0;
			RateDivider <= RateDivider + 1;
		end
	end

endmodule
