/*
Jump/Branch Hazards
	will have to compare the comparator input with the opcode to determine if we are branching. Based on just the Opcode
	we can determine if its a jump. 
		-ChangePC is asserted when a Jump or a Branch is detected - it is a multiplexor signal
		that specifies which signal is chosen for PC. 

Load-Use Data Hazard
		MemBubble asserted when target register same as executing register
		& when memory Read is enabled


		-MemBubble is asserted when the target register in the Decode phase and the target
		register in the Execute phase are the same, and when the Execute phase has the signal
		for Memory Read enabled. This signal delays the Decode and Fetch phases to allow the
		Execute phase an additional cycle for retrieving data. It is also asserted during branch
		and jump instructions, so that the system does not write any values that are unwanted.


		-PCBubble is asserted only when the MemBubble signal is asserted, with the exception
		that it is not asserted during branches and jumps. This will allow PC to be overwritten
		while the rest of the system is bubbled.


		-Halt is asserted when a fatal error occurs. It stops the function of all phase buffers.
		

		-ExceptionPC is the PC value that is associated with the instruction that caused an error.


		-ExceptionValue is the error code given to decipher what kind of error occurred.
*/

module st2_hazard_unit(
		input [1:0] Comparator, //comparator values: 00 for less, 10 for greater, 11 for equal, 00: Do nothing
		input [3:0] Opcode, IfId_rt, IdEx_rt,
		input ALU_Exception, IdEx_MemRead, clk, rst,
		input [15:0] PC,
		output reg ChangePC, MemBubble, PCBubble, Halt,
		output reg [15:0] ExceptionPC, ExceptionValue
	);

reg [15:0] HoldPC, HoldException;
/* Probably dont even need synchronous logic in Hazard detection
always@(posedge clk or negedge rst)
	begin
		if(!rst)
			begin
				HoldPC <= 0;
				HoldException <= 0;
			end
		else
			begin
				if(HoldException != 0)
					begin
						HoldPC <= ExceptionPC;
						HoldException <= ExceptionValue;
					end
			end
	end
*/
always@(*)
begin
	if(!rst) //Resetting
		begin
			ChangePC = 0;
			MemBubble = 0;
			PCBubble = 0;
			Halt = 0;
			ExceptionPC = 0;
			ExceptionValue = 0;
		end
//___________________________________________________________________________________________________________________________________________________________		
// If were reading from memory, 
// ID/EX.memRead comes from ID/EX Buffer (control signal)
// IFIDop1 & op2 can come from forwarding unit, since this is the combinational part. 
	else if(IdEx_MemRead) //Memory Forward Bubbling	
	begin
		if(IFIDop1 == IDEXreg | IFIDop2 == IDEXreg)
		begin
			assign ChangePC = 0;
			assign MemBubble = 1;
			assign PCBubble = 1;
			assign Halt = 0;
			assign ExceptionPC = 0;
			assign ExceptionValue = 0;
		end
	end
//___________________________________________________________________________________________________________________________________________________________	
	else if(Opcode == 4'b0100 || Opcode == 4'b0101 || Opcode == 4'b0110) //Branch Handling
	begin
		if((Opcode[1] == Comparator[1]) && (Opcode[0] == Comparator[0]))
		begin
			assign ChangePC = 1;
			assign MemBubble = 1;
			assign PCBubble = 0;
			assign Halt = 0;
			assign ExceptionPC = 0;
			assign ExceptionValue = 0;
		end
		else
		begin
			assign ChangePC = 0;
			assign MemBubble = 0;
			assign PCBubble = 0;
			assign Halt = 0;
			assign ExceptionPC = 0;
			assign ExceptionValue = 0;
		end
	end
	else if(Opcode == 4'b1100) //Jump Handling
	begin
		assign ChangePC = 1;
		assign MemBubble = 1;
		assign PCBubble = 0;
		assign Halt = 0;
		assign ExceptionPC = 0;
		assign ExceptionValue = 0;
	end
	else if(~(Opcode == 4'b0000 || Opcode == 4'b0100 || Opcode == 4'b0101 ||
				Opcode == 4'b0110 || Opcode == 4'b1000 || Opcode == 4'b1011 ||
				Opcode == 4'b1100 || Opcode == 4'b1111)) //Opcode Error Handling
	begin
		assign ChangePC = 0;
		assign MemBubble = 0;
		assign PCBubble = 0;
		assign Halt = 1;
		assign ExceptionPC = PC - 2;
		assign ExceptionValue = 16'hC0DE; //C0D3 = 1100.0000.1101.1110 = Opcode Failure
	end
	else if(ALU_Exception) //ALU Error Handling
	begin
		assign ChangePC = 0;
		assign MemBubble = 0;
		assign PCBubble = 0;
		assign Halt = 1;
		assign ExceptionPC = PC - 4;
		assign ExceptionValue = 16'hADDF; //ADDF = 1011.1101.1101.1111 = ALU Failure
	end
	else if(Opcode == 1111) //Halt Opcode
	begin
		assign ChangePC = 0;
		assign MemBubble = 0;
		assign PCBubble = 0;
		assign Halt = 1;
		assign ExceptionPC = PC - 2;
		assign ExceptionValue = 16'h1111; //1111 = 0001.0001.0001.0001 = Halt
	end
end

endmodule
