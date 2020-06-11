`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:37:02 09/19/2019
// Design Name:   Jump_Control_Block
// Module Name:   F:/Studies/Sem-3/CO Lab/Project1/Jump_Control_Block_tb.v
// Project Name:  Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Jump_Control_Block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Jump_Control_Block_tb;

	// Inputs
	reg [15:0] jmp_address_pm;
	reg [15:0] current_address;
	reg [5:0] op;
	reg [1:0] flag_ex;
	reg interrupt;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] jmp_loc;
	wire pc_mux_sel;

	// Instantiate the Unit Under Test (UUT)
	Jump_Control_Block uut (
		.jmp_address_pm(jmp_address_pm), 
		.current_address(current_address), 
		.op(op), 
		.flag_ex(flag_ex), 
		.interrupt(interrupt), 
		
		.clk(clk), 
		.reset(reset), 
		.jmp_loc(jmp_loc), 
		.pc_mux_sel(pc_mux_sel)
	);
	always begin
		clk = 0;
		//begin 
		forever #5 clk = ~clk; 
	end

	initial begin
		// Initialize Inputs
		
		jmp_address_pm = 0;
		current_address = 1;
		op = 0;
		flag_ex = 2'b11;
		interrupt = 0;
		clk = 0;
		reset = 1;
		

		// Wait 100 ns for global reset to finish
		#2 reset = 1'b0;
		#6 reset = 1'b1;
		#8 interrupt = 1'b1;
		#10 jmp_address_pm = 16'h0008; interrupt = 1'b0;
		#20 op = 6'h18;
		#10 op = 6'h10; flag_ex = 2'b00;
		#10 op = 6'h1e;
		
		
		
		
        
		// Add stimulus here

	end
      
endmodule

