`include "st3_alu.v"
module st3_alu_tb;
	reg [3:0] aluFunct;
	reg signed [15:0] reg1, reg2; 
	wire[15:0] aluOut1, aluOut2; //R15, 
	wire ALU_exception;

st3_alu uut(aluFunct, reg1, reg2, aluOut1, aluOut2, ALU_exception);

initial 
begin
	$monitor("\naluFunct:%b, reg1:%h, reg2:%h, aluOut1:%h, aluOut2:%h, ALU_exception:%b\n",aluFunct, reg1, reg2, aluOut1, aluOut2, ALU_exception);
end

initial 
begin
	//ALU exception
	aluFunct = 4'b0000; reg1 = 16'h7FFF; reg2 = 16'h7FFF;
	#10;

	//add
	aluFunct = 4'b0000; reg1 = 16'h5; reg2 = 16'h2;
	#10;

	//sub
	aluFunct = 4'b0000; reg1 = 16'hF; reg2 = 16'hA;
	#10;

	//multiplication
	aluFunct = 4'b0000; reg1 = 16'hA; reg2 = 16'hA;
	#10;

	//division
	aluFunct = 4'b0000; reg1 = 16'hA; reg2 = 16'h2;
	#10;

	//move
	aluFunct = 4'b0000; reg1 = 16'h7FFF; reg2 = 16'h7FFF;
	#10;

	//swap
	aluFunct = 4'b0000; reg1 = 16'h7FFF; reg2 = 16'h7FFF;
	#10;

	//andi
	aluFunct = 4'b0000; reg1 = 16'h7FFF; reg2 = 16'h7FFF;
	#10;

	//ori
	aluFunct = 4'b0000; reg1 = 16'h7FFF; reg2 = 16'h7FFF;
	#10;

	//move
	aluFunct = 4'b0000; reg1 = 16'h7FFF; reg2 = 16'h7FFF;
	#10;
end
endmodule
