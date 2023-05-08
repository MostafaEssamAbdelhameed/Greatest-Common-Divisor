module mux_2to1 (
	input [3:0] x,minus,
	input sel,
	output [3:0] out
);
	assign out = sel? minus:x;
endmodule

/////////////////////////////////////////////////////

module register (
	input clk,
	input rst,
	input load,
	input [3:0] x,
	output reg [3:0] out
);
	always @(posedge clk) begin
		if (rst)
		begin
			out <= 0;
		end
		else 
		begin
			if(load) out <= x;
			else out <= out ;
		end
	end
endmodule

/////////////////////////////////////////////////////

module gcd_datapath (
	input rst_dp,
	input clk,
	input [3:0] A,
	input [3:0] B,
	input A_sel,
	input B_sel,
	input A_load ,
	input B_load ,
	input done ,	
	output eq_flag,
	output bigger,
	output reg [3:0] res
);
	wire [3:0] amb , bma;
	wire [3:0] a,b,a1,b1;

	mux_2to1 mux_a ( .x(A),
					 .minus(amb),
					 .sel(A_sel),
					 .out(a1)
	);
	mux_2to1 mux_b ( .x(B),
					 .minus(bma),
					 .sel(B_sel),
					 .out(b1)
	);
	register reg_A ( .clk(clk),
					 .rst(rst_dp),
					 .x(a1),
					 .out(a),
					 .load(A_load)
	);
	register reg_B ( .clk(clk),
					 .rst(rst_dp),
					 .x(b1),
					 .out(b),
					 .load(B_load)
	);
	register reg_out ( .clk(clk),
					   .rst(rst_dp),
					   .x(a),
					   .out(res),
					   .load(done)
	);
	assign amb = a-b;
	assign bma = b-a;
	assign eq_flag = (a==b)?1:0;
	assign bigger = (a>b)?1:0;
 
endmodule
