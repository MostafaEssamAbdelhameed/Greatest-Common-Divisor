module gcd_tb;
  parameter clk_period = 10ns;
  reg clk_tb = 0;
  always #(clk_period/2) clk_tb = ~clk_tb;
  
  reg start_tb;
  reg rst_tb;
  reg [4:0] A_tb ;
  reg [4:0] B_tb;
  wire [4:0] res_tb;
  
  gcd_top DUT (.rst(rst_tb),
			   .clk(clk_tb),
			   .start(start_tb),
			   .A(A_tb),
			   .B(B_tb),
			   .res(res_tb)		
			  );
  
   initial begin
    $monitor (
	"@ %t\n",$time,
    "reset = %d \n",rst_tb,
	"A = %d \n",A_tb,
    "B = %d \n",B_tb,
    "start = %d\n",start_tb,
	"res=%d\n",res_tb

	);
	end
	
	initial begin
      
	rst_tb = 1;
	#(clk_period);
    rst_tb = 0;
	start_tb = 1;
    A_tb = 8;
    B_tb = 8;
    #(clk_period*10);
      
    rst_tb = 1;
    #(clk_period);
    rst_tb = 0;
	start_tb = 1;
    A_tb = 12;
    B_tb = 8;
    #(clk_period*10);
	$finish();
	end
endmodule