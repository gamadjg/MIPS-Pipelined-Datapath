module st2_mux_flush(ctrlSignals, memBubble, result);

	input [15:0] ctrlSignals;
	input memBubble;
	output reg[15:0] result;


always @(*)
	begin
		if(memBubble == 0) 
			result = ctrlSignals;
		else
			result = 16'b0;
	end
endmodule