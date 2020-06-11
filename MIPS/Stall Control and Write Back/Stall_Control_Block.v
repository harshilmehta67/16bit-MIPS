`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:20:49 09/12/2019 
// Design Name: 
// Module Name:    Stall_Control_Block 
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
//////////////////////////////////////////////////////////////////////////////////
module Stall_Control_Block(
    input [5:0] op,
    input clk,
    input reset,
    output stall,
    output stall_pm
    );	
	 
	 //wire to get combinatorial output
	 wire hlt , jump , ld ;
	 
	 //wire to get output of D flip flops
	 wire o1,o2,o3,o4 ;
	 
	 //Temporary register to store output of flip flops
	 reg tmp1 , tmp2 ,tmp3 , tmp4 ;
	 
	 //combinatorial logic
	 assign hlt = (op[0]&~op[1]&~op[2]&~op[3]&op[4]&~op[5]) ;
	 assign ld = (~op[0]&~op[1]&op[2]&~op[3]&op[4]&~op[5]&~o1);
	 assign jump = (op[2]&op[3]&op[4]&~op[5]&~o4);
	 assign stall = (hlt | jump | ld);
	 assign stall_pm = o2;
	 
	 //assigning value of temporary registers to output wires of flip flops
	 assign o1 = tmp1 ;
	 assign o2 = tmp2 ;
	 assign o3 = tmp3 ;
	 assign o4 = tmp4 ;
	
	//running clock cycles to update values of temporary registers
	 always@(posedge clk)
	 begin 
	 
	 //reset logic
	 if(reset == 1'b1)
	 begin
		 tmp1 <= ld ;
		 tmp2 <= stall ;
		 tmp3 <= jump ;
		 tmp4 <= o3 ;
	 end
	 else
	 begin
		tmp1 <= 1'b0 ;
		tmp2 <= 1'b0 ;
		tmp3 <= 1'b0;
		tmp4 <= 1'b0 ;
	 end
	 end

	 

endmodule
