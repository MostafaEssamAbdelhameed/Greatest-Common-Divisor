module gcd_top (
	input rst , clk, start,
	input [4:0] A,
	input [4:0] B,	
	output[4:0] reg res
);
	wire eq_flag , bigger ;
	wire A_sel , B_sel , A_load , B_load , done;

gcd_datapath DP (.rst_dp(rst),
				 .clk(clk),
				 .A(A),
				 .B(B),
				 .A_sel(A_sel),
				 .B_sel(B_sel),
				 .A_load(A_load),
				 .B_load(B_load),
				 .done(done),
				 .eq_flag(eq_flag),
				 .bigger(bigger),
				 .res(res)
				);

gcd_controller FSM (.rst_fsm(rst),
					.clk(clk),
					.start(start),
					.eq_flag(eq_flag),
					.bigger(bigger),
					.A_sel(A_sel),
					.B_sel(B_sel),
					.A_load(A_load),
					.B_load(B_load),
					.done(done)
					);
endmodule
