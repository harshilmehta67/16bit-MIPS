`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:26:04 08/29/2019 
// Design Name: 
// Module Name:    program_memory 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//DONE BY : VIDISH JOSHI - AU8141019,
//          RIDHAM SHAH - AU1841007,
//          MANAV PATEL - AU1841037,
//          HARSHIL MEHTA - AU8141010

//////////////////////////////////////////////////////////////////////////////////
module program_memory(
    output [31:0] ins,
    output [15:0] current_address,
    input [15:0] jmp_loc,
    input pc_mux_sel,
    input stall,
    input stall_pm,
    input reset,
    input clk
    );
	 
	
	 wire [31:0] PM_out;
	 wire [31:0] ins_pm; 
	 wire [31:0] CAJ;
    wire	[31:0] CAR;
    
	 
	  PMe your_instance_name (
     .clka(clk), // input clk
     .addra(current_address), // input [15 : 0] addra
      .douta(PM_out) // output [31 : 0] douta
    );
	 
	 
    reg [15:0] hold_address;
    reg [15:0] next_address;
    reg [31:0] ins_prv;
    	 

    assign CAJ = (stall==1'b0) ? next_address : hold_address;
	 assign CAR = (pc_mux_sel==1'b0) ? CAJ : jmp_loc;
	 assign current_address = (reset==1'b0) ? 16'b0000000000000000 : CAR;
	 assign ins_pm = (stall_pm==1'b1)? ins_prv : PM_out ; 
	 assign ins = (reset==1'b0) ? 32'b00000000000000000000000000000000 : ins_pm;

	// assign hold_address = (reset==1'b1) ? 16'b0000000000000000 : hold_address;
	// assign next_address = (reset==1'b1) ? 16'b0000000000000000 : next_address;
	// assign ins = (reset==1'b1) ? 32'b00000000000000000000000000000000 : ins;
	  
	 
		always @(posedge clk)
		begin
			hold_address = current_address;
			next_address = current_address+1'b1;
			ins_prv = ins;
		end
		/*always@(posedge clk && reset)
		begin
			hold_address = 16'b0000000000000000;
			assign ins_prv = 32'b00000000000000000000000000000000 ;
		end*/

endmodule
