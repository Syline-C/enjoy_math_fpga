module clockCounter
#(
	//parameter	VAL_ONE_SEC	= 27'h773_593F,
	//parameter	VAL_HALF_SEC	= 26'h3B9_AC9F,
	//parameter	VAL_DEBOUNCE	= 21'h10_0000,
	parameter			VAL_ONE_SEC	= 18'h3B9AC,
	parameter			VAL_HALF_SEC	= 17'h1DCD5,
	parameter			VAL_DEBOUNCE	= 13'h1000,
	parameter	STATE_CLEAR	= 2'b11,
	parameter	STATE_START	= 2'b01
)
(	DEBOUNCED_M_INPUT,		// Debounced Count Up Minute Signal
	DEBOUNCED_S_INPUT,		// Debounced Count Up Second Signal
	DEBOUNCED_START,		// Debounced Start Signal
	DEBOUNCED_STOP,			// Debounced Start Signal
	DEBOUNCED_UP_DOWN,		// Debounced Stop Signal
	CLK,				// Clock
	RES,				// Reset
	ONE_SEC_PULSE,			// Check is 1 Second Pulse
	HALF_SEC_PULSE,			// Check is 0.5 Second Pulse
	RES_X,				// Invert Reset Signal
	DEBOUNCE_PULSE			// Debounce Chattering Signal
);

input		DEBOUNCED_M_INPUT;
input		DEBOUNCED_S_INPUT;
input		DEBOUNCED_START;
input		DEBOUNCED_STOP;
input		DEBOUNCED_UP_DOWN;
input		CLK;
input		RES;

output		ONE_SEC_PULSE;
output		HALF_SEC_PULSE;
output		RES_X;
output		DEBOUNCE_PULSE;

reg	[17:0]	COUNT_ONE_SEC;
reg	[16:0]	COUNT_HALF_SEC;

reg		LATCH_START;
reg		LATCH_STOP;

wire		PUSHED_TIME_SET;
wire		CLEAR_HALF_SEC;
wire	[1:0]	ONE_SEC_COUNTER_STATE;

// Validate State(Start or Stop)
assign STOP_OR_START = ( DEBOUNCED_STOP | DEBOUNCED_START);

// Latch Debounced Start Signal
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		LATCH_START <= 1'b0;
	else if ( STOP_OR_START )
		LATCH_START <= DEBOUNCED_START;
end

// Latch Debounced Stop Signal
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		LATCH_STOP <= 1'b0;
	else if ( STOP_OR_START )
		LATCH_STOP <= DEBOUNCED_STOP;
end

// Check One Sec Counter Current State 
assign ONE_SEC_COUNTER_STATE = { ONE_SEC_PULSE, LATCH_START};

//  Count up Register COUNT_ONE_SEC by Clock and Validate 1 Second
always @( posedge CLK or negedge RES_X ) begin
	if ( !RES_X )
		COUNT_ONE_SEC <= 18'd0;
	else begin
		case ( ONE_SEC_COUNTER_STATE ) 
			STATE_CLEAR	:	COUNT_ONE_SEC <= 18'd0;
			STATE_START	:	COUNT_ONE_SEC <= COUNT_ONE_SEC + 18'd1;
			default		:	COUNT_ONE_SEC <= COUNT_ONE_SEC;
		endcase
	end
end

// Check is 1 Seceond 
assign	ONE_SEC_PULSE = (COUNT_ONE_SEC == VAL_ONE_SEC);

//  Check Set Minute or Second Pushed
assign PUSHED_TIME_SET = ( DEBOUNCED_S_INPUT | DEBOUNCED_M_INPUT );

//  Check Set Minute Signal or Set Second Signal is Pushed
assign CLEAR_HALF_SEC = ( PUSHED_TIME_SET | HALF_SEC_PULSE );

//  Validate 0.5 Second
always @( posedge CLK or negedge RES_X ) begin
	if ( !RES_X ) 
		COUNT_HALF_SEC <= 17'd0;
	else if( CLEAR_HALF_SEC ) 
		COUNT_HALF_SEC <=  17'd0;
	else
		COUNT_HALF_SEC <= COUNT_HALF_SEC + 17'd1;
end	

// Check is 0.5 Second
assign	HALF_SEC_PULSE = (COUNT_HALF_SEC == VAL_HALF_SEC );

// Debounce Chattering Signal
//assign  DEBOUNCE_PULSE = ( COUNT_HALF_SEC[20:0] ==  VAL_DEBOUNCE ) ;
assign  DEBOUNCE_PULSE = ( COUNT_HALF_SEC[12:0] ==  VAL_DEBOUNCE ) ;
 
// Invert Reset Signal
assign RES_X = ~RES;

endmodule

	
