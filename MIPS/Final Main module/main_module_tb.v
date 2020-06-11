`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:27:15 10/10/2019
// Design Name:   main_module
// Module Name:   F:/Studies/Sem-3/CO Lab/Project1/main_module_tb.v
// Project Name:  Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module main_module_tb;

	// Inputs
	reg [15:0] data_in;
	reg clk;
	reg interrupt;
	reg reset;

	// Outputs
	wire [15:0] data_out;
	wire [31:0] ins;
	wire [15:0] A;
	wire [15:0] B;
	wire [15:0] current_address;
	wire [15:0] ans_ex; 
	wire [15:0] ans_dm;
	wire [15:0] ans_wb;
	wire [1:0] mux_sel_A; 
	wire [1:0] mux_sel_B;
	wire imm_sel;
	wire pc_mux_sel_out;


	// Instantiate the Unit Under Test (UUT) 
	main_module uut (
		.data_in(data_in), 
		.clk(clk), 
		.interrupt(interrupt), 
		.reset(reset), 
		.data_out(data_out), 
		.ins(ins), 
		.A(A), 
		.B(B), 
		.current_address(current_address), 
		.ans_ex(ans_ex), 
		.ans_dm(ans_dm), 
		.ans_wb(ans_wb), 
		.mux_sel_A(mux_sel_A), 
		.mux_sel_B(mux_sel_B), 
		.imm_sel(imm_sel),
		.pc_mux_sel_out(pc_mux_sel_out)
	);

	initial begin
		// Initialize Inputs
		data_in = 0;
		clk = 0;
		interrupt = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#3; reset = 0;
		#5; reset = 1;
        
		// Add stimulus here

	end
	
	always
	#5 clk = ~clk;
	
      
endmodule

