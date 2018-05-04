module st3_alu(aluFunct, reg1, reg2, aluOut1, aluOut2, ALU_exception);

	input [3:0] aluFunct;
	input signed [15:0] reg1, reg2; 
	output signed [15:0] aluOut1, aluOut2; //R15, 
	output signed ALU_exception;

reg [16:0] tempReg1;
reg [15:0] tempReg2, R15, aluOut1, aluOut2;
reg msb, ALU_exception;
always@(*) 
begin
	ALU_exception = 0;
	msb = 0;
	tempReg1 = 0;
	tempReg2 = 0;
	
	case(aluFunct)
		// Signed Addition	
		4'b0000:begin
			tempReg2 = reg1 + reg2;
			msb = tempReg2[15];
  			if((reg1[15] == 1'b0 && reg2[15] == 1'b0) && msb == 1'b1)begin
				ALU_exception = 1;
			end
			else if((reg1[15] == 1'b1 && reg2[15] == 1'b1) && msb == 1'b0)begin
	  			ALU_exception = 1;
			end
			aluOut1 = tempReg2;
		end
		// Signed Subtraction		
		4'b0001:begin
			tempReg2 = reg1 - reg2;
			msb = tempReg2[15];
			if((reg1[15] == 1'b1 && reg2[15] == 1'b0) && msb == 1'b0)begin
	  			ALU_exception = 1;
			end
			else if((reg1[15] == 1'b0 && reg2[15] == 1'b1) && msb == 1'b1)begin
	  			ALU_exception = 1;
			end
			aluOut1 = tempReg2;
		end

		// Signed Multiplication		
		4'b0100:begin
			{tempReg1,tempReg2} = reg1 * reg2;

			//if(tempReg1[16] !== null)begin
			//	ALU_exception = 1;
			//end
			//else begin
				aluOut2 = tempReg1;
				aluOut1 = tempReg2;
			//end
		end

		// Signed Division		
		4'b0101:begin 
			aluOut1 = reg1 / reg2;
			R15 = reg1 % reg2;
			aluOut2 = R15;
		end

		// Move		
		4'b0111:begin
			aluOut1 = reg1;
		end

		// Swap	
		4'b1000:begin
			aluOut1 = reg2;
			aluOut2 = reg1;
		end

		// Andi
		4'b0010:begin
			aluOut1 = reg1 & reg2;
		end

		// Ori
		4'b1001:begin
			aluOut1 = reg1 | reg2;
		end

		// Load byte unsigned
		4'b1010:begin
			aluOut1 = reg1 + reg2;
		end // 4'b1010:

		// Store Byte
		4'b1011:begin
			aluOut1 = reg1 + reg2;
		end

		// Load Word
		4'b1100:begin
			aluOut1 = reg1 + reg2;
		end

		// Store Word
		4'b1101:begin
			aluOut1 = reg1 + reg2;
		end

		default: aluOut1 = 0;
	endcase
end
endmodule