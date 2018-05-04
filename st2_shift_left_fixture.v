`timescale 10ns/1ps
`include "st2_shift_left.v"

module st2_shift_left_fixture();

reg [15:0] InstToBeShifted;
wire [15:0] InstShifted;

st2_shift_left uut(InstToBeShifted, InstShifted);

initial
begin
	$monitor("\nOriginal = %b\nShifted Instruction = %b\n", InstToBeShifted, InstShifted);
end

initial
begin
	InstToBeShifted = 16'hFA61;
	#10;

	$finish;
end
endmodule