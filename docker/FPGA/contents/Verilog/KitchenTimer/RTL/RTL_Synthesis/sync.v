module sync(
	M_INPUT,			// Count Up Minute Value Signal
	S_INPUT,			// Count Up Second Value Signal
	START,				// Start Sginal
	STOP,				// Stop Signal
	UP_DOWN,			// Change Up Down Mode Signal
	CLK,				// Clock
	RES_X,				// Reset
	DEBOUNCE_PULSE,			// Debounce Cycle Pulse
	DEBOUNCED_M_INPUT,		// Debounced Count Up Minute Signal
	DEBOUNCED_S_INPUT,		// Debounced Count Up Second Signal
	DEBOUNCED_START,		// Debounced Start Signal
	DEBOUNCED_STOP,			// Debounced Stop Signal
	DEBOUNCED_UP_DOWN,		// Debounced Up Down Signal
	KEEP_PUSHED_M_INPUT,		// Keep Pushed Minute Input Signal
	KEEP_PUSHED_S_INPUT		// Keep Pushed Second Input Signal
);

input		M_INPUT;
input		S_INPUT;
input		START;
input		UP_DOWN;
input		STOP;
input		CLK;
input		RES_X;
input		DEBOUNCE_PULSE;

output		DEBOUNCED_M_INPUT;
output		DEBOUNCED_S_INPUT;
output		DEBOUNCED_START;
output		DEBOUNCED_STOP;
output		DEBOUNCED_UP_DOWN;
output		KEEP_PUSHED_M_INPUT;
output		KEEP_PUSHED_S_INPUT;


reg		READ_M_INPUT;
reg		READ_S_INPUT;
reg		READ_START;
reg		READ_STOP;
reg		READ_UP_DOWN;
reg		KEEP_PUSHED_S_INPUT;
reg		KEEP_PUSHED_M_INPUT;
reg		DELAYED_READ_M_INPUT;
reg		DELAYED_READ_S_INPUT;
reg		DELAYED_READ_START;
reg		DELAYED_READ_STOP;
reg		DELAYED_READ_UP_DOWN;

wire		DEBOUNCED_INVERT_M_INPUT;
wire		DEBOUNCED_INVERT_S_INPUT;
wire		ACTIVATE_M_BUTTON;
wire		ACTIVATE_S_BUTTON;
wire	        RACE_STOP;

// Read Minute Input Signal by Debounce Pulse
always @( posedge CLK or negedge RES_X) begin
	if( !RES_X ) 	
		READ_M_INPUT <= 1'b0;
	else if ( DEBOUNCE_PULSE )
		READ_M_INPUT <= M_INPUT;
end

// Delay One DEBOUNCE_PULSE Cycle REAd_M_INPUT 
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		DELAYED_READ_M_INPUT <= 1'b0;
	else if ( DEBOUNCE_PULSE )
		DELAYED_READ_M_INPUT <= READ_M_INPUT;
end

// Debounce M_INPUT Signal
assign DEBOUNCED_M_INPUT = ( READ_M_INPUT & ~DELAYED_READ_M_INPUT & DEBOUNCE_PULSE);
// Falling Edge Check Debounce Chattering M_INPUT
assign DEBOUNCED_INVERT_M_INPUT = ( ~READ_M_INPUT & DELAYED_READ_M_INPUT & DEBOUNCE_PULSE);
// Validate Released M_INPUT Button
assign ACTIVATE_M_BUTTON = ( DEBOUNCED_M_INPUT | DEBOUNCED_INVERT_M_INPUT );

// Make Minute Button Keep Pushed Signal
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		KEEP_PUSHED_M_INPUT <= 1'b0;
	else if( ACTIVATE_M_BUTTON )
		KEEP_PUSHED_M_INPUT <= DEBOUNCED_M_INPUT;
end

// Read Second Input Signal by Debounce Pulse
always @( posedge CLK or negedge RES_X) begin
	if( !RES_X ) 	
		READ_S_INPUT <= 1'b0;
	else if ( DEBOUNCE_PULSE )
		READ_S_INPUT <= S_INPUT;
end

// Delay One DEBOUNCE_PUSLE CYCLE READ_S_INPUT
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		DELAYED_READ_S_INPUT <= 1'b0;
	else if ( DEBOUNCE_PULSE )
		DELAYED_READ_S_INPUT <= READ_S_INPUT;
end

// Debounce M_INPUT
assign DEBOUNCED_S_INPUT = ( READ_S_INPUT & ~DELAYED_READ_S_INPUT & DEBOUNCE_PULSE);

// Debounce M_INPUT Invert Signal
assign DEBOUNCED_INVERT_S_INPUT = ( ~READ_S_INPUT & DELAYED_READ_S_INPUT & DEBOUNCE_PULSE);

// Validate Released Second Button
assign ACTIVATE_S_BUTTON = ( DEBOUNCED_S_INPUT | DEBOUNCED_INVERT_S_INPUT );

// Make Keep Pushed Second Input Button Signal
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		KEEP_PUSHED_S_INPUT <= 1'b0;
	else if( ACTIVATE_S_BUTTON )
		KEEP_PUSHED_S_INPUT<= DEBOUNCED_S_INPUT;
end

// Read Start Signal by DEBOUNCE_PULSE
always @( posedge CLK or negedge RES_X) begin
	if( !RES_X ) 	
		READ_START <= 1'b0;
	else if ( DEBOUNCE_PULSE )
		READ_START <= START; // X
end

// Delay One DEBOUNCE_PULSE Cycle READ_START
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		DELAYED_READ_START <= 1'b0;
	else if ( DEBOUNCE_PULSE )
		DELAYED_READ_START <= READ_START;
end

// Debounce START
assign DEBOUNCED_START = ( READ_START & ~DELAYED_READ_START & DEBOUNCE_PULSE);

// Read UP_DOWN Signal by DEBOUNCE_PULSE
always @( posedge CLK or negedge RES_X) begin
	if( !RES_X ) 	
		READ_UP_DOWN <= 1'b0;
	else if ( DEBOUNCE_PULSE )
		READ_UP_DOWN <= ~UP_DOWN;
end

// Delay One DEBOUNCE_PULSE Cycle READ_UP_DOWN
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		DELAYED_READ_UP_DOWN <= 1'b0;
	else if ( DEBOUNCE_PULSE )
		DELAYED_READ_UP_DOWN <= READ_UP_DOWN;
end

// Debounce UP_DOWN Signal
assign DEBOUNCED_UP_DOWN = ( READ_UP_DOWN & ~DELAYED_READ_UP_DOWN & DEBOUNCE_PULSE);

// give Priority Start Signal
assign RACE_STOP = (STOP & ~START);

// Read Stop Signal by DEBOUNCE_PULSE
always @( posedge CLK or negedge RES_X) begin
	if( !RES_X ) 	
		READ_STOP <= 1'b0;
	else if ( DEBOUNCE_PULSE )
		READ_STOP <= ~RACE_STOP;
end

// Delay One DEBOUNCE_PULSE Cycle READ_STOP
always @( posedge CLK or negedge RES_X ) begin
	if( !RES_X )
		DELAYED_READ_STOP <= 1'b0;
	else if ( DEBOUNCE_PULSE )
		DELAYED_READ_STOP <= READ_STOP;
end

// Debounce STOP
//assign DEBOUNCED_STOP = ( READ_STOP & ~DELAYED_READ_STOP & DEBOUNCE_PULSE);
assign DEBOUNCED_STOP = ( READ_STOP & ~DELAYED_READ_STOP & DEBOUNCE_PULSE & ~DEBOUNCED_START);

endmodule
