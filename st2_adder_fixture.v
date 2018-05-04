`timescale 10ns/1ps
`include "st2_adder.v"

module st2_adder_fixture();

reg [15:0] pc2, sllInstr;
wire [15:0] sum;

st2_adder uut(pc2, sllInstr, sum);

initial
begin
	$monitor("pc2 = %h, sllInstr = %h, sum = %h", pc2, sllInstr, sum);
end

initial
begin
	pc2 = 5; sllInstr = 32;
	#10;

	pc2 = 6; sllInstr = 64;
	#10;

	pc2 = 16'h0001; sllInstr = 0;
	#10;

	$finish;
end
endmodule