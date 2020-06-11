`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
//
// Design Name:   execution_block
// Module Name:   D:/CO_LAB/LAB_1/ASS_1/execution_block_tb.v
// Project Name:  ASS_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: execution_block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module moduletest;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg [15:0] data_in;
	reg [5:0] op_dec;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] ans_ex;
	wire [15:0] DM_data;
	wire [15:0] data_out;
	wire [1:0] flag_ex;

	// Instantiate the Unit Under Test (UUT)
	execution_block uut (
		.ans_ex(ans_ex), 
		.DM_data(DM_data), 
		.data_out(data_out), 
		.flag_ex(flag_ex), 
		.A(A), 
		.B(B), 
		.data_in(data_in), 
		.op_dec(op_dec), 
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		data_in = 0;
		op_dec = 0;
		clk = 0;
		reset = 0;
	end
		// Wait 100 ns for global reset to finish
    always
	begin
	clk = 0;
	forever #10 clk = ~clk;
	end
	
	initial begin
	reset = 1;
	A = 'h4000;
	B = 'hc000;
	data_in = 'h0008;
	
	end

	initial begin
		// Initialize Inputs

		// Wait 100 ns for global reset to finish
		#10
		op_dec = 6'b000000;
		
		#10
		op_dec = 6'b000001;
		
		#10
		op_dec = 6'b000010;
		
		#10
		op_dec = 6'b000100;
		
		#10
		op_dec = 6'b000101;
		
		#10
		op_dec = 6'b000110;
		#10
		op_dec = 6'b000111;
		#10
		op_dec = 6'b001000;
		#10
		op_dec = 6'b001001;
		#10
		op_dec = 6'b001010;
		#10
		op_dec = 6'b001100;
		#10
		op_dec = 6'b001101;
		#10
		op_dec = 6'b001110;
		#10
		op_dec = 6'b001111;
		#10
		op_dec = 6'b010000;
		#10
		op_dec = 6'b010001;
		#10
		op_dec = 6'b010100;
		#10
		op_dec = 6'b010101;
		#10
		op_dec = 6'b010110;
		#10
		op_dec = 6'b010111;
		#10
		op_dec = 6'b011000;
		#10
		op_dec = 6'b011001;
		#10
		op_dec = 6'b011010;
		#10
		op_dec = 6'b011011;
		#10
		op_dec = 6'b011100;
		#10
		op_dec = 6'b011101;
		#10
		op_dec = 6'b011110;
		#10
		op_dec = 6'b011111;
        
		// Add stimulus here

	end
      
endmodule

