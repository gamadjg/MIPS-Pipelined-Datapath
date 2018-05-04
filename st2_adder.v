/*
	Stage 2 Adder, which has the inputs (PC+2) & (Sll Sign Extended value)
*/
module st2_adder(
	input [15:0] pc2, sllInstr,
	output reg [15:0] sum);

always@(*)
begin
	sum <= pc2 + sllInstr;
end

endmodule
