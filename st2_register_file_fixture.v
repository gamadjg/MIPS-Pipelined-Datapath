`timescale 10ns/1ps
`include "st2_register_file.v"

module st2_register_file_fixture;

	reg[3:0] ReadReg1, ReadReg2, Opcode;
	reg [3:0] WriteReg1, WriteReg2;
	reg [15:0] WriteDataReg1, WriteDataReg2;
	reg clk, rst, WriteR15;
	reg [1:0] regWrite;
	wire [15:0] ReadDataReg1, ReadDataReg2;

st2_register_file uut(ReadReg1, ReadReg2, Opcode, WriteReg1, WriteReg2, WriteDataReg1, WriteDataReg2, clk, rst, WriteR15, regWrite, ReadDataReg1, ReadDataReg2);

initial 
	begin
		$monitor("Inputs:\nReadReg1:%b  ReadReg2:%b  OpCode:%b  WriteReg1:%b  WriteReg2:%b  \nWriteDataReg1:%b  WriteDataReg2:%b  rst:%b  WriteR15:%b regWrite:%b\n\nOutputs:\nReadDataReg1:%b  ReadDataReg2:%b  clk:%b\n\n",
			               ReadReg1,    ReadReg2,    Opcode,    WriteReg1,    WriteReg2,      WriteDataReg1,    WriteDataReg2,    rst,    WriteR15,   regWrite,                ReadDataReg1,    ReadDataReg2,    clk);
	end

initial
	begin
		clk = 0;
		forever #10 clk = ~clk;
	end

initial 
	begin
		$display("Reset");
		rst = 1'b0;
		#10;

		$display("Reading on a positive clock with reset values");
		ReadReg1 = 4'b0001; 
		ReadReg2 = 4'b0001;
		Opcode = 4'b0001;
		WriteReg1 = 4'b0000;
		WriteReg2 = 4'b0000;
		WriteDataReg1 = 16'h0;
		//WriteDataR15 = 16'h0;
		WriteDataReg2 = 16'h0;
		WriteR15 = 1'b0;
		regWrite = 2'b00;
		rst = 1'b1;
		#10;

		$display("Writing on a negative clock and reading the values (Values don't change)");
		ReadReg1 = 4'b0001; 
		ReadReg2 = 4'b0001;
		Opcode = 4'b0001;
		WriteReg1 = 4'b0001;
		WriteReg2 = 4'b0001;
		WriteDataReg1 = 16'h0001;
		//WriteDataR15 = 16'h0001;
		WriteDataReg2 = 16'h0001;
		WriteR15 = 1'b0;
		regWrite = 2'b10;
		rst = 1'b1;
		#10;

		$display("Writing on a positive clock and reading the values (Values change)");
		ReadReg1 = 4'b0001; 
		ReadReg2 = 4'b0001;
		Opcode = 4'b0001;
		WriteReg1 = 4'b0001;
		WriteReg2 = 4'b0001;
		WriteDataReg1 = 16'h0001;
		//WriteDataR15 = 16'h0001;
		WriteDataReg2 = 16'h0001;
		WriteR15 = 1'b0;
		regWrite = 2'b10;
		rst = 1'b1;
		#10;

		$display("Waiting");		
		#10;

		$display("Writing to op1 & R15 on a positive clock");
		ReadReg1 = 4'b0001; 
		ReadReg2 = 4'b0001;
		Opcode = 4'b1111;
		WriteReg1 = 4'b0;
		WriteReg2 = 4'b0;
		WriteDataReg1 = 16'h000F;
		//WriteDataR15 = 16'h000F;
		WriteDataReg2 = 16'h00F0;
		WriteR15 = 1'b1;
		regWrite = 2'b10;
		rst = 1'b1;
		#10;

		$display("Reading reg1 & R15");
		ReadReg1 = 4'b0000; 
		ReadReg2 = 4'b0000;
		Opcode = 4'b0101;
		WriteReg1 = 4'b0;
		WriteReg2 = 4'b0;
		WriteDataReg1 = 16'b0;
		//WriteDataR15 = 16'h000F;
		WriteDataReg2 = 16'h0;
		WriteR15 = 1'b0;
		regWrite = 2'b00;
		rst = 1'b1;
		#10;
		$finish;
	end
endmodule
