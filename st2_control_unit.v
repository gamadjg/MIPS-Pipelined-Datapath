module st2_control_unit(OpCode, Funct, SE_Sel, regWrite, memRead, memWrite, ALUop, ctrlOp, R15Write, ALUsrc1, ALUsrc2, memToReg);

    input [3:0] OpCode, Funct;
    output reg [1:0] SE_Sel, regWrite, memRead, memWrite;
    output reg [3:0] ALUop, ctrlOp;
    output reg R15Write, ALUsrc1, ALUsrc2, memToReg;

always @(*)
    begin
        // Set all signals to zero
        SE_Sel = 2'b00;
        regWrite = 00;
        memRead = 0;
        memWrite = 0;
        ALUop = 0;
        ctrlOp = 0;
        R15Write = 0;
        ALUsrc1 = 0;
        ALUsrc2 = 0;
        memToReg = 0;

    	case(OpCode)
    		4'b1111: begin
                // Signals for: Signed Addition, Signed Subtraction, Move
                if((Funct == 4'b0000) || (Funct == 4'b0001) || (Funct == 4'b0111)) begin
                    regWrite = 01;
                    ALUop = Funct;
                end

                // Signals for: Signed Multiplication, Signd Division
                if((Funct == 4'b0100) || (Funct == 4'b0101)) begin
					
                // Use This if were coupling ALU output op2 w/ R15 --> If we do this, the fixture will change too. 
                    //regWrite = 10;
                    regWrite = 01;
                    R15Write = 1;
                    ALUop = Funct;

                end

                // Signal for: Swap
                if((Funct == 4'b1000)) begin
                    regWrite = 10;
                    ALUop = Funct;

                end
            end

            // andi
            4'b1000: begin// Signal for: Andi
                regWrite = 01;
                ALUsrc2 = 1;
                ALUop = 0010;

            end

            // Ori
            4'b1001: begin
                regWrite = 01;
                ALUsrc2 = 1;
                ALUop = OpCode;
            end
			    

            // Load Byte Unsigned
            4'b1010: begin
                ALUsrc1 = 1;
                SE_Sel = 01;
                memRead = 10;
                regWrite = 01;
                memToReg = 1;
                ALUop = OpCode;
            end

            // Store Byte
            4'b1011: begin
                ALUsrc1 = 1;
                SE_Sel = 01;
                memWrite = 10;
                ALUop = OpCode;
            end

            // Load Word
            4'b1100: begin
                ALUsrc1 = 1;
                SE_Sel = 01;
                memRead = 01;
                regWrite = 01;
                memToReg = 1;
                ALUop = OpCode;
            end

            // Store Word
            4'b1101: begin
                ALUsrc1 = 1;
                SE_Sel = 01;
                memWrite = 01;
                ALUop = OpCode;
            end

            // Branch Less Than
            4'b0101: begin
                SE_Sel = 10;
            end

            // Branch Greater Than
            4'b0100: begin
                SE_Sel = 10;
            end

            // Branch on Equal
            4'b0110: begin
                SE_Sel = 10;
            end

            // Jump
            4'b0001: begin
                SE_Sel = 11;
            end

            // Halt
            4'b0000: begin
            end
        endcase
        
        ctrlOp = OpCode;
    end
endmodule

