`timescale 10ns/1ps
`include "st2_control_unit.v"

module st2_control_unit_fixture;

    reg [3:0] OpCode, Funct;
    wire [1:0] SE_Sel, regWrite, memRead, memWrite;
    wire [3:0] ALUop, ctrlOp;
    wire R15Write, ALUsrc1, ALUsrc2, memToReg;

st2_control_unit uut(OpCode, Funct, SE_Sel, regWrite, memRead, memWrite, ALUop, ctrlOp, R15Write, ALUsrc1, ALUsrc2, memToReg);

initial 
	begin
		//$display ("op1\t|\treg15\t|\tResult");
		$monitor ("OpCode:%b \t Funct:%b \t SE_Sel:%b \t regWrite:%b \t memRead:%b \t memWrite:%b \n ALUop:%b \t ctrlOp:%b \t R15Write:%b \t ALUsrc1:%b \t ALUsrc2:%b \t memToReg:%b\n\n",
			OpCode, Funct, SE_Sel, regWrite, memRead, memWrite, ALUop, ctrlOp, R15Write, ALUsrc1, ALUsrc2, memToReg);
	end

initial 
	begin
	// Add
		OpCode = 4'b1111; 
		Funct = 4'b0000;
		#10;
	// Sub
		OpCode = 4'b1111; Funct = 4'b0001;
		#10;
	// Mul
		OpCode = 4'b1111; Funct = 4'b0100;
		#10;
	// Div
		OpCode = 4'b1111; Funct = 4'b0101;
		#10;
	// Move
		OpCode = 4'b1111; Funct = 4'b0111;
		#10;
	// Swap
		OpCode = 4'b1111; Funct = 4'b1000;
		#10;
	// Andi
		OpCode = 4'b1000; 
		#10;
	// Ori
		OpCode = 4'b1001; 
		#10;
	// lbu
		OpCode = 4'b1010; 
		#10;
	// sb
		OpCode = 4'b1011; 
		#10;

	// lw
		OpCode = 4'b1100; 
		#10;

	// sw
		OpCode = 4'b1101; 
		#10;

	// blt
		OpCode = 4'b0101; 
		#10;

	// bgt
		OpCode = 4'b0100; 
		#10;

	// beq
		OpCode = 4'b0110; 
		#10;

	// Jump
		OpCode = 4'b0001; 
		#10;

	// Halt	
		OpCode = 4'b0000; 
		#10;
		$finish;
	end
endmodule
