module gcd_controller (
	input rst_fsm,
	input clk,
	input start,
	input eq_flag,
	input bigger,
	output reg A_sel,
	output reg B_sel,
	output reg A_load,
	output reg B_load,
	output reg done
	);
	parameter state_reg_width = 3;
	parameter [state_reg_width -1 : 0] start_state = 0 ,
									   read = 1,
									   while_equal=2,
									   condition=3,
									   A_bigger = 4,
									   B_bigger = 5,
									   res =6;
									   
	reg [state_reg_width -1 : 0] curr_state , next_state ;
	
//state register
	always @(posedge clk)begin
		if(rst_fsm)
			begin
			curr_state <= start_state;
			end
		else 
			begin
			curr_state <= next_state;
			end
	end
//state logic
	always@(*)begin
	done=0;
	A_load=0;
	B_load=0;
	B_sel=0;
	A_sel=0;
		case(curr_state)
		start_state: 
		begin
			if (start) next_state = read;
			else next_state = start_state;
		end
		read: 
		begin
			A_sel=0;
			B_sel=0;
			A_load=1;
			B_load=1;
			next_state = while_equal;
		end
		while_equal:
		begin
			if (eq_flag) next_state = res;
			else next_state = condition;
		end
		condition:
		begin
			if (bigger) next_state = A_bigger;
			else next_state = B_bigger;
		end
		A_bigger:
		begin	
			done=0;
			A_load=1;
			A_sel=1;
			B_sel=0;
			B_load=0;
			next_state = while_equal;
		end
		B_bigger:
		begin	
			done=0;
			A_load=0;
			A_sel=0;
			B_sel=1;
			B_load=1;
			next_state = while_equal;
		end
		res:
		begin
			done = 1;
			if (rst_fsm) next_state = start_state;
			else next_state = res;
		end
		endcase
	end
endmodule

