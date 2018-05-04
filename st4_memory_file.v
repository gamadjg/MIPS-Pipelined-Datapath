module st4_memory_file(
	input clk, rst, 
	input [1:0] MemWrite, MemRead,
	input [15:0] Address, WriteData,
	output reg[15:0] ReadData, tempData
);

integer i;
reg [15:0] DataMem [15:0];
reg [15:0] temp;

always@(*)
begin
	case(MemRead)
			2'b00:begin // Default
				// Do Nothing
			end

			2'b01:begin // Load Word
				ReadData = DataMem [Address];
			end

			2'b10:begin // Load byte unsigned
				tempData = DataMem[Address];
				ReadData = {8'b0 , tempData[7:0]};
			end
	endcase
end


always@(posedge clk or negedge rst)
begin
	if(!rst)begin
		for(i = 0; i < 16'hFFFF; i = i + 1)begin
			DataMem[i] <= 16'b0;	
		end
		DataMem[0] <= 16'h2BCD;
		DataMem[2] <= 16'h0000;
		DataMem[4] <= 16'h1234;
		DataMem[6] <= 16'hDEAD;
		DataMem[8] <= 16'hBEEF;
	end
	
	if(MemWrite == 2'b00)begin // Defaultbegin
			//Do Nothing
	end
	else if(MemWrite == 2'b01)begin // Store Word
		DataMem[Address] <= WriteData;
	end
	else if(MemWrite == 2'b10)begin // Store Byte Unsigned
		//temp = DataMem[Address];
		temp = WriteData;
		DataMem[Address] <= temp[7:0]; //{temp[15:8],WriteData[7:0]};
	end
end
endmodule
