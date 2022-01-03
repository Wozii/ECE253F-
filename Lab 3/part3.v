`timescale 1ns / 1ns // `timescale time_unit/time_precision



module part3(A, B, Function, ALUout);

	input[3:0] A, B; 
	input[2:0] Function;
	output reg [7:0] ALUout;
	wire[4:0] c_s;
	
	BitAdder u0 (.a(A), 
			.b(B), 
			.c_in(1'b0), 
			.s(c_s[3:0]), 
			.c_out(c_s[4]));
	
	always@(*)
	begin
		case(Function)
		
			3'b000: ALUout[7:0] = {3'b000, c_s};
			
			3'b001: ALUout = A + B;
			
			3'b010: ALUout = {{4{B[3]}}, B};
			
			3'b011: ALUout = A||B;
			
			3'b100: begin
				if (&A && &B) begin
					ALUout = 8'b00000001;
				end
				else begin
					ALUout = 8'b00000000;
				end
			end
			
			3'b101: ALUout = {A, B};
			
			default: ALUout = 8'b00000000;
		
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