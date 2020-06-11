`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:37:26 10/03/2019
// Design Name:   Dependency_Check_Block
// Module Name:   F:/Studies/Sem-3/CO Lab/Project1/Dependency_Check_Block_tb.v
// Project Name:  Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Dependency_Check_Block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Dependency_Check_Block_tb;

	// Inputs
	reg [31:0] ins;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] imm;
	wire [5:0] op_dec;
	wire [4:0] RW_dm;
	wire [1:0] mux_sel_A;
	wire [1:0] mux_sel_B;
	wire imm_sel;
	wire mem_en_ex;
	wire mem_rw_ex;
	wire mem_mux_sel_dm;

	// Instantiate the Unit Under Test (UUT)
	Dependency_Check_Block uut (
		.ins(ins), 
		.clk(clk), 
		.reset(reset), 
		.imm(imm), 
		.op_dec(op_dec), 
		.RW_dm(RW_dm), 
		.mux_sel_A(mux_sel_A), 
		.mux_sel_B(mux_sel_B), 
		.imm_sel(imm_sel), 
		.mem_en_ex(mem_en_ex), 
		.mem_rw_ex(mem_rw_ex), 
		.mem_mux_sel_dm(mem_mux_sel_dm)
	);

	always begin
		clk = 0;
		//begin 
		forever #5 clk = ~clk; 
		end
		
	initial begin
		// Initialize Inputs
		ins = 32'b0;
		clk = 0;
		reset = 1'b0;
		
		
		
		#10 reset=1'b1;
		//#5 reset=1'b1;
		//#5 
		ins=32'b00000000001000100001100000000000;
		#10 
		ins=32'b01010000100000010000000000000000;
		#10
		#10 
		ins=32'b00010000101000010010000000000000;
		#10 
		ins=32'b00110100110000010000000000000101;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

