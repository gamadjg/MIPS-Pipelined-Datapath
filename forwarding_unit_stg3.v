module forwarding_unit_stg3(
	input [3:0] IDEXop1, IDEXop2, EXMEMop1, EXMEMop2, MEMWBop1,
	input EXMEMregWrite, MEMWBregWrite,
	output reg [1:0] F_Logic1, F_Logic2
);
/*
	We are checking the forwarding unit as usual for op1 at the EXMEM & MEMWB stage. 
	The reason why we check EXMEMop2 for both forwarding mux's is because op2 can be written to and forwarded when performing a
		swap. Since swap registers are returned at stage 3, we only have to check EXMEM for both op1 & 2.
	Example:
		swap $R3, $R6
		add  $R3, $R6
	  ->We also check op2.
	  ->Forwarding signals and mux's have been edited to support this situation


	For regWrite at any stage, we are checking to make sure it is non-zero. As seen on the truth table logic, if regwrite is:
	00: We are not forwarding nor writing back to any register. 
	01: Only writing back/Forwarding op1. 
	10: Writing back/Forwarding to op1 (and possibly op2)
*/

always@(*)
begin

	// If nothing is being forwarded, 00 is passed to the forwarding mux's. This indicates that we are using the 'regular' values
	F_Logic1 = 2'b00;
	F_Logic2 = 2'b00;

	if(EXMEMregWrite !== 2'b00 && ((EXMEMop1 !== 0) || (EXMEMop2 !== 0)))begin
		// IDEX op1 Hazard
		if(IDEXop1 == EXMEMop1)begin
			F_Logic1 = 2'b01;
		end
		// IDEX op2 Hazard
		else if(IDEXop2 == EXMEMop1)begin
			F_Logic2 = 2'b01;
		end

		// IDEX op1 Hazard
		if(IDEXop1 == EXMEMop2)begin
			F_Logic1 = 2'b11;
		end
		// IDEX op2 Hazard
		else if(IDEXop2 == EXMEMop2)begin
			F_Logic2 = 2'b11;
		end
	end
	


	if(MEMWBregWrite != 2'b00 && (MEMWBop1 !== 0))begin
		// MEMWB op1 Hazard
		if(IDEXop1 == MEMWBop1)begin
			F_Logic1 = 2'b10;
		end
		// MEMWB op2 Hazard
		else if(IDEXop2 == MEMWBop1)begin
			F_Logic2 = 2'b10;
		end	
	end
end
endmodule