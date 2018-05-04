`timescale 10ns/10ps
`include "forwarding_unit_stg3.v"

module forwarding_unit_stg3_tb;

	reg [3:0] IDEXop1, IDEXop2, EXMEMop1, EXMEMop2, MEMWBop1;
	reg EXMEMregWrite, MEMWBregWrite;
	wire [1:0] F_Logic1, F_Logic2;

forwarding_unit_stg3 uut(IDEXop1, IDEXop2, EXMEMop1, EXMEMop2, MEMWBop1, EXMEMregWrite, MEMWBregWrite, F_Logic1, F_Logic2);

initial 
begin
	$monitor("\nIDEXop1:%b, IDEXop2:%b, EXMEMop1:%b, EXMEMop2:%b, MEMWBop1:%b, EXMEMregWrite:%b, MEMWBregWrite:%b\nF_Logic1:%b, F_Logic2:%b\n",IDEXop1, IDEXop2, EXMEMop1, EXMEMop2, MEMWBop1, EXMEMregWrite, MEMWBregWrite, F_Logic1, F_Logic2);
end

initial 
begin
	// IDEX op1 Hazard
	IDEXop1 = 5; IDEXop2 = 10; 
	EXMEMop1 = 5; EXMEMop2 = 11; MEMWBop1 = 14; 
	EXMEMregWrite = 1; MEMWBregWrite = 0;
	#10;

	// IDEX op2 Hazard
	IDEXop1 = 5; IDEXop2 = 10; 
	EXMEMop1 = 6; EXMEMop2 = 10; MEMWBop1 = 14; 
	EXMEMregWrite = 1; MEMWBregWrite = 0;
	#10;
	
	// IDEX op1 Hazard
	IDEXop1 = 5; IDEXop2 = 10; 
	EXMEMop1 = 11; EXMEMop2 = 5; MEMWBop1 = 14; 
	EXMEMregWrite = 1; MEMWBregWrite = 0;
	#10;

	// IDEX op2 Hazard
	IDEXop1 = 5; IDEXop2 = 10; 
	EXMEMop1 = 10; EXMEMop2 = 6; MEMWBop1 = 14; 
	EXMEMregWrite = 1; MEMWBregWrite = 0;
	#10;

	// MEMWB op1 Hazard
	IDEXop1 = 5; IDEXop2 = 10; 
	EXMEMop1 = 6; EXMEMop2 = 11; MEMWBop1 = 5; 
	EXMEMregWrite = 0; MEMWBregWrite = 1;
	#10;

	// MEMWB op2 Hazard
	IDEXop1 = 5; IDEXop2 = 10; 
	EXMEMop1 = 6; EXMEMop2 = 11; MEMWBop1 = 10; 
	EXMEMregWrite = 0; MEMWBregWrite = 1;
	#10;

	// Both
	IDEXop1 = 5; IDEXop2 = 10; 
	EXMEMop1 = 5; EXMEMop2 = 10; MEMWBop1 = 10; 
	EXMEMregWrite = 1; MEMWBregWrite = 0;
	#10;

	$finish;
end
endmodule