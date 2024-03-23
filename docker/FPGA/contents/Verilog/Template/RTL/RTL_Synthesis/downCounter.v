module downCounter
#(	
	parameter			HALF_KHZ	= 16'h4C4
)
(
	DEBOUNCED_START,	// Debounced Start Signal
	DEBOUNCED_STOP,		// Debounced Stop Signal
	ONE_SEC_PULSE,		// Validate Second Pulse
	COUNT_UP_SEC_PULSE,	// Second Value Count Up Pulse
	COUNT_UP_MIN_PULSE,	// Minute Value Count Up Pulse
	S_INPUT_LO,		// Input Second Unit Value
	S_INPUT_HI,		// Input Seoncd Tens Value
	M_INPUT_LO,		// Input Minute Unit Value
	M_INPUT_HI,		// Input Minute Tens Value
	RES_X,			// Reset
	CLK,			// Clock
	S_OUTPUT_LO,		// Output Second Unit Value
	S_OUTPUT_HI,		// Output Second Tens Value
	M_OUTPUT_LO,		// Output Minute Unit Value
	M_OUTPUT_HI,		// Output Minute Tens Value
	ARM			// Alarm
);


input			DEBOUNCED_START;
input			DEBOUNCED_STOP;
input			ONE_SEC_PULSE;
input			COUNT_UP_SEC_PULSE;
input			COUNT_UP_MIN_PULSE;
input		[3:0]	S_INPUT_LO;
input		[2:0]	S_INPUT_HI;
input		[3:0]	M_INPUT_LO;
input		[3:0]	M_INPUT_HI;
input			RES_X;
input			CLK;

output		[3:0]	S_OUTPUT_LO;
output		[3:0]	S_OUTPUT_HI;
output		[3:0]	M_OUTPUT_LO;
output		[3:0]	M_OUTPUT_HI;
output			ARM;

reg		[3:0]	S_OUTPUT_LO;
//reg		[3:0]	S_OUTPUT_HI;
reg		[3:0]	M_OUTPUT_LO;
reg		[3:0]	M_OUTPUT_HI;
reg			ARM;

reg			LATCH_START;
reg			LATCH_STOP;
reg		[2:0]	S_OUTPUT_HI_UNDEC;

wire			BUSY;
wire			COUNT_DOWN_PULSE;
wire			COUNT_UP_PULSE;
wire			SET_TIME_PULSE;
wire			CHANGE_TIME;
wire			CHECK_S_LO_IS_ZERO;
wire			CHECK_S_HI_IS_ZERO;
wire			CHECK_ZERO_SEC;
wire			CHECK_M_LO_IS_ZERO;
wire			CHECK_M_HI_IS_ZERO;
wire			CHECK_ZERO_MIN;
wire			ARM_SIG;
wire			ALL_ZERO;
wire			START_OR_STOP;

reg		[15:0]	ARM_WAVE;

// Validate State(Start or Stop)
assign START_OR_STOP = ( DEBOUNCED_START | DEBOUNCED_STOP);

// Latch Debounced Start Signal
always @( posedge CLK or negedge  RES_X ) begin
	if( !RES_X )
		LATCH_START <= 1'b0;
	else if( START_OR_STOP  )
		LATCH_START <= DEBOUNCED_START;
end

// Latch Debounced Stop Signal
always @( posedge CLK or negedge  RES_X ) begin
	if( !RES_X )
		LATCH_STOP <= 1'b0;
	else if( START_OR_STOP )
		LATCH_STOP <= DEBOUNCED_STOP;
end

// Check Counter State
assign BUSY = ( LATCH_START & ~ARM_SIG & ~LATCH_STOP);

// Validate Count Down State
assign COUNT_DOWN_PULSE = ( ONE_SEC_PULSE  & BUSY );

// Validate Count Up State
assign COUNT_UP_PULSE = ( COUNT_UP_SEC_PULSE | COUNT_UP_MIN_PULSE );

// Validate Set Time State
assign SET_TIME_PULSE = ( ~LATCH_START & COUNT_UP_PULSE );

// Validate Change Time
assign CHANGE_TIME = ( COUNT_DOWN_PULSE | SET_TIME_PULSE | LATCH_STOP );

// Count Down Second Unit
always @( posedge CLK or negedge  RES_X ) begin
	if( !RES_X )
		S_OUTPUT_LO <= 4'h0;
	else if (LATCH_STOP) 
		S_OUTPUT_LO <= S_OUTPUT_LO;
	else begin
		if ( CHANGE_TIME ) begin
			if( BUSY ) begin
				if( CHECK_S_LO_IS_ZERO )
					S_OUTPUT_LO <= 4'h9;
				else 
					S_OUTPUT_LO <= S_OUTPUT_LO - 4'h1;
			end else 
			S_OUTPUT_LO <= S_INPUT_LO;
		end
	end 
end

// Check Second Unit is Zero
assign CHECK_S_LO_IS_ZERO = ( S_OUTPUT_LO == 4'h0);

// Count Down Second tens
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		S_OUTPUT_HI_UNDEC <= 3'h0;
	else if ( LATCH_STOP ) 
		S_OUTPUT_HI_UNDEC <= S_OUTPUT_HI;
	else begin
		if ( CHANGE_TIME ) begin
			if ( BUSY ) begin
				if( CHECK_S_LO_IS_ZERO ) begin
					if( CHECK_S_HI_IS_ZERO )
						S_OUTPUT_HI_UNDEC <= 3'h5;
					else 
						S_OUTPUT_HI_UNDEC <= S_OUTPUT_HI_UNDEC -3'h1;
				end
			end  else 
			S_OUTPUT_HI_UNDEC <= S_INPUT_HI;			
		end
	end 
end
		
// add 0 to MSB for extand 4bits
assign 	S_OUTPUT_HI = (S_OUTPUT_HI_UNDEC === 3'bX)? 4'bX :  {1'b0, S_OUTPUT_HI_UNDEC};

// Check Second Tens is Zero	
assign CHECK_S_HI_IS_ZERO = ( S_OUTPUT_HI_UNDEC == 3'h0);

// Check Second is All Zero(Unit, Tens)
assign CHECK_ZERO_SEC = ( CHECK_S_LO_IS_ZERO & CHECK_S_HI_IS_ZERO);

// Check Minute Unit is Zero
assign CHECK_M_LO_IS_ZERO = ( M_OUTPUT_LO == 4'h0);

// Count Down Minute Unit
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		M_OUTPUT_LO <= 4'h0;
	else if ( LATCH_STOP )
		M_OUTPUT_LO <= M_OUTPUT_LO;
	else begin
		if( CHANGE_TIME ) begin
			if ( BUSY ) begin
				if( CHECK_ZERO_SEC ) begin
					if( CHECK_M_LO_IS_ZERO )
						M_OUTPUT_LO <= 4'h9;
					else	
						M_OUTPUT_LO <= M_OUTPUT_LO -4'h1;
				end
			end else
			M_OUTPUT_LO <= M_INPUT_LO;
		end 
	end
end

// Count Down Minute Tens
always @(posedge CLK or negedge  RES_X ) begin
	if ( !RES_X )
		M_OUTPUT_HI <= 4'h0;
	else if ( LATCH_STOP )
		M_OUTPUT_HI <= M_OUTPUT_HI;
	else begin
		if ( CHANGE_TIME ) begin
			if( BUSY ) begin
				if( CHECK_ZERO_SEC && CHECK_M_LO_IS_ZERO ) begin
					if( CHECK_M_HI_IS_ZERO )
						M_OUTPUT_HI <= 4'b0;
					else
						M_OUTPUT_HI <= M_OUTPUT_HI - 4'h1;
				end
			end else
			M_OUTPUT_HI <= M_INPUT_HI;
		end 
	end
end

// Check Minute Tens is Zero
assign CHECK_M_HI_IS_ZERO = ( M_OUTPUT_HI == 4'h0) ;

// Check Minute is All Zero(Unit, Tens)
assign CHECK_ZERO_MIN = ( CHECK_M_LO_IS_ZERO & CHECK_M_HI_IS_ZERO);

// Check Time is All Zero(00:00)
assign ALL_ZERO = ( CHECK_ZERO_SEC & CHECK_ZERO_MIN);

// Alarm Signal
assign ARM_SIG = ( ALL_ZERO & LATCH_START );

// Latch Alarm Signal
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		ARM_WAVE <=  16'h0;
	else if( ARM_SIG ) begin
		if( ARM_WAVE == HALF_KHZ )
			ARM_WAVE <= 16'h0;
		else
			ARM_WAVE <= ARM_WAVE + 16'h1;
	end
end

// Invert Alarm Signal Cycle
assign INVERT_ARM_WAVE = ( ( ARM_WAVE == 16'h0) & ARM_SIG );

// Invert Alarm Signal
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		ARM <= 1'b0;
	else if( INVERT_ARM_WAVE )
		ARM <= ~ARM;

end

endmodule
