module st2_hazard_unit(
		input [1:0] Comparator, //comparator values: 00 for less, 10 for greater, 11 for equal, 00: Do nothing
		input [3:0] Opcode, IFIDop1, IFIDop2, IDEXop1, IDEXop2,
		input ALU_Exception, IDEXMemRead,
		input [15:0] PC,
		output reg ChangePC, MemBubble, PCBubble, Halt,
		output reg [15:0] ExPC, ExErrorVal
	);

always@(*)
begin
// reset all signals to 0 at beginning of cycle
	ChangePC = 0;
	MemBubble = 0;
	PCBubble = 0;
	Halt = 0;
	ExPC = 0;
	ExErrorVal = 0;
		
// Data Hazard
	if(IDEXMemRead && ( (IFIDop1 == IDEXop1) || (IFIDop1 == IDEXop2) || (IFIDop2 == IDEXop1) || (IFIDop2 == IDEXop2)))begin
		MemBubble = 1;
		PCBubble = 1;
	end

// Branch Less Than
	else if((Opcode == 4'b0101) && Comparator == 2'b01)begin
		ChangePC = 1;
		MemBubble = 1;
	end
// Branch Greater Than
	else if((Opcode == 4'b0100) && Comparator == 2'b10)begin
		ChangePC = 1;
		MemBubble = 1;
	end
// Branch on Equal
	else if((Opcode == 4'b0110) && Comparator == 2'b11)begin 
		ChangePC = 1;
		MemBubble = 1;
	end
// Jump
	else if(Opcode == 4'b0001)begin 
		ChangePC = 1;
		MemBubble = 1;
	end
// Halt
	else if(Opcode == 4'b0000)begin 
		Halt = 1;
		ExPC = PC - 2;
		ExErrorVal = 16'h0001;
	end
// Overflow Exception
	else if(ALU_Exception)begin 
		Halt = 1;
		ExPC = PC - 4;
		ExErrorVal = 16'hAFFF; 
	end

// Opcode Failure
	else if(~(Opcode == 4'b1111 || Opcode == 4'b1000 || Opcode == 4'b1001 ||
				Opcode == 4'b1010 || Opcode == 4'b1011 || Opcode == 4'b1100 ||
				Opcode == 4'b1101 || Opcode == 4'b0101 || Opcode == 4'b0100 ||
				Opcode == 4'b0110 || Opcode == 4'b0001 || Opcode == 4'b0000))begin
		Halt = 1;
		ExPC = PC - 2;
		ExErrorVal = 16'hC000;
	end

end
endmodule