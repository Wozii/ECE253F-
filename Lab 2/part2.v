`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signals

//LEDR[0] output display

//module mux(LEDR, SW);
//    input [9:0] SW;
//    output [9:0] LEDR;
//
//    mux2to1 u0(
//        .x(SW[0]),
//        .y(SW[1]),
//        .s(SW[9]),
//        .m(LEDR[0])
//        );
//endmodule


module mux2to1(input x, y, s,
			   output m);
    
	wire w1, w2, w3;
  
    v7408 U1(.pin1(y), .pin2(s), .pin3(w1), 	// y & s
			 .pin4(x), .pin5(w2), .pin6(w3));	// x & ~s
	v7404 U2 (.pin1(s), .pin2(w2));				// ~s
	v7432 U3(.pin1(w1), .pin2(w3), .pin3(m));
	
endmodule


module v7404 (input pin1, pin3, pin5, pin9, pin11, pin13,
			 output pin2, pin4, pin6, pin8, pin10, pin12);
	
	assign pin2 = !pin1;
	assign pin4 = !pin3;
	assign pin6 = !pin5;
	assign pin8 = !pin9;
	assign pin10 = !pin11;
	assign pin12 = !pin13;
	
endmodule


module v7408 (input pin1, pin2, pin4, pin5,
					pin9, pin10, pin12, pin13,
			 output pin3, pin6, pin8, pin11);
	
	assign pin3 = pin1 & pin2;
	assign pin6 = pin4 & pin5;
	assign pin8 = pin9 & pin10;
	assign pin11 = pin12 & pin13;
	
endmodule


module v7432 (input pin1, pin2, pin4, pin5,
					pin9, pin10, pin12, pin13,
			 output pin3, pin6, pin8, pin11);
	
	assign pin3 = pin1 | pin2;
	assign pin6 = pin4 | pin5;
	assign pin8 = pin9 | pin10;
	assign pin11 = pin12 | pin13;
	
endmodule

