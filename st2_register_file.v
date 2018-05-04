module st2_register_file(
	input [3:0] ReadReg1, ReadReg2, Opcode,
	input [3:0] WriteReg1, WriteReg2,
	input [15:0] WriteDataReg1, WriteDataReg2,
	input clk, rst, WriteR15,
	input [1:0] regWrite,
	output reg [15:0] ReadDataReg1, ReadDataReg2
	);

reg [15:0] RegisterFile [15:0];

// Combinational Logic for Reading register1 & 2. We also determine between using op2 or register 15 for ReadData2
always@(*)
begin
	case(ReadReg1)
		4'b0000: ReadDataReg1 = RegisterFile[0];
		4'b0001: ReadDataReg1 = RegisterFile[1];
		4'b0010: ReadDataReg1 = RegisterFile[2];
		4'b0011: ReadDataReg1 = RegisterFile[3];
		4'b0100: ReadDataReg1 = RegisterFile[4];
		4'b0101: ReadDataReg1 = RegisterFile[5];
		4'b0110: ReadDataReg1 = RegisterFile[6];
		4'b0111: ReadDataReg1 = RegisterFile[7];
		4'b1000: ReadDataReg1 = RegisterFile[8];
		4'b1001: ReadDataReg1 = RegisterFile[9];
		4'b1010: ReadDataReg1 = RegisterFile[10];
		4'b1011: ReadDataReg1 = RegisterFile[11];
		4'b1100: ReadDataReg1 = RegisterFile[12];
		4'b1101: ReadDataReg1 = RegisterFile[13];
		4'b1110: ReadDataReg1 = RegisterFile[14];
		4'b1111: ReadDataReg1 = RegisterFile[15];
	endcase

	if(Opcode == 4'b0101 || Opcode == 4'b0100 || Opcode == 4'b0110)
		begin
			ReadDataReg2 = RegisterFile[15];
		end
	else
		begin
			case(ReadReg2)
				4'b0000: ReadDataReg2 = RegisterFile[0];
				4'b0001: ReadDataReg2 = RegisterFile[1];
				4'b0010: ReadDataReg2 = RegisterFile[2];
				4'b0011: ReadDataReg2 = RegisterFile[3];
				4'b0100: ReadDataReg2 = RegisterFile[4];
				4'b0101: ReadDataReg2 = RegisterFile[5];
				4'b0110: ReadDataReg2 = RegisterFile[6];
				4'b0111: ReadDataReg2 = RegisterFile[7];
				4'b1000: ReadDataReg2 = RegisterFile[8];
				4'b1001: ReadDataReg2 = RegisterFile[9];
				4'b1010: ReadDataReg2 = RegisterFile[10];
				4'b1011: ReadDataReg2 = RegisterFile[11];
				4'b1100: ReadDataReg2 = RegisterFile[12];
				4'b1101: ReadDataReg2 = RegisterFile[13];
				4'b1110: ReadDataReg2 = RegisterFile[14];
				4'b1111: ReadDataReg2 = RegisterFile[15];
			endcase
		end
end

// Sequential Logic for writing
always@(posedge clk or negedge rst)
begin
	if(!rst) // On Reset
		begin
			RegisterFile[0] <= 16'h0;
			RegisterFile[1] <= 16'h0F00;
			RegisterFile[2] <= 16'h0050;
			RegisterFile[3] <= 16'hFF0F;
			RegisterFile[4] <= 16'hF0FF;
			RegisterFile[5] <= 16'h0040;
			RegisterFile[6] <= 16'h6666;
			RegisterFile[7] <= 16'h00FF;
			RegisterFile[8] <= 16'hFF88;
			RegisterFile[9] <= 16'b0;
			RegisterFile[10] <= 16'h0;
			RegisterFile[11] <= 16'h0;
			RegisterFile[12] <= 16'hCCCC;
			RegisterFile[13] <= 16'h0002;
			RegisterFile[14] <= 16'h0;
			RegisterFile[15] <= 16'h0;
		end
	else
		begin
			if(regWrite == 2'b01 || regWrite == 2'b10)
				begin
					case(WriteReg1)
						4'b0000: RegisterFile[0] <= WriteDataReg1;
						4'b0001: RegisterFile[1] <= WriteDataReg1;
						4'b0010: RegisterFile[2] <= WriteDataReg1;
						4'b0011: RegisterFile[3] <= WriteDataReg1;
						4'b0100: RegisterFile[4] <= WriteDataReg1;
						4'b0101: RegisterFile[5] <= WriteDataReg1;
						4'b0110: RegisterFile[6] <= WriteDataReg1;
						4'b0111: RegisterFile[7] <= WriteDataReg1;
						4'b1000: RegisterFile[8] <= WriteDataReg1;
						4'b1001: RegisterFile[9] <= WriteDataReg1;
						4'b1010: RegisterFile[10] <= WriteDataReg1;
						4'b1011: RegisterFile[11] <= WriteDataReg1;
						4'b1100: RegisterFile[12] <= WriteDataReg1;
						4'b1101: RegisterFile[13] <= WriteDataReg1;
						4'b1110: RegisterFile[14] <= WriteDataReg1;
						4'b1111: RegisterFile[15] <= WriteDataReg1;
					endcase
				end

			if(regWrite == 2'b10)
				begin
					if(WriteR15 == 1'b1)
						begin
							RegisterFile[15] <= WriteDataReg2;
						end
					else
						begin
							case(WriteReg2)
								4'b0000: RegisterFile[0] <= WriteDataReg2;
								4'b0001: RegisterFile[1] <= WriteDataReg2;
								4'b0010: RegisterFile[2] <= WriteDataReg2;
								4'b0011: RegisterFile[3] <= WriteDataReg2;
								4'b0100: RegisterFile[4] <= WriteDataReg2;
								4'b0101: RegisterFile[5] <= WriteDataReg2;
								4'b0110: RegisterFile[6] <= WriteDataReg2;
								4'b0111: RegisterFile[7] <= WriteDataReg2;
								4'b1000: RegisterFile[8] <= WriteDataReg2;
								4'b1001: RegisterFile[9] <= WriteDataReg2;
								4'b1010: RegisterFile[10] <= WriteDataReg2;
								4'b1011: RegisterFile[11] <= WriteDataReg2;
								4'b1100: RegisterFile[12] <= WriteDataReg2;
								4'b1101: RegisterFile[13] <= WriteDataReg2;
								4'b1110: RegisterFile[14] <= WriteDataReg2;
								4'b1111: RegisterFile[15] <= WriteDataReg2;
							endcase
						end
				end
		end
end
endmodule