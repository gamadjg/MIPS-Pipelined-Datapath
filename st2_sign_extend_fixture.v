`timescale 10ns/1ps
`include "st2_sign_extend.v"

module st2_sign_extend_fixture;
	reg [11:0] origInstruction;
	reg [1:0] SE_Sel;
	wire [15:0] extended;

st2_sign_extend uut(origInstruction, SE_Sel, extended);

initial
	begin
		$monitor("original=%b, Sign Extension Selected = %b, Extended Value = %b", origInstruction, SE_Sel, extended);
	end

initial 
	begin
		origInstruction = 12'hF01; SE_Sel = 2'b00;
		#10;

		origInstruction = 12'h8; SE_Sel = 2'b01;
		#10;

		origInstruction = 12'hF7C; SE_Sel = 2'b10;
		#10;

		origInstruction = 12'hFAC; SE_Sel = 2'b11;
		#10;

		$finish;
	end
endmodule