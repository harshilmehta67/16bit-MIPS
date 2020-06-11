`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:24:01 09/05/2019
// Design Name:   DataMemoryBlock
// Module Name:   F:/Studies/Sem-3/CO Lab/Project1/DataMemoryBlock_tb.v
// Project Name:  Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DataMemoryBlock
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DataMemoryBlock_tb;

	// Inputs
	reg [15:0] ans_ex;
	reg [15:0] DM_data;
	reg [0:0] mem_rw_ex;
	reg [0:0] mem_en_ex;
	reg [0:0] mem_mux_sel_dm;
	reg [0:0] reset;
	reg [0:0] clk;

	// Outputs
	wire [15:0] ans_dm;

	// Instantiate the Unit Under Test (UUT)
	DataMemoryBlock uut (
		.ans_ex(ans_ex), 
		.DM_data(DM_data), 
		.mem_rw_ex(mem_rw_ex), 
		.mem_en_ex(mem_en_ex), 
		.mem_mux_sel_dm(mem_mux_sel_dm), 
		.reset(reset), 
		.clk(clk), 
		.ans_dm(ans_dm)
	);


   always begin
	
	clk = 0;	
	
	forever #5 clk = ~clk;
	
	end
	
	initial begin
		// Initialize Inputs
		ans_ex = 'h0003;
		DM_data = 'hFFFF;
		mem_rw_ex = 0;
		mem_en_ex = 0;
		mem_mux_sel_dm = 0;
		reset = 1;
		//clk = 0;

		// Wait 100 ns for global reset to finish
		#2;
		reset = 0 ;
		
		#6;
		reset = 1;
		
		#2;
		mem_en_ex=1'b1;
		mem_mux_sel_dm=1'b1;
		
		#10;
		mem_rw_ex=1'b1;
		
		#10;
		mem_rw_ex=0;
        
		// Add stimulus here

	end
      
endmodule

