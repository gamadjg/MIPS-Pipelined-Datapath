`timescale 10ns/1ps
`include "st4_memory_file.v"

module st4_memory_file_fixture;
	reg clk, rst;
	reg [1:0] MemWrite, MemRead;
	reg [15:0] Address, WriteData;
	wire[15:0] ReadData, tempData;

st4_memory_file uut(clk, rst, MemWrite, MemRead, Address, WriteData, ReadData, tempData);

initial 
	begin
		$monitor("Inputs:\n  clk:%b  rst:%b\n  MemWrite:%b  MemRead:%b  Address:%b\n  WriteData:%b\nOutputs:\n  ReadData:%b\n\n",
			                 clk,    rst,      MemWrite,    MemRead,    Address,      WriteData,                ReadData);
	end

initial
	begin
		clk = 0;
		rst = 1'b0;
		forever #10 clk = ~clk;
	end

initial 
	begin

		$display("Reset");
		rst = 1'b0;
		#10;
		//#190;

		$display("Load 0");
		MemWrite = 2'b00;
		MemRead = 2'b01;
		Address = 16'h0000;
		WriteData = 16'h0;
		rst = 1'b1;
		#10;
		//$display("ReadData:%b", ReadData);
		//#10;

		$display("Load 2");
		MemWrite = 2'b00;
		MemRead = 2'b01;
		Address = 16'h0002;
		WriteData = 16'h0;
		#10;
		//$display("ReadData:%b", ReadData);

		$display("Load 4");
		MemWrite = 2'b00;
		MemRead = 2'b01;
		Address = 16'h0004;
		WriteData = 16'h0;
		#10;
		//$display("ReadData:%b", ReadData);

		$display("Load 6");
		MemWrite = 2'b00;
		MemRead = 2'b01;
		Address = 16'h0006;
		WriteData = 16'h0;
		#10;
		//$display("ReadData:%b", ReadData);

		$display("Load 8");
		MemWrite = 2'b00;
		MemRead = 2'b01;
		Address = 16'h0008;
		WriteData = 16'h0;
		#20;
		//$display("ReadData:%b", ReadData);


		$display("Store Word");
		MemWrite = 2'b01;
		MemRead = 2'b00;
		Address = 16'h0001;
		WriteData = 16'h8888;
		#10;

		$display("Load Word");
		MemWrite = 2'b00;
		MemRead = 2'b01;
		Address = 16'h0001;
		WriteData = 16'h0;
		#10;
		//$display("ReadData:%b", ReadData);

		//#10;

		$display("Store Byte");
		MemWrite = 2'b10;
		MemRead = 2'b00;
		Address = 16'h000A;
		WriteData = 16'hFFF8;
		#10;
		//$display("2---clk:%b   Store Byte:%b",clk, WriteData);

		$display("Load Byte");
		MemWrite = 2'b00;
		MemRead = 2'b01;
		Address = 16'h000A;
		WriteData = 16'h0;
		#10;
		//$display("Read Byte:%b", ReadData);


		//#10;
		//$display("Read Byte:%b", ReadData);
		//#10;
		$finish;
	end
endmodule
