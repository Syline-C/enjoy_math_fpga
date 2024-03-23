module kitchenTimer
#(	
	//parameter			VAL_ONE_SEC	= 27'h773_593F,
	//parameter			VAL_HALF_SEC	= 26'h3B9_AC9F,
	//parameter			VAL_DEBOUNCE	= 21'h10_0000,
	parameter			VAL_ONE_SEC	= 18'h3B9AC,
	parameter			VAL_HALF_SEC	= 17'h1DCD5,
	parameter			VAL_DEBOUNCE	= 13'h1000,
	parameter			STATE_CLEAR	= 2'b11,
	parameter			STATE_START	= 2'b01,
	//parameter			MIL_SEC		= 17'h1_E847,
	//parameter			MICRO_SEC	= 17'h30D4,
	parameter			MIL_SEC		= 17'hF4,
	parameter			MICRO_SEC	= 17'h18,
	parameter			LIGHT_UP	= 1'b1,
	parameter			LIGHT_DOWN	= 1'b0,
	parameter			SEQUENCE_DIG_1	= 2'd0,
	parameter			SEQUENCE_DIG_2	= 2'd1,
	parameter			SEQUENCE_DIG_3	= 2'd2,
	parameter			SEQUENCE_DIG_4	= 2'd3,
	parameter			HALF_KHZ	= 16'h4C4
)
(
	M_INPUT,		// Count Up Minute Value Signal
	S_INPUT,		// Count Up Second Value Signal
	START,			// Start Signal
	STOP,			// Stop Signal
	UP_DOWN,		// Up Down Mode Change Signal
	CLK,			// Clock
	RES,			// Reset
	DIG_1,			// Light Up Minute Tens 7 Segment Signal
	DIG_2,			// Light Up Minute Unit 7 Segment Signal
	DIG_3,			// Light Up Second Tens 7 Segment Signal
	DIG_4,			// Light Up Second Unit 7 Segment Signal
	LIGHT_SEG,		// Show 7 Segment Time Value
	DP,			// Light Up dot Signal( Always 1'b0)
	ARM			// Alarm
);

input			M_INPUT;
input			S_INPUT;
input			STOP;
input			UP_DOWN;
input			CLK;
input			START;
input			RES;

output			DIG_1;
output			DIG_2;
output			DIG_3;
output			DIG_4;
output		[6:0]	LIGHT_SEG;
output			ARM;
output			DP;

wire			DEBOUNCED_M_INPUT;
wire			DEBOUNCED_S_INPUT;
wire			DEBOUNCED_START;
wire			DEBOUNCED_STOP;
wire			DEBOUNCED_UP_DOWN;

wire			ONE_SEC_PULSE;
wire			HALF_SEC_PULSE;
wire			RES_X;

wire		[2:0]	UP_S_OUTPUT_HI;
wire		[3:0]	UP_S_OUTPUT_LO;
wire		[3:0]	UP_M_OUTPUT_HI;
wire		[3:0]	UP_M_OUTPUT_LO;
wire			UP_CNT_MIN_PULSE;
wire			UP_CNT_SEC_PULSE;

wire		[3:0]	DOWN_S_OUTPUT_HI;
wire		[3:0]	DOWN_S_OUTPUT_LO;
wire		[3:0]	DOWN_M_OUTPUT_HI;
wire		[3:0]	DOWN_M_OUTPUT_LO;

wire		[6:0]	DEC_M_OUTPUT_HI;
wire		[6:0]	DEC_M_OUTPUT_LO;
wire		[6:0]	DEC_S_OUTPUT_HI;
wire		[6:0]	DEC_S_OUTPUT_LO;

wire			DEBOUNCE_PULSE;
wire			KEEP_PUSHED_M_INPUT;
wire			KEEP_PUSHED_S_INPUT;

// Syncronize Input Signal Module
sync		sync( 
			.M_INPUT			(M_INPUT), 
			.S_INPUT			(S_INPUT), 
			.START				(START), 
			.UP_DOWN			(UP_DOWN),
			.STOP				(STOP),
			.CLK				(CLK), 
			.RES_X				(RES_X), 
			.DEBOUNCE_PULSE			(DEBOUNCE_PULSE),
			.DEBOUNCED_M_INPUT		(DEBOUNCED_M_INPUT), 
			.DEBOUNCED_S_INPUT		(DEBOUNCED_S_INPUT), 
			.DEBOUNCED_START		(DEBOUNCED_START),
			.DEBOUNCED_UP_DOWN		(DEBOUNCED_UP_DOWN),
			.DEBOUNCED_STOP			(DEBOUNCED_STOP),
			.KEEP_PUSHED_S_INPUT		(KEEP_PUSHED_S_INPUT),
			.KEEP_PUSHED_M_INPUT		(KEEP_PUSHED_M_INPUT)
		);

// Validate 1 Second, 0.5 Second Module
clockCounter #(	

			.VAL_ONE_SEC			(VAL_ONE_SEC),
			.VAL_HALF_SEC			(VAL_HALF_SEC),
			.VAL_DEBOUNCE			(VAL_DEBOUNCE),
			.STATE_CLEAR			(STATE_CLEAR),
		//	.STATE_STOP			(STATE_STOP),
			.STATE_START			(STATE_START)
)
clockCounter(
			.DEBOUNCED_M_INPUT		(DEBOUNCED_M_INPUT), 
			.DEBOUNCED_S_INPUT		(DEBOUNCED_S_INPUT), 
			.DEBOUNCED_START		(DEBOUNCED_START), 
			.DEBOUNCED_STOP			(DEBOUNCED_STOP),
			.DEBOUNCED_UP_DOWN		(DEBOUNCED_UP_DOWN),
			.CLK				(CLK), 
			.RES				(RES), 
			.ONE_SEC_PULSE			(ONE_SEC_PULSE), 
			.HALF_SEC_PULSE			(HALF_SEC_PULSE),
			.RES_X				(RES_X),
			.DEBOUNCE_PULSE			(DEBOUNCE_PULSE)
		);

// SetTime Module
setTime		setTime( 
			.DEBOUNCED_M_INPUT		(DEBOUNCED_M_INPUT), 
			.DEBOUNCED_S_INPUT		(DEBOUNCED_S_INPUT),
			.DEBOUNCED_UP_DOWN		(DEBOUNCED_UP_DOWN),
			.HALF_SEC_PULSE			(HALF_SEC_PULSE), 
			.CLK				(CLK), 
			.RES_X				(RES_X), 
			.S_OUTPUT_LO			(UP_S_OUTPUT_LO), 
			.S_OUTPUT_HI			(UP_S_OUTPUT_HI), 
			.M_OUTPUT_LO			(UP_M_OUTPUT_LO), 
			.M_OUTPUT_HI			(UP_M_OUTPUT_HI), 
			.COUNT_UP_MIN_PULSE		(UP_CNT_MIN_PULSE), 
			.COUNT_UP_SEC_PULSE		(UP_CNT_SEC_PULSE),
			.KEEP_PUSHED_S_INPUT		(KEEP_PUSHED_S_INPUT),
			.KEEP_PUSHED_M_INPUT		(KEEP_PUSHED_M_INPUT)
		);

// Count Down Module
downCounter	
#(
			.HALF_KHZ			(HALF_KHZ)
)

downCounter( 
			.DEBOUNCED_START		(DEBOUNCED_START), 
			.DEBOUNCED_STOP			(DEBOUNCED_STOP),
			.ONE_SEC_PULSE			(ONE_SEC_PULSE), 
			.COUNT_UP_MIN_PULSE		(UP_CNT_MIN_PULSE), 
			.COUNT_UP_SEC_PULSE		(UP_CNT_SEC_PULSE),
			.S_INPUT_LO			(UP_S_OUTPUT_LO), 
			.S_INPUT_HI			(UP_S_OUTPUT_HI), 
			.M_INPUT_HI			(UP_M_OUTPUT_HI), 
			.M_INPUT_LO			(UP_M_OUTPUT_LO), 
			.RES_X				(RES_X), 
			.CLK				(CLK), 
			.S_OUTPUT_HI			(DOWN_S_OUTPUT_HI),
			.S_OUTPUT_LO			(DOWN_S_OUTPUT_LO),
			.M_OUTPUT_HI			(DOWN_M_OUTPUT_HI),
			.M_OUTPUT_LO			(DOWN_M_OUTPUT_LO),
			.ARM				(ARM)
		);

// Decode Seven Segment module
decSevenSeg	decSevenSeg(
			.S_INPUT_LO			(DOWN_S_OUTPUT_LO),
			.S_INPUT_HI			(DOWN_S_OUTPUT_HI),
			.M_INPUT_LO			(DOWN_M_OUTPUT_LO),
			.M_INPUT_HI			(DOWN_M_OUTPUT_HI),
			.S_OUTPUT_LO			(DEC_S_OUTPUT_LO),
			.S_OUTPUT_HI			(DEC_S_OUTPUT_HI),
			.M_OUTPUT_LO			(DEC_M_OUTPUT_LO),
			.M_OUTPUT_HI			(DEC_M_OUTPUT_HI)
		);


// dynamic Light Up Module
dynamicLamp	
#(
			.MIL_SEC			(MIL_SEC),
			.MICRO_SEC			(MICRO_SEC),
			.LIGHT_UP			(LIGHT_UP),
			.LIGHT_DOWN			(LIGHT_DOWN),
			.SEQUENCE_DIG_1			(SEQUENCE_DIG_1),
			.SEQUENCE_DIG_2			(SEQUENCE_DIG_2),	
			.SEQUENCE_DIG_3			(SEQUENCE_DIG_3),		
			.SEQUENCE_DIG_4			(SEQUENCE_DIG_4)
)
dynamicLamp(
			.M_SEV_SEG_OUT_HI_FROM_DEC	( DEC_M_OUTPUT_HI ),
			.M_SEV_SEG_OUT_LO_FROM_DEC	( DEC_M_OUTPUT_LO ),
			.S_SEV_SEG_OUT_HI_FROM_DEC	( DEC_S_OUTPUT_HI ),
			.S_SEV_SEG_OUT_LO_FROM_DEC	( DEC_S_OUTPUT_LO ),
			.CLK				( CLK ),
			.RES_X				( RES_X ),
			.DIG_1				( DIG_1 ),
			.DIG_2				( DIG_2 ),
			.DIG_3				( DIG_3 ),
			.DIG_4				( DIG_4 ),
			.LIGHT_SEG			( LIGHT_SEG ),
			.DP				( DP)  
		);

endmodule
