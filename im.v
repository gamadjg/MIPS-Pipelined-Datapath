module im(clk, rst, address, inst); //instructions Mem.

input clk, rst;
input [15:0] address;
output [15:0] inst;
parameter totalIM = 100; // totalIM = Total Intrusction Mem. 
integer i;
reg [15:0] mem [0: totalIM - 1]; //Sets memory size acording to totalIM
reg [15:0] inst;

always @ (posedge clk or negedge rst)
begin
	if(~rst)
	begin
		mem[0] <= 16'hF120; // ADD R1, R2 
		mem[2] <= 16'hF121; // SUB R1, R2
		mem[4] <= 16'h93FF; // ORi R3, FF
		mem[6] <= 16'h134C; // ANDi R3, 4C
		mem[8] <= 16'hF564; // MUL R5, R6
		mem[10] <= 16'hF155; // DIV R1, R5
		mem[12] <= 16'hFFF1; // SUB R15, R15
		mem[14] <= 16'hF487; // MOV R4, R8
		mem[16] <= 16'hF428; // SWP R4, R6
		mem[18] <= 16'h9402; // ORi R4, 2
		mem[20] <= 16'hA694; // LBU R6, 4(R9)
		mem[22] <= 16'hD696; // SB R6, 6(R9)
		mem[24] <= 16'hC696; // LW R6, 6(R9)
		mem[26] <= 16'h6704; // BEQ R7, 4
		mem[28] <= 16'hFB10; // ADD R11, R1
		mem[30] <= 16'h5705; // BLT R7, 5
		mem[32] <= 16'hFB20; // ADD R11, R2
		mem[34] <= 16'h4702; // BGT R7, 2
		mem[36] <= 16'hF110; // ADD R1, R1
		mem[38] <= 16'hF110; // ADD R1, R1
		mem[40] <= 16'hC890; // LW R8, 0(R9)
		mem[42] <= 16'hF880; // ADD R8, R8
		mem[44] <= 16'hD892; // SW R8, 2(R9)
		mem[46] <= 16'hCA92; // LW R10, 2(R9)
		mem[48] <= 16'hFCC0; // ADD R12, R12
		mem[50] <= 16'hFDD1; // SUB R13, R13
		mem[52] <= 16'hFCD0; // ADD R12, R13
		mem[54] <= 16'hEFFF; // EFFF

	end
	else
		inst <= mem[address];
	end
endmodule