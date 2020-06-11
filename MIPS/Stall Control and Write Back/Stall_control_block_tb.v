`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:24:50 09/12/2019
// Design Name:   Stall_Control_Block
// Module Name:   F:/Studies/Sem-3/CO Lab/Project1/Stall_control_block_tb.v
// Project Name:  Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Stall_Control_Block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Stall_control_block_tb;

	// Inputs
	reg [5:0] op;
	reg clk;
	reg reset;

	// Outputs
	wire stall;
	wire stall_pm;

	// Instantiate the Unit Under Test (UUT)
	Stall_Control_Block uut (
		.op(op), 
		.clk(clk), 
		.reset(reset), 
		.stall(stall), 
		.stall_pm(stall_pm)
	);

	initial begin
		// Initialize Inputs

	op = 6'b000000 ;
	reset = 1'b1 ;
	clk = 0 ;
		
	

	
	#2 ;
	reset = 1'b0 ;
	#6;
	reset = 1'b1 ;
	#8;
	op = 6'b010100;
	#20;
	op = 6'b0 ;
	#10;
	op = 6'b011110 ;
	#30 ;
	op = 6'b0 ;
	#10; 
	op = 6'b010001 ;

end
always #5 clk = ~clk ;
        
		// Add stimulus here


      
endmodule

