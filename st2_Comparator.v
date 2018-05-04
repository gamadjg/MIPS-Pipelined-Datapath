module st2_comparator(
	input [15:0] op1, reg15,
	output reg [1:0] Result);

always@(*)
begin
	if(op1 < reg15)//Branch Less Than
		begin
			assign Result = 2'b01;
		end
	else if(op1 > reg15)// Branch Greater Than
		begin
			assign Result = 2'b10;
		end
	else if(op1 == reg15)// Branch on equal
		begin
			assign Result = 2'b11;
		end
	else// Default
		begin
			assign Result = 2'b00;
		end
end

endmodule