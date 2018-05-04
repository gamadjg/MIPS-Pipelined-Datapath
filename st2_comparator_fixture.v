`timescale 10ns/1ps
`include "st2_comparator.v"

module st2_comparator_fixture;

reg [15:0] op1, reg15;
wire [1:0] Result;

st2_comparator uut(op1, reg15, Result);

initial 
	begin
		//$monitor("op1 = %h, reg15 = %h, Result = %b", op1, reg15, Result);
	end

initial 
	begin
		//$display ("op1\t|\treg15\t|\tResult");
		$monitor ("op1:%d \t op2:%d \t result:%b",op1,reg15,Result);
	end



initial 
	begin
		// op1 == reg15 -> Branch on Equal
		op1 <= 16'h0000; reg15 <= 16'h0000;
		#10;

		// op1 > reg15 -> Branch Greater Than
		op1 <= 16'h0001; reg15 <= 16'h0000;
		#10;

		// op1 < reg15 -> Branch Less Than
		op1 <= 16'hFFFA; reg15 <= 16'hFFFF;
		#10;

		$finish;
	end
endmodule
