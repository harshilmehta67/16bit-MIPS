`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:30:31 10/10/2019 
// Design Name: 
// Module Name:    main_module 
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
module main_module(
    input [15:0] data_in,
    input clk,
    input interrupt,
    input reset,
    output [15:0] data_out,
    output [31:0] ins,
    output [15:0] A,
    output [15:0] B,
    output [15:0] current_address,
    output [15:0] ans_ex,
    output [15:0] ans_dm,
    output [15:0] ans_wb,
    output [1:0] mux_sel_A,
    output [1:0] mux_sel_B,
    output imm_sel,
	 output pc_mux_sel_out
    );
	 
	 wire [15:0]DM_data;
	 wire [1:0]flag_ex;
	 wire [5:0]op_dec;
	 wire [15:0] jmp_loc;
	 wire pc_mux_sel;
	 wire stall;
	 wire stall_pm;
	 wire [15:0]imm;
	 wire [4:0] RA;
	 wire [4:0] RB;
	 wire [4:0] RW_dm;
	 wire mem_rw_ex;
	 wire mem_en_ex;
	 wire mem_mux_sel_dm;
	 assign RB = ins[15:11] ;
	 assign RA = ins[20:16] ;
	 wire [15:0]jmp_address_pm;
	 
	 assign jmp_address_pm = ins[15:0];
	 assign pc_mux_sel_out = pc_mux_sel;
	 
	 program_memory PM1(ins, current_address, jmp_loc, pc_mux_sel, stall, stall_pm, reset, clk);
	 Stall_Control_Block SC1( ins[31:26], clk, reset, stall, stall_pm );
	 Jump_Control_Block JCB1( jmp_address_pm, current_address, ins[31:26], flag_ex, interrupt, clk, reset, jmp_loc, pc_mux_sel ) ;
	 	 
	 Dependency_Check_Block DCB1( ins , clk , reset, imm , op_dec ,RW_dm , mux_sel_A , mux_sel_B , imm_sel , mem_en_ex , mem_rw_ex , mem_mux_sel_dm) ;
	 
	 RegisterBankBlock RB1( ans_ex, ans_dm, ans_wb, imm, RA, RB, RW_dm, mux_sel_A, mux_sel_B, imm_sel, clk, A, B );
	 execution_block EB1( A,B,data_in,op_dec,clk,reset,ans_ex,DM_data,data_out,flag_ex);
	 
	 DataMemoryBlock DMB1( ans_ex, DM_data, mem_rw_ex, mem_en_ex, mem_mux_sel_dm, reset, clk, ans_dm ) ;
	 write_back WB1( ans_dm, clk, reset, ans_wb ) ;
	 
	 


endmodule
