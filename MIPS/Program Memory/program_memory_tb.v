`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:19:32 08/29/2019
// Design Name:   program_memory
// Module Name:   F:/Studies/Sem-3/Project1/program_memory_tb.v
// Project Name:  Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: program_memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//DONE BY : VIDISH JOSHI - AU8141019,
//          RIDHAM SHAH - AU1841007,
//          MANAV PATEL - AU1841037,
//          HARSHIL MEHTA - AU8141010
////////////////////////////////////////////////////////////////////////////////

module program_memory_tb;

	// Inputs
	reg [15:0] jmp_loc;
	reg pc_mux_sel;
	reg stall;
	reg stall_pm;
	reg reset;
	reg clk;

	// Outputs
	wire [31:0] ins;
	wire [15:0] current_address;

	// Instantiate the Unit Under Test (UUT)
	program_memory uut (
		.ins(ins), 
		.current_address(current_address), 
		.jmp_loc(jmp_loc), 
		.pc_mux_sel(pc_mux_sel), 
		.stall(stall), 
		.stall_pm(stall_pm), 
		.reset(reset), 
		.clk(clk)
	);

     initial begin
	  
	  jmp_loc = 'h0008;
		pc_mux_sel = 1;
		stall = 0;
		stall_pm = 0;
		reset = 1;
		clk = 0;
		
		end
	
		// Initialize Inputs
		always begin
		
			clk=0;
			forever #5 clk = ~clk;
	
		end
		
		initial begin
		
		/*jmp_loc = 'h0008;
		pc_mux_sel = 1;
		stall = 0;
		stall_pm = 0;
		reset = 1;*/
		
	
		#2 reset=0;
		#6 reset=1;
		#2 pc_mux_sel=0;
		#30 stall=1;
		#10 stall=0;
			stall_pm=1;
		#10 pc_mux_sel=1;
			stall_pm=0;

		

	end
      
endmodule

