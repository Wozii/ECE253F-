module part3(Clock, Resetn, Go, Divisor, Dividend, Quotient, Remainder);

	input Clock, Resetn, Go;
	input [3:0] Divisor, Dividend; 
	output [3:0] Quotient, Remainder;
	
	reg [7:0] Q, Q_next, temp1, temp2; 
	reg next_state, cur_state;
	reg [1:0] count, next_count;
	
	assign Remainder = Q[7:4];
	assign Quotient = Q[3:0]; 
	
	always@(posedge Clock) begin
		if (!Resetn)begin
			Q <= 8'd0; 
			cur_state <= 1'd0;
			count <= 2'd0; 	
		end
		else begin
			Q <= Q_next; 
			cur_state <= next_state;
			count <= next_count; 
		end
	end
	
	always@(*) begin
		case(cur_state)
			1'b0: begin
					next_count = 2'b00;
					if(Go) begin
						next_state = 1'b1;
						Q_next = {4'b0000, Dividend};
					end
					else begin
						next_state = cur_state;
						Q_next = 8'b00000000; 
					end
					
				end
			1'b1: begin
				next_count = next_count + 1; 
				temp1 = Q << 1; 
				temp2 = {temp1[7:4] - Divisor, temp1[3:0]};
				Q_next = temp2[7] ? {temp1[7:1], 1'b0} : {temp2[7:4], temp1[3:1], 1'b1};
				next_state = (&count) ? 1'b0 : cur_state;
				end
		endcase
	
	end
	

endmodule
