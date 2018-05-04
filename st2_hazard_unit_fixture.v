`timescale 10ns/1ps
`include "st2_hazard_unit.v"

module st2_hazard_unit_fixture;
	reg [1:0] Comparator;
	reg [3:0] Opcode, IFIDop1, IFIDop2, IDEXop1, IDEXop2;
	reg ALU_Exception, IDEXMemRead;
	reg [15:0] PC;
	wire ChangePC, MemBubble, PCBubble, Halt;
	wire [15:0] ExPC, ExErrorVal;

st2_hazard_unit uut(Comparator, Opcode, IFIDop1, IFIDop2, IDEXop1, IDEXop2, ALU_Exception, IDEXMemRead, PC, ChangePC, MemBubble, PCBubble, Halt, ExPC, ExErrorVal);

initial 
	begin
		//$display ("op1\t|\treg15\t|\tResult");
		$monitor ("Inputs:\n  Comparator:%b   Opcode:%b   IFIDop1:%b  IFIDop2:%b  IDEXop1:%b  IDEXop2:%b  IDEXMemRead:%b\n  ALU_Exception:%b  PC:%b \nOutputs:\n  ChangePC:%b  MemBubble:%b  PCBubble:%b  Halt:%b  ExPC:%b  ExErrorVal:%b\n\n",
			Comparator, Opcode, IFIDop1, IFIDop2, IDEXop1, IDEXop2, IDEXMemRead, ALU_Exception, PC, ChangePC, MemBubble, PCBubble, Halt, ExPC, ExErrorVal);
	end

initial 
	begin
	// Data Hazard
	$display("Data Hazard");
		Comparator = 2'b00; 
		Opcode = 4'b1111;
		IFIDop1 = 4'b0011;
		IFIDop2 = 4'b1000;
		IDEXop1 = 4'b0011;
		IDEXop2 = 4'b0001;
		IDEXMemRead = 1'b1;
		ALU_Exception = 1'b0;
		PC = 16'hFFFF;
		#10;

	// Branch Less Than
		$display("Branch Less");
		Comparator = 2'b01; 
		Opcode = 4'b0101;
		IFIDop1 = 4'b0000;
		IFIDop2 = 4'b0000;
		IDEXop1 = 4'b0000;
		IDEXop2 = 4'b0000;
		IDEXMemRead = 1'b0;
		ALU_Exception = 1'b0;
		PC = 16'hFFFF;
		#10;

	// Branch Greater Than
		$display("Branch Greater");
		Comparator = 2'b10; 
		Opcode = 4'b0100;
		IFIDop1 = 4'b0000;
		IFIDop2 = 4'b0000;
		IDEXop1 = 4'b0000;
		IDEXop2 = 4'b0000;
		IDEXMemRead = 1'b0;
		ALU_Exception = 1'b0;
		PC = 16'hFFFF;
		#10;

	// Branch on Equal
		$display("Branch Equal");
		Comparator = 2'b11; 
		Opcode = 4'b0110;
		IFIDop1 = 4'b0000;
		IFIDop2 = 4'b0000;
		IDEXop1 = 4'b0000;
		IDEXop2 = 4'b0000;
		IDEXMemRead = 1'b0;
		ALU_Exception = 1'b0;
		PC = 16'hFFFF;
		#10;

	// Jump
		$display("Jump");
		Comparator = 2'b00; 
		Opcode = 4'b0001;
		IFIDop1 = 4'b0000;
		IFIDop2 = 4'b0000;
		IDEXop1 = 4'b0000;
		IDEXop2 = 4'b0000;
		IDEXMemRead = 1'b0;
		ALU_Exception = 1'b0;
		PC = 16'hFFFF;
		#10;

	// Halt
		$display("Halt");
		Comparator = 2'b00; 
		Opcode = 4'b0000;
		IFIDop1 = 4'b0000;
		IFIDop2 = 4'b0000;
		IDEXop1 = 4'b0000;
		IDEXop2 = 4'b0000;
		IDEXMemRead = 1'b0;
		ALU_Exception = 1'b0;
		PC = 16'hFFFF;
		#10;

	// ALU Exception
		$display("ALU Exception");
		Comparator = 2'b00; 
		Opcode = 4'b0100;
		IFIDop1 = 4'b0000;
		IFIDop2 = 4'b0000;
		IDEXop1 = 4'b0000;
		IDEXop2 = 4'b0000;
		IDEXMemRead = 1'b0;
		ALU_Exception = 1'b1;
		PC = 16'hFFFF;
		#10;

	// OpCode Failure
		$display("OpCode Failure");
		Comparator = 2'b00; 
		Opcode = 4'b1110;
		IFIDop1 = 4'b0000;
		IFIDop2 = 4'b0000;
		IDEXop1 = 4'b0000;
		IDEXop2 = 4'b0000;
		IDEXMemRead = 1'b0;
		ALU_Exception = 1'b1;
		PC = 16'hFFFF;
		#10;
		$finish;
	end
endmodule
