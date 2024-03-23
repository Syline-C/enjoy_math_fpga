module dynamicLamp
#(
	//parameter			MIL_SEC		= 	17'h1_E847,
	//parameter			MICRO_SEC	= 	17'h30D4,
	parameter			MIL_SEC		= 17'hF4,
	parameter			MICRO_SEC	= 17'h18,
	parameter			LIGHT_UP	= 	1'b1,
	parameter			LIGHT_DOWN	= 	1'b0,
	parameter			SEQUENCE_DIG_1	= 	2'd0,
	parameter			SEQUENCE_DIG_2	= 	2'd1,
	parameter			SEQUENCE_DIG_3	= 	2'd2,
	parameter			SEQUENCE_DIG_4	= 	2'd3
)
(
	M_SEV_SEG_OUT_HI_FROM_DEC,		// Decoded Minute Tens Value
	M_SEV_SEG_OUT_LO_FROM_DEC,		// Decoded Minute Unit Value
	S_SEV_SEG_OUT_HI_FROM_DEC,		// Decoded Second Tens Value
	S_SEV_SEG_OUT_LO_FROM_DEC,		// Decoded Second Unit Value
	CLK,					// Clock
	RES_X,					// Reset
	DIG_1,					// Light Up Minute Tens 7 Segment Signal
	DIG_2,					// Light Up Minute Unit 7 Segment Signal
	DIG_3,					// Light Up Second Tens 7 Segment Signal
	DIG_4,					// Light Up Second Unit 7 Segment Signal
	LIGHT_SEG,				// Time Value
	DP					// Light Up Dot Signal( Always 1'b0 ) 
);

input			[6:0]	M_SEV_SEG_OUT_HI_FROM_DEC;
input			[6:0]	M_SEV_SEG_OUT_LO_FROM_DEC;
input			[6:0]	S_SEV_SEG_OUT_HI_FROM_DEC;
input			[6:0]	S_SEV_SEG_OUT_LO_FROM_DEC;
input				CLK;
input				RES_X;
output				DIG_1;
output				DIG_2;
output				DIG_3;
output				DIG_4;
output			[6:0]	LIGHT_SEG;
output				DP;

reg				DIG_1;
reg				DIG_2;
reg				DIG_3;
reg				DIG_4;
reg			[6:0]	LIGHT_SEG;

reg			[16:0]	COUNT_ONE_MIL_SEC;
reg			[1:0]	LIGHT_UP_SEQUENCE;

wire				LIGHT_STATE;
reg			[6:0]	LIGHT_UP_TIME_VAL;
wire				LIGHT_UP_DIG_1;
wire				LIGHT_UP_DIG_2;
wire				LIGHT_UP_DIG_3;
wire				LIGHT_UP_DIG_4;


// Count 1ms 
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		COUNT_ONE_MIL_SEC <= 17'd00;

	else if ( COUNT_ONE_MIL_SEC == MIL_SEC )
		COUNT_ONE_MIL_SEC <= 17'd0;
	else
		COUNT_ONE_MIL_SEC <= COUNT_ONE_MIL_SEC + 17'h1;
end

// Verify 7 Segment Light Up Sequence 
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		LIGHT_UP_SEQUENCE <= 2'b0;

	else if( COUNT_ONE_MIL_SEC == MIL_SEC )
		LIGHT_UP_SEQUENCE <= LIGHT_UP_SEQUENCE + 2'b1;
end                                        

// Verify Light State                                           
assign LIGHT_STATE = (COUNT_ONE_MIL_SEC < MICRO_SEC )? LIGHT_DOWN : LIGHT_UP;

// Light Up Which 7 Segment( This : Minute Tens Seg)
assign LIGHT_UP_DIG_1 = ( LIGHT_STATE & ( LIGHT_UP_SEQUENCE == SEQUENCE_DIG_1 ) );

// Light Up Which 7 Segment( This : Minute Unit Seg)
assign LIGHT_UP_DIG_2 = ( LIGHT_STATE & ( LIGHT_UP_SEQUENCE == SEQUENCE_DIG_2 ) );

// Light Up Which 7 Segment( This : Second Tens Seg)
assign LIGHT_UP_DIG_3 = ( LIGHT_STATE & ( LIGHT_UP_SEQUENCE == SEQUENCE_DIG_3 ) );

// Light Up Which 7 Segment( This : Second Unit Seg)
assign LIGHT_UP_DIG_4 = ( LIGHT_STATE & ( LIGHT_UP_SEQUENCE == SEQUENCE_DIG_4 ) );

// Clock Syncronize Light Minute Tens Up Signal
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		DIG_1 <= 1'b0;
	else if ( LIGHT_UP_DIG_1 )
		DIG_1 <= 1'b1;
	else
		DIG_1 <= 1'b0;
end

// Clock Syncronize Light Minute Unit Up Signal
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		DIG_2 <= 1'b0;
	else if ( LIGHT_UP_DIG_2)
		DIG_2 <= 1'b1;
	else
		DIG_2 <= 1'b0;
end

// Clock Syncronize Light Second Tens Up Signal
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		DIG_3 <= 1'b0;
	else if ( LIGHT_UP_DIG_3)
		DIG_3 <= 1'b1;
	else
		DIG_3 <= 1'b0;
end


// Clock Syncronize Light Second Unit Up Signal
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		DIG_4 <= 1'b0;
	else if ( LIGHT_UP_DIG_4)
		DIG_4 <= 1'b1;
	else
		DIG_4 <= 1'b0;
end

// Set Which Time Value is Show 
always @( LIGHT_UP_SEQUENCE ) begin
	case ( LIGHT_UP_SEQUENCE )
		SEQUENCE_DIG_1	:	LIGHT_UP_TIME_VAL <= M_SEV_SEG_OUT_HI_FROM_DEC;
		SEQUENCE_DIG_2	:	LIGHT_UP_TIME_VAL <= M_SEV_SEG_OUT_LO_FROM_DEC;
		SEQUENCE_DIG_3	:	LIGHT_UP_TIME_VAL <= S_SEV_SEG_OUT_HI_FROM_DEC;
		SEQUENCE_DIG_4	:	LIGHT_UP_TIME_VAL <= S_SEV_SEG_OUT_LO_FROM_DEC;
		default		:	LIGHT_UP_TIME_VAL <= 7'b0000_000;
	endcase
end

// Clock Syncroinze Time Value
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		LIGHT_SEG <= 7'd0;
	else 
		LIGHT_SEG <= LIGHT_UP_TIME_VAL;
end

// Set Dot Signal( Always 1'b0)
assign DP = 1'b0;
endmodule
