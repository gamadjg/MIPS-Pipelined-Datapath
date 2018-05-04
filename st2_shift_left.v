module st2_shift_left(
	input [15:0] InstToBeShifted,
	output reg [15:0] InstShifted
);
always @(*)
begin
	InstShifted = InstToBeShifted << 1;
end

endmodule
