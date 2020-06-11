`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:17:34 09/12/2019 
// Design Name: 
// Module Name:    write_back 
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
module write_back(
    input [15:0] ans_dm,
    input clk,
    input reset,
    output reg [15:0] ans_wb
    );
	
	//Using posedge of clock to assign value ans_dm to ans_wb 
	//It will create a delay of one clock cycle to assign the values
	
	always@(posedge clk)
	begin
		if(reset==1'b1)
		begin
			ans_wb=ans_dm;
		end
		else
		begin
			ans_wb=16'b0;
		end
	end
endmodule
