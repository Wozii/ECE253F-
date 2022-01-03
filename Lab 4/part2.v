`timescale 1ns / 1ns // `timescale time_unit/time_precision


module part2(Clock, Reset_b, Data, Function, ALUout);

	input Clock, Reset_b;
	input [2:0] Function;
	input [3:0] Data;
	
	output reg [7:0] ALUout;
	
	wire [7:0] alu;
	
	ALU u0 (.Function(Function),
			  .A(Data),
			  .B(ALUout[3:0]), 
			  .Q(alu),
			  .prev(ALUout[7:4]));
	
	always@(posedge Clock)
	begin
		if (Reset_b == 1'b0)
			ALUout <= 8'b00000000;
		else	
			ALUout <= alu;
	end
	
endmodule

module ALU(Function, A, B, Q, prev);
	input [3:0] A, B, prev;
	input [2:0] Function;
	output reg [7:0] Q;
	
	wire[4:0] c_s;	
	BitAdder u0 (.a(A), 
			.b(B), 
			.c_in(1'b0), 
			.s(c_s[3:0]), 
			.c_out(c_s[4]));
	
	
	always@(*)
	begin
	
		case(Function)
			
			3'b000: Q[7:0] = {3'b000, c_s};
			3'b001: Q = A + B;
			3'b010: Q = {{4{B[3]}}, B};
			3'b011: Q = A||B;
			3'b100:begin
					if (&A && &B) 
						Q = 8'b00000001;
				
					else 
						Q = 8'b00000000;
					end
			3'b101: Q = B << A;
			3'b110: Q = A * B;
			3'b111: Q[7:0] = {prev, B};
			
			default: Q = 8'b00000000;
			
		endcase
	end
endmodule


module BitAdder(a, b, c_in, s, c_out);
	
	input [3:0] a, b;
	input c_in;
	output [3:0] s;
	output c_out;
	wire [2:0] carry;
	
	FA u0 (
		.a(a[0]), 
		.b(b[0]), 
		.c_i(c_in), 
		.c_o(carry[0]), 
		.s(s[0]));
		
	FA u1 (
		.a(a[1]), 
		.b(b[1]), 
		.c_i(carry[0]), 
		.c_o(carry[1]),
		.s(s[1]));
		
	FA u2 (
		.a(a[2]), 
		.b(b[2]), 
		.c_i(carry[1]), 
		.c_o(carry[2]), 
		.s(s[2]));
	
	FA u3 (
		.a(a[3]), 
		.b(b[3]), 
		.c_i(carry[2]), 
		.c_o(c_out), 
		.s(s[3]));
endmodule

module FA (a, b, c_i, c_o, s);

	input a, b, c_i; 
	output reg c_o, s;
	
	always@(*)
	begin
		{c_o, s} = a+b+c_i;
	end
	
endmodule
