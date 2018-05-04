module st2_sign_extend(
	input [11:0] origInstruction,
	input [1:0]	SE_Sel,
	output reg [15:0] extended
);

//reg [15:0] extended;
always @(*)
	begin
		case(SE_Sel)
			2'b00:begin // set output to {8'b0, constant [7:0]}. Used for Andi & Ori
				extended[15:0] = {8'b0, origInstruction[7:0]};
			end

			2'b01:begin // Sign Extend immediate value [3:0]
				if(origInstruction[3] == 0) // Depending on MSB of immd value, we sign extend with either 0's or 1's
					begin
						extended[15:0] = {12'b0, origInstruction[3:0]}; // 12'b1 == 12'hFFF (one F?)
					end
				else if(origInstruction[3] == 1)
					begin
						extended[15:0] = {12'hFFF, origInstruction[3:0]};
					end
			end

			2'b10:begin // Sign Extend op2 [7:0]
				if(origInstruction[7] == 1'h0) 
					begin
						extended[15:0] = {8'b0, origInstruction[7:0]};
					end
				else
					begin
						extended[15:0] = {8'hFF, origInstruction[7:0]};
					end
			end

			2'b11:begin // Sign Extend 12 bit offset [11:0]
				if(origInstruction[11] == 1'h0) 
					begin
						extended[15:0] = {4'b0, origInstruction[11:0]};
					end
				else
					begin
						extended[15:0] = {4'hF, origInstruction[11:0]};
					end
			end
		endcase
	end
endmodule