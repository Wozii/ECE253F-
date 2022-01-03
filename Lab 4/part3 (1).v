`timescale 1ns / 1ns // `timescale time_unit/time_precision


module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);

	input clock, reset, ParallelLoadn, RotateRight, ASRight;
	input [7:0] Data_IN; 
	output [7:0] Q;
	//initiate 8 of the modules??? wtf am i even doing?
	//to rotate right you have to load the bits on the left therefore RotateRight = LoadLeft, 
	
	wire temp_Q7;
	assign temp_Q7 = (RotateRight && ASRight) ? Q[7]: Q[0];
	
	muxFF u0(.clk(clock), .reset(reset), .right(Q[7]), .left(Q[1]), .LoadLeft(RotateRight), .Loadn(ParallelLoadn), .D(Data_IN[0]), .Q(Q[0]));
	
	muxFF u1(.clk(clock), .reset(reset), .right(Q[0]), .left(Q[2]), .LoadLeft(RotateRight), .Loadn(ParallelLoadn), .D(Data_IN[1]), .Q(Q[1]));
	
	muxFF u2(.clk(clock), .reset(reset), .right(Q[1]), .left(Q[3]), .LoadLeft(RotateRight), .Loadn(ParallelLoadn), .D(Data_IN[2]), .Q(Q[2]));
	
	muxFF u3(.clk(clock), .reset(reset), .right(Q[2]), .left(Q[4]), .LoadLeft(RotateRight), .Loadn(ParallelLoadn), .D(Data_IN[3]), .Q(Q[3]));
	
	muxFF u4(.clk(clock), .reset(reset), .right(Q[3]), .left(Q[5]), .LoadLeft(RotateRight), .Loadn(ParallelLoadn), .D(Data_IN[4]), .Q(Q[4]));
	
	muxFF u5(.clk(clock), .reset(reset), .right(Q[4]), .left(Q[6]), .LoadLeft(RotateRight), .Loadn(ParallelLoadn), .D(Data_IN[5]), .Q(Q[5]));
	
	muxFF u6(.clk(clock), .reset(reset), .right(Q[5]), .left(Q[7]), .LoadLeft(RotateRight), .Loadn(ParallelLoadn), .D(Data_IN[6]), .Q(Q[6]));
	
	muxFF u7(.clk(clock), .reset(reset), .right(Q[6]), .left(temp_Q7), .LoadLeft(RotateRight), .Loadn(ParallelLoadn), .D(Data_IN[7]), .Q(Q[7]));
	
endmodule

module muxFF(clk, reset, right, left, LoadLeft, Loadn, D, Q);
	//if LoadLeft = 1 then left value goes in
	
	input clk, reset, right, left, LoadLeft, Loadn, D;
	output Q;
	wire D1, D2;
	
	mux2to1 u0(.x(right), .y(left), .s(LoadLeft), .m(D1));
				  
	mux2to1 u1(.x(D), .y(data1), .s(Loadn), .m(D2));
	
	FF(.clk(clk), .reset(reset), .D(D2), .Q(Q));
	
endmodule


module mux2to1(x, y, s, m);
	input x, y, s;
	output m;
	
	assign m = s ? y:x;
endmodule


module FF(clk, reset, D, Q);
	input clk, reset, D; 
	output reg Q; 
	
	always@(posedge clk)
	begin
		
		if (reset == 1'b1)
			Q <= 1'b0;
		else
			Q <= D;
		
	end
	
endmodule
