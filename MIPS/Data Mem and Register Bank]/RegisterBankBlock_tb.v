`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:35:26 09/05/2019
// Design Name:   RegisterBankBlock
// Module Name:   F:/Studies/Sem-3/CO Lab/Project1/RegisterBankBlock_tb.v
// Project Name:  Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RegisterBankBlock
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RegisterBankBlock_tb;

	// Inputs
	reg [15:0] ans_ex;
	reg [15:0] ans_dm;
	reg [15:0] ans_wb;
	reg [15:0] imm;
	reg [4:0] RA;
	reg [4:0] RB;
	reg [4:0] RW_dm;
	reg [1:0] mux_sel_A;
	reg [1:0] mux_sel_B;
	reg [0:0] imm_sel;
	reg [0:0] clk;

	// Outputs
	wire [15:0] A;
	wire [15:0] B;

	// Instantiate the Unit Under Test (UUT)
	RegisterBankBlock uut (
		.ans_ex(ans_ex), 
		.ans_dm(ans_dm), 
		.ans_wb(ans_wb), 
		.imm(imm), 
		.RA(RA), 
		.RB(RB), 
		.RW_dm(RW_dm), 
		.mux_sel_A(mux_sel_A), 
		.mux_sel_B(mux_sel_B), 
		.imm_sel(imm_sel), 
		.clk(clk), 
		.A(A), 
		.B(B)
	);
	
	always begin
	clk = 0;
	//begin 
	forever #5 clk = ~clk; 
	end

	initial begin
		// Initialize Inputs
		ans_ex = 'hC000;
		ans_dm = 'hD000;
		ans_wb = 'hE000;
		imm = 'hFFFF;
		RA = 5'b00101;
		RB = 5'b00110;
		RW_dm = 5'b00111;
		mux_sel_A = 0;
		mux_sel_B = 0;
		imm_sel = 1;
		

		// Wait 100 ns for global reset to finish
		#10
		RB = 5'b00111;
		imm_sel = 0;
		mux_sel_A = 2'b10;
		mux_sel_B = 2'b01;
		
		#10
		mux_sel_A = 2'b11;
		mux_sel_B = 2'b00;
        
		// Add stimulus here

	end
      
endmodule

