`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:23:30 09/12/2019
// Design Name:   write_back
// Module Name:   D:/CO_LAB/LAB_1/ASSIGNMENT/write_back_tb.v
// Project Name:  ASSIGNMENT
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: write_back
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module write_back_tb;

	// Inputs
	reg [15:0] ans_dm;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] ans_wb;

	// Instantiate the Unit Under Test (UUT)
	write_back uut (
		.ans_dm(ans_dm), 
		.clk(clk), 
		.reset(reset), 
		.ans_wb(ans_wb)
	);
	initial begin
		// Initialize Inputs
		ans_dm = 0;
		clk = 0;
		reset = 1;
	end
	always begin
		#5 clk = ~clk;
	end
		// Wait 100 ns for global reset to finish
        
		// Add stimulus here
		initial begin
		#2 reset =0;
		#8 reset = 1;
			ans_dm=2;
		#5 ans_dm=3;
		end
endmodule

