`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:12:59 10/03/2019 
// Design Name: 
// Module Name:    Dependency_Check_Block 
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
module Dependency_Check_Block(
    input [31:0] ins,
    input clk,
    input reset,
    output reg [15:0] imm,
    output reg [5:0] op_dec,
    output [4:0] RW_dm,
    output [1:0] mux_sel_A,
    output [1:0] mux_sel_B,
    output imm_sel,
    output  mem_en_ex,
    output mem_rw_ex,
    output mem_mux_sel_dm
    );
	 
	 //ins, JMP, Cond_J, LD_fb mate no code
	 wire LD_fb_dff;
	 wire [14:0]ins_w2;
	 wire [5:0]op;
	 wire JMP, Cond_J, LD_fb, Imm, LD, ST;
	 
	 
	 assign op = ins[31:26];
	 assign ins_w2 = ins[25:11]; 
	 
	 Dff d1(LD_fb, clk, LD_fb_dff, reset);
	 
	 
	 assign JMP = (~op[0] & ~op[1] & ~op[2] & op[3] & op[4] & ~op[5]);
	 assign Cond_J = (op[2] & op[3] & op[4] & ~op[5]);	
	 assign LD_fb = (~LD_fb_dff & ~op[0] & ~op[1] & op[2] & ~op[3] & op[4] & ~op[5]); 
	 assign Imm = (op[3] & ~op[4] & ~op[5]);
	 assign LD = (~op[0] & ~op[1] & op[2] & ~op[3] & op[4] & ~op[5]);
	 assign ST = (op[0] & ~op[1] & op[2] & ~op[3] & op[4] & ~op[5]);
	 
	 
	 wire JnC;
	 assign JnC = ~(JMP | Cond_J | LD_fb_dff);
	 
	 wire [14:0]JnC_ext;
	 assign JnC_ext = (JnC==1'b1) ? 15'b111111111111111 : 15'b0;
	 
	 
	 wire [14:0]ins_AND;
	 assign ins_AND = (ins_w2 & JnC_ext);
	 
	 wire [4:0]ins_AND_1;
	 wire [4:0]ins_AND_2;
	 wire [4:0]ins_AND_3;
	 reg [4:0]ins1;
	 reg [4:0]ins2;
	 reg [4:0]ins3;
	 reg [4:0]ins21;
	 reg [4:0]ins22;
	 reg [4:0]ins23;
	 
	 assign ins_AND_1 = ins_AND[4:0];	
	 assign ins_AND_2 = ins_AND[9:5];
	 assign ins_AND_3 = ins_AND[14:10];
	 
	 assign RW_dm = ins22;
	 
	 always@(posedge clk)
begin
	if(reset==1'b1)
	begin
		imm<= ins[15:0];
		op_dec <= ins[31:26];
	
		ins1 <= ins_AND_2;
		ins2 <= ins_AND_3;
		ins3 <= ins_AND_1;
		ins21 <= ins2;
		ins22 <= ins21;
		ins23 <= ins22;
		
		
	end
	else
	begin
	
		imm = 15'b0;
		op_dec = 6'b0;
		//RW_dm = 5'b0;
		
		ins1 = 5'b0;
		ins2 = 5'b0;
		ins3 = 5'b0;
		ins21 = 5'b0;
		ins22 = 5'b0;
		ins23 = 5'b0;
	
	end
end

	 wire comp1, comp2, comp3, comp4, comp5, comp6;
	 assign comp1 = (ins21==ins1) ? 1'b1 : 1'b0;
	 assign comp2 = (ins22==ins1) ? 1'b1 : 1'b0;
	 assign comp3 = (ins23==ins1) ? 1'b1 : 1'b0;
	 assign comp4 = (ins21==ins3) ? 1'b1 : 1'b0;
	 assign comp5 = (ins22==ins3) ? 1'b1 : 1'b0;
	 assign comp6 = (ins23==ins3) ? 1'b1 : 1'b0;
	 
	 wire C_and1, C_and2, C_and3, C_and4;
	 assign C_and1 = (~comp1 & comp2);
	 assign C_and2 = (~comp1 & ~comp2 & comp3);
	 assign C_and3 = (~comp4 & comp5);
	 assign C_and4 = (~comp4 & ~comp5 & comp6);
	 
	 Pri_Encoder P1(comp1, C_and1, C_and2, mux_sel_A[0], mux_sel_A[1]);
	 Pri_Encoder P2(comp4, C_and3, C_and4, mux_sel_B[0], mux_sel_B[1]);
	  
	 
	 //LD mate karu chu, ST mate pan karu chu
	 wire LD_bh, dff2_out, dff3_out, dff4_out;
	 
	 Dff d2(op[0], clk, dff2_out, reset);
	 Dff d3(LD_bh, clk, dff3_out, reset);
	 Dff d4(ST, clk, dff4_out, reset);
	 
	 assign LD_bh = (LD & ~dff3_out);
	 
	 wire or1, LS_and1, dff6_out;
	 assign or1 = (dff3_out | dff4_out);
	 assign LS_and1 = (~dff2_out & or1);
	 
	 Dff d5(dff2_out, clk, mem_rw_ex, reset);
	 Dff d6(LS_and1, clk, dff6_out, reset);
	 Dff d7(or1, clk,  mem_en_ex, reset);
	 
	 Dff d8(dff6_out, clk, mem_mux_sel_dm, reset);
	 
	 //Imm mate no code
	 Dff d9(Imm, clk, imm_sel, reset);


endmodule

module Dff(
	input D ,
	input clk,
	output reg Q ,
	input reset
	);

	always@(posedge clk)
	begin
	if(reset)
	begin
	Q <= D ;
	end
	else
	begin
	Q <= 0;
	end
	end
	
endmodule

module Pri_Encoder(input A,
input B,
input C, output O,
output V);

assign O = (C | (~B & A) );
assign V = (B | C);

endmodule
