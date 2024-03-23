module setTime(
	DEBOUNCED_M_INPUT,	// Debounced Minute Input
	DEBOUNCED_S_INPUT,	// Debounced Second Input
	HALF_SEC_PULSE,		// Validate 0.5 Second Pulse
	DEBOUNCED_UP_DOWN,	// Debounced Change Up Down mode Signal
	CLK,			// Clock
	RES_X,			// Reset
	M_OUTPUT_HI,		// Setted Minute Tens Value
	M_OUTPUT_LO,		// Setted Minute Unit Value
	S_OUTPUT_HI,		// Setted Second Tens Value
	S_OUTPUT_LO,		// Setted Second Unit Value
	COUNT_UP_MIN_PULSE,	// Minute Value Count Up Pulse
	COUNT_UP_SEC_PULSE,	// Second Value Count Up Pulse
	KEEP_PUSHED_S_INPUT,	// Second Button Keep Pushed Signal
	KEEP_PUSHED_M_INPUT	// Minute Button Keep Pushed Signal
);

input			DEBOUNCED_M_INPUT;
input			DEBOUNCED_S_INPUT;
input			DEBOUNCED_UP_DOWN;
input			CLK;
input			RES_X;
input			HALF_SEC_PULSE;
input			KEEP_PUSHED_S_INPUT;
input			KEEP_PUSHED_M_INPUT;

output		[3:0]	M_OUTPUT_HI;
output		[3:0]	M_OUTPUT_LO;
output		[2:0]	S_OUTPUT_HI;
output		[3:0]	S_OUTPUT_LO;
output			COUNT_UP_MIN_PULSE;
output			COUNT_UP_SEC_PULSE;


reg		[3:0]	S_OUTPUT_LO;
reg		[2:0]	S_OUTPUT_HI;
reg		[3:0]	M_OUTPUT_LO;
reg		[3:0]	M_OUTPUT_HI;

reg			COUNT_UP_MIN_PULSE;
reg			COUNT_UP_SEC_PULSE;
reg			LATCH_UP_DOWN;

wire			PUSHED_SEC_HALF_SEC;
wire			PUSHED_MIN_HALF_SEC;

wire			SEC_UP_COUNT;
wire			MIN_UP_COUNT;

wire			ROUND_UP_SEC_TENS;
wire			ROUND_DOWN_SEC_TENS;
wire			ROUND_UP_MIN_TENS;
wire			ROUND_DOWN_MIN_TENS;


// Latch Debounced UP_DOWN Signal, Inverted by Debounced_UP_DOWN Signal
always @(posedge CLK or negedge RES_X ) begin
	if ( !RES_X )
		LATCH_UP_DOWN <= 1'b0;
	else if ( DEBOUNCED_UP_DOWN)
		LATCH_UP_DOWN <= ~LATCH_UP_DOWN;
end

// Check Second Button is  Keep Pushed 0.5 Second
assign PUSHED_SEC_HALF_SEC = ( KEEP_PUSHED_S_INPUT & HALF_SEC_PULSE );

// Validate Count Up Second Sigal
assign SEC_UP_COUNT = ( DEBOUNCED_S_INPUT | PUSHED_SEC_HALF_SEC );

// Clock Syncronize Count Up Second Signal 
always @(posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		COUNT_UP_SEC_PULSE <= 1'b0;
	else
		COUNT_UP_SEC_PULSE <= SEC_UP_COUNT;
end

// Check Minute Button is Keep Pushed 0.5 Second
assign PUSHED_MIN_HALF_SEC = ( KEEP_PUSHED_M_INPUT & HALF_SEC_PULSE );

// Validate Count Up Minute Signal
assign MIN_UP_COUNT= ( DEBOUNCED_M_INPUT | PUSHED_MIN_HALF_SEC );

// Clock Syncronize Count Up Minute Signal
always @( posedge CLK or negedge RES_X )  begin
	if( !RES_X )
		COUNT_UP_MIN_PULSE <= 1'b0;
	else
	 	COUNT_UP_MIN_PULSE <= MIN_UP_COUNT;
end

// Count Up or Count Down Second Unit Value 
always @( posedge CLK or negedge  RES_X ) begin	
	if( !RES_X ) begin
		S_OUTPUT_LO <= 4'h0;
	end
	else if ( SEC_UP_COUNT ) begin
		if( LATCH_UP_DOWN ) begin
			if( S_OUTPUT_LO == 4'h0 )
				S_OUTPUT_LO <= 4'h9;
			else
				S_OUTPUT_LO <= S_OUTPUT_LO - 4'h1;
		end 
		else begin
			if( S_OUTPUT_LO == 4'h9 ) 
				S_OUTPUT_LO <= 4'h0;
			else 
				S_OUTPUT_LO <= S_OUTPUT_LO + 4'h1;
		end
	end	
end

// Validate Second Tens Value Round Up
assign ROUND_UP_SEC_TENS = ( S_OUTPUT_LO == 4'h9);

// Validate Seond Tens Value Round Down
assign ROUND_DOWN_SEC_TENS = ( S_OUTPUT_LO == 4'h0);

// Count Up or Down Seond Tens Value 
always @( posedge CLK or negedge  RES_X ) begin	
	if( !RES_X ) begin
		S_OUTPUT_HI <= 3'h0;
	end
	else if ( SEC_UP_COUNT ) begin
		if( LATCH_UP_DOWN ) begin
			if( ROUND_DOWN_SEC_TENS ) begin
				if( S_OUTPUT_HI == 3'h0 )
					S_OUTPUT_HI <= 3'h5;
				else
					S_OUTPUT_HI <= S_OUTPUT_HI - 3'h1;
			end
		end 
		else begin
			if( ROUND_UP_SEC_TENS ) begin
				if( S_OUTPUT_HI == 4'h5 )
					S_OUTPUT_HI <= 3'h0;
				else
					S_OUTPUT_HI <= S_OUTPUT_HI + 3'h1;
			end
		end
	end
end

// Count Up or Down Minute Unit Value 
always @( posedge CLK or negedge  RES_X ) begin	
	if( !RES_X ) begin
		M_OUTPUT_LO <= 4'h0;
	end
	else if ( MIN_UP_COUNT ) begin
		if( LATCH_UP_DOWN ) begin
			if( M_OUTPUT_LO == 4'h0 )
				M_OUTPUT_LO <= 4'h9;
			else
				M_OUTPUT_LO <= M_OUTPUT_LO - 4'h1;
		end 
		else begin
			if( M_OUTPUT_LO == 4'h9 ) 
				M_OUTPUT_LO <= 4'h0;
			else 
				M_OUTPUT_LO <= M_OUTPUT_LO + 4'h1;
		end
	end	
end

//Validate Minute Tens Value Round Up
assign ROUND_UP_MIN_TENS = ( M_OUTPUT_LO == 4'h9);

// Validate Minute Tens Value Round Down
assign ROUND_DOWN_MIN_TENS = ( M_OUTPUT_LO == 4'h0);

// Count Up or Down Minute Tens Value
always @( posedge CLK or negedge  RES_X ) begin	
	if( !RES_X ) begin
		M_OUTPUT_HI <= 4'h0;
	end
	else if ( MIN_UP_COUNT ) begin
		if( LATCH_UP_DOWN ) begin
			if( ROUND_DOWN_MIN_TENS ) begin
				if( M_OUTPUT_HI == 4'h0 )
					M_OUTPUT_HI <= 4'h9;
				else
					M_OUTPUT_HI <= M_OUTPUT_HI - 4'h1;
			end
		end 
		else begin
			if( ROUND_UP_MIN_TENS ) begin
				if( M_OUTPUT_HI == 4'h9 )
					M_OUTPUT_HI <= 4'h0;
				else
					M_OUTPUT_HI <= M_OUTPUT_HI + 4'h1;
			end
		end
	end
end

endmodule
	
	
