module ADDER
(

	input wire [1:0] NUM1,
	input wire [1:0] NUM2,

	input wire CLK,
	input wire RES_X,

	output reg [1:0] SUM_OUT
);

always @( posedge CLK  or negedge RES_X ) begin

	if ( !RES_X ) begin
		SUM_OUT <= 2'b0;
	end
	else begin
		SUM_OUT <= NUM1 + NUM2;
	end
end

endmodule


