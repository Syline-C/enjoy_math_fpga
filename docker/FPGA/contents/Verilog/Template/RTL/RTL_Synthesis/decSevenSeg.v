module decSevenSeg( 
	S_INPUT_LO,	// Input Second Unit Value
	S_INPUT_HI,	// Input Second Tens Value
	M_INPUT_LO,	// Input Minute Unit Value
	M_INPUT_HI,	// Input Minute Tens Value
	S_OUTPUT_LO,	// Output Decoded Second Unit Value
	S_OUTPUT_HI,	// OUtput Decoded Second Tens Value
	M_OUTPUT_LO,	// Output Decoded Minute Unit Value
	M_OUTPUT_HI	// Output Decoded Minute Tens Value
);

input		[3:0]	S_INPUT_LO;
input		[3:0]	S_INPUT_HI;
input		[3:0]	M_INPUT_LO;
input		[3:0]	M_INPUT_HI;

output		[6:0]	S_OUTPUT_LO;
output		[6:0]	S_OUTPUT_HI;
output		[6:0]	M_OUTPUT_LO;
output		[6:0]	M_OUTPUT_HI;

// Decode Time Value to 7 Segment Display
function [6:0] decodeSevenSeg;
	input	[3:0]	TIME_VAL;
	begin
		case ( TIME_VAL )
			4'h0	 : decodeSevenSeg = 7'b1111_110;
			4'h1	 : decodeSevenSeg = 7'b0110_000;
			4'h2	 : decodeSevenSeg = 7'b1101_101;
			4'h3	 : decodeSevenSeg = 7'b1111_001;
			4'h4	 : decodeSevenSeg = 7'b0110_011;
			4'h5	 : decodeSevenSeg = 7'b1011_011;
			4'h6	 : decodeSevenSeg = 7'b1011_111;
			4'h7	 : decodeSevenSeg = 7'b1110_010;
			4'h8	 : decodeSevenSeg = 7'b1111_111;
			4'h9	 : decodeSevenSeg = 7'b1111_011;
			4'hF	 : decodeSevenSeg = 7'b0000_000;
			default	 : decodeSevenSeg = 7'b1011_111;
		endcase
	end
endfunction

// Decoded Second Unit Value
assign S_OUTPUT_LO = decodeSevenSeg(S_INPUT_LO);

// Decoded Second Tens Value
assign S_OUTPUT_HI = decodeSevenSeg(S_INPUT_HI);

// Decoded Minute Unit Value
assign M_OUTPUT_LO = decodeSevenSeg(M_INPUT_LO);

// Decoded Minute Tens Value
assign M_OUTPUT_HI = decodeSevenSeg(M_INPUT_HI);

endmodule
