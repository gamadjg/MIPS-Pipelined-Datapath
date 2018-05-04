`include "im.v"
module im_tb;
	reg clk, rst;
	reg [15:0] address;
	wire [15:0] inst;
	
	im uut(.clk(clk), .rst(rst), .address(address), .inst(inst));


initial begin
	$monitor(" address = %h, inst = %h", address, inst);
end

initial begin
	clk = 0;
	forever #10 clk = ~clk;
end

initial begin
	rst = 0;
	#10;
	rst=1 ; address = 0;
	#20
	address = 10;
	#20 
	address = 4;
	#20 
	address = 16;
	#20 
	address = 12;
	#20 
	address = 32;
	#20;
	$finish;
end
endmodule