`timescale 1ns / 1ns

module kitchenTimer_tp();

reg			M_INPUT;
reg			S_INPUT;
reg			START;
reg			STOP;
reg			UP_DOWN;
reg			CLK;
reg			RES;

wire		ARM;
wire		DIG_1;
wire		DIG_2;
wire		DIG_3;
wire		DIG_4;
wire		[6:0]	LIGHT_SEG;

kitchenTimer kitchenTimer(
				.M_INPUT( M_INPUT ),
				.S_INPUT( S_INPUT ),
				.START( START ),
				.STOP( STOP ),
				.UP_DOWN( UP_DOWN ),
				.CLK ( CLK ),
				.RES( RES),	
				.ARM(ARM),
				.DIG_1 (DIG_1),
				.DIG_2 (DIG_2),
				.DIG_3 (DIG_3),
				.DIG_4 (DIG_4),
				.LIGHT_SEG ( LIGHT_SEG )
			);


parameter	CYCLE = 4096;				
parameter   ONE_SEC = 24_4140 * CYCLE;
parameter   HALF_SEC = 12_2070 * CYCLE;
parameter	DEBOUNCED = 2_5000 * CYCLE; 
integer		i;
integer		stop_time;

always #( CYCLE / 2 )	CLK = ~CLK;

initial begin
	CLK = 0;
	START = 0;
	RES = 1;
	M_INPUT = 0;
	S_INPUT = 0;
	UP_DOWN =1;
	STOP = 1;
	stop_time = 0;

 	#CYCLE; RES = 0; 
	$display( "===================================");
	$display( "Start Sim");
	$display( "===================================");
	#HALF_SEC;

	// Count Up Mode
	for ( i = 0 ; i < 2; i = i + 1) begin
		M_INPUT = 1; #ONE_SEC;		
	end
	M_INPUT = 0; #ONE_SEC;
	UP_DOWN= 0;
	

	// Count Down Mode
	for ( i = 0 ;i < 2 ; i = i+1 ) begin
		M_INPUT = 1; # ONE_SEC;
	end

	M_INPUT = 1; #HALF_SEC;

	M_INPUT = 0; UP_DOWN =1; #(HALF_SEC);
	UP_DOWN = 0;

	#HALF_SEC;
	// Count Up Mode
	for ( i = 0 ; i< 5 ; i=i+1 ) begin
		S_INPUT = 1; #ONE_SEC;		
	end

	// Count Down Mode
	M_INPUT = 0; UP_DOWN =1; #(HALF_SEC);
	UP_DOWN = 0;


	for ( i = 0 ; i< 3 ; i=i+1 ) begin
		S_INPUT = 1; #ONE_SEC;		
	end
			

	#(30 *  CYCLE); START = 1; STOP = 0;

	$display( "===================================");
	$display( "Start CountDown");
	$display( "===================================");
	while ( ~kitchenTimer.downCounter.ARM_SIG ) begin
		#ONE_SEC;
	end

	$display( "===================================");
	$display( "End Sim");
	$display( "===================================");

	$finish;
end

initial begin
	$dumpfile("kitchenTimer.vcd");
	$dumpvars(0,kitchenTimer);

		$monitor("Setted Time :  %d%d : %d%d", kitchenTimer.downCounter.M_OUTPUT_HI, kitchenTimer.downCounter.M_OUTPUT_LO, kitchenTimer.downCounter.S_OUTPUT_HI,kitchenTimer.downCounter.S_OUTPUT_LO );
end
endmodule	
	
