`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part3(ClockIn, Resetn, Start, Letter, DotDashOut);
	input ClockIn, Resetn, Start; 
	input [2:0] Letter;	
	output DotDashOut;
	wire [11:0] Q; 
	reg [11:0] code;
	
	parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101, G = 3'b110, H = 3'b111;
	
	always@(posedge ClockIn)
	begin
		if (Start)
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
	
	assign DotDashOut = Q[11];
	//12 bit shift register to output DotDashOut 1 bit at a time
	shift_reg r11 (.Clock(ClockIn), .Reset(Resetn), .Start(Start), .Q(Q[11]), .D(Q[10]), .code(code[11]));
	shift_reg r10 (.Clock(ClockIn), .Reset(Resetn), .Start(Start), .Q(Q[10]), .D(Q[9]), .code(code[10]));
	shift_reg r9 (.Clock(ClockIn), .Reset(Resetn), .Start(Start), .Q(Q[9]), .D(Q[8]), .code(code[9]));
	shift_reg r8 (.Clock(ClockIn), .Reset(Resetn), .Start(Start), .Q(Q[8]), .D(Q[7]), .code(code[8]));
	shift_reg r7 (.Clock(ClockIn), .Reset(Resetn), .Start(Start), .Q(Q[7]), .D(Q[6]), .code(code[7]));
	shift_reg r6 (.Clock(ClockIn), .Reset(Resetn), .Start(Start), .Q(Q[6]), .D(Q[5]), .code(code[6]));
	shift_reg r5 (.Clock(ClockIn), .Reset(Resetn), .Start(Start), .Q(Q[5]), .D(Q[4]), .code(code[5]));
	shift_reg r4 (.Clock(ClockIn), .Reset(Resetn), .Start(Start), .Q(Q[4]), .D(Q[3]), .code(code[4]));
	shift_reg r3 (.Clock(ClockIn), .Reset(Resetn), .Start(Start), .Q(Q[3]), .D(Q[2]), .code(code[3]));
	shift_reg r2 (.Clock(ClockIn), .Reset(Resetn), .Start(Start), .Q(Q[2]), .D(Q[1]), .code(code[2]));
	shift_reg r1 (.Clock(ClockIn), .Reset(Resetn), .Start(Start), .Q(Q[1]), .D(Q[0]), .code(code[1]));
	shift_reg r0 (.Clock(ClockIn), .Reset(Resetn), .Start(Start), .Q(Q[0]), .D(Q[11]), .code(code[0]));
	
	
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

module shift_reg(Clock, Reset, Start, Q, D, code);
	input Clock, Reset, D, code, Start;
	wire clk;
	reg go;
	reg temp;
	output reg Q;
	
	
	newClk u0(.clk(Clock), .new_clk(clk));
	
	
	always @(posedge clk, negedge Reset)
	begin
	
		if (Reset == 1'b0)
			Q <= 1'b0; 
		else begin
			if (Start)
				Q <= code;
			
			else
				Q <= D;
		end		
			
	end
//	
//	always @(Start)
//	begin
//		if (Start)
//			go <= 1;
//		else 
//			go <= 0; 
//	end
	

endmodule
