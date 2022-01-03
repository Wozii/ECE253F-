`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part2(a, b, c_in, s, c_out);
	
	input [3:0] a, b;
	input c_in;
	output [3:0] s;
	output wire [3:0] c_out;
	
	FA u0 (
		.a(a[0]), 
		.b(b[0]), 
		.c_i(c_in), 
		.c_o(c_out[0]), 
		.s(s[0]));
		
	FA u1 (
		.a(a[1]), 
		.b(b[1]), 
		.c_i(c_out[0]), 
		.c_o(c_out[1]),
		.s(s[1]));
		
	FA u2 (
		.a(a[2]), 
		.b(b[2]), 
		.c_i(c_out[1]), 
		.c_o(c_out[2]), 
		.s(s[2]));
	
	FA u3 (
		.a(a[3]), 
		.b(b[3]), 
		.c_i(c_out[2]), 
		.c_o(c_out[3]), 
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