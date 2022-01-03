`timescale 1ns / 1ns // `timescale time_unit/time_precision


module part1 (Clock, Enable, Clear_b, CounterValue);
	input Clock, Enable, Clear_b;
	output wire [7:0] CounterValue;
	wire [7:1] T;
	
	TFF u0 (Enable, CounterValue[0], Clock, Clear_b);
	assign T[1] = Enable & CounterValue[0];
	TFF u1 (T[1], CounterValue[1], Clock, Clear_b);
	assign T[2] = T[1] & CounterValue[1];
	TFF u2 (T[2], CounterValue[2], Clock, Clear_b);
	assign T[3] = T[2] & CounterValue[2];
	TFF u3 (T[3], CounterValue[3], Clock, Clear_b);
	assign T[4] = T[3] & CounterValue[3];
	TFF u4 (T[4], CounterValue[4], Clock, Clear_b);
	assign T[5] = T[4] & CounterValue[4];
	TFF u5 (T[5], CounterValue[5], Clock, Clear_b);
	assign T[6] = T[5] & CounterValue[5];
	TFF u6 (T[6], CounterValue[6], Clock, Clear_b);
	assign T[7] = T[6] & CounterValue[6];
	TFF u7 (T[7], CounterValue[7], Clock, Clear_b);
	
endmodule


module TFF (T, Q, C, R);

	input T, C, R;
	output reg Q;
	
	always @ (posedge C)
	begin
		if(!R)
			Q <= 1'b0;
		else
			if (T)
				Q <= ~Q;
			else	Q <= Q;
	end
endmodule

