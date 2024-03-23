`timescale 1ns/1ns

module ADDERTB();

reg [1:0] NUM1;
reg [1:0] NUM2;
reg CLK;
reg RES_X;

wire [1:0] SUM_OUT;


parameter CYCLE = 10;

ADDER adder
	( .NUM1( NUM1 ),
	  .NUM2( NUM2 ), 
	  .CLK( CLK ), 
	  .RES_X( RES_X ),
	  .SUM_OUT( SUM_OUT )
  ); 

always #( CYCLE / 2 ) CLK = ~CLK;

initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0, ADDERTB);

		CLK = 0;
		RES_X = 0;
		
		#10
		NUM1 = 2'b0; NUM2 = 2'b0;

		#100
		NUM1 = 2'b01; NUM2 = 2'b01;
		
		#100
		RES_X = 1;
		NUM1 = 2'b01; NUM2 = 2'b01;
		
		#100
		NUM1 = 2'b10; NUM2 = 2'b01;

		#100
		NUM1 = 2'b11; NUM2 = 2'b01;
		

        #100 $finish;
end

endmodule
