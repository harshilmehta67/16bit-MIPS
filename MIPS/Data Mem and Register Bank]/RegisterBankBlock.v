`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:15:56 09/05/2019 
// Design Name: 
// Module Name:    RegisterBankBlock 
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
module RegisterBankBlock(
    input [15:0] ans_ex,
    input [15:0] ans_dm,
    input [15:0] ans_wb,
    input [15:0] imm,
    input [4:0] RA,
    input [4:0] RB,
    input [4:0] RW_dm,
    input [1:0] mux_sel_A,
    input [1:0] mux_sel_B,
    input [0:0] imm_sel,
    input [0:0] clk,
    output [15:0] A,
    output [15:0] B
    );

  reg [15:0] RegisterBank [31:0];
  reg [15:0] AR;
  reg [15:0] BR;
  wire [15:0] BI;
  
  always @(posedge clk)
  begin
  
  AR = RegisterBank[RA];
  BR = RegisterBank[RB];
  RegisterBank[RW_dm] = ans_dm;
  
  end
  
  assign A = (mux_sel_A == 2'b00) ? AR :
             (mux_sel_A == 2'b01) ? ans_ex:
				 (mux_sel_A == 2'b10) ? ans_dm: ans_wb;
				 
  assign BI = (mux_sel_B == 2'b00) ? BR :
             (mux_sel_B == 2'b01) ? ans_ex:
				 (mux_sel_B == 2'b10) ? ans_dm: ans_wb;
				 
  assign B = (imm_sel == 1'b0) ? BI : imm;
 
 

endmodule
