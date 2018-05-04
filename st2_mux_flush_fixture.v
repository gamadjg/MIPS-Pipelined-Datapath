`timescale 10ns/1ps
`include "st2_mux_flush.v"

module st2_mux_flush_fixture();

reg [15:0] ctrlSignals;
reg memBubble;
wire[15:0] result;

st2_mux_flush uut(ctrlSignals, memBubble, result);

initial
begin
	$monitor("\nctrlSignals = %b, memBubble = %b, result = %b\n", ctrlSignals, memBubble, result);
end

initial
begin
	ctrlSignals = 16'hFC72; memBubble = 0;
	#10;

	ctrlSignals = 16'hFC72; memBubble = 1;
	#10;

	$finish;
end
endmodule