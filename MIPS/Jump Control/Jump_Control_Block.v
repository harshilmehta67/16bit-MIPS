`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:48:05 09/19/2019 
// Design Name: 
// Module Name:    Jump_Control_Block 
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
module Jump_Control_Block(
    input [15:0] jmp_address_pm,
    input [15:0] current_address,
    input [5:0] op,
    input [1:0] flag_ex,
    input interrupt,
    input clk,
    input reset,
    output [15:0] jmp_loc,
    output pc_mux_sel
    );
	 
	 wire JV, JNV, JZ, JNZ, JMP, RET;
	 
	 assign JV = (~op[0] & ~op[1] & op[2] & op[3] & op[4] & ~op[5]);
	 assign JNV = (op[0] & ~op[1] & op[2] & op[3] & op[4] & ~op[5]);
	 assign JZ = (~op[0] & op[1] & op[2] & op[3] & op[4] & ~op[5]);
	 assign JNZ = (op[0] & op[1] & op[2] & op[3] & op[4] & ~op[5]);
	 assign JMP = (~op[0] & ~op[1] & ~op[2] & op[3] & op[4] & ~op[5]);
	 assign RET = (~op[0] & ~op[1] & ~op[2] & ~op[3] & op[4] & ~op[5]);
	 
	 wire ff_out2, ff_out1;
	 wire [1:0]mux_flag_ex1 ;
	 wire [1:0]mux_flag_ex2;
	 wire [1:0]flag_ex_reg;
	 reg [1:0]fex_reg_temp;
	 //wire [1:0]fex_reg_tempin;
	 wire and1, and2, and3, and4;
	 //wire [15:0]cout;
	 wire [15:0]jmp_mux;
	 wire [15:0]ca_mux1;
    wire [15:0]ca_mux2; 
	 reg [15:0]ca_reg_temp;
	 //wire [15:0]ca_reg_tempin;
	 reg [15:0]ca_reg;
	 
	 
	 D_flip_flop D1(interrupt, clk, ff_out1, reset);
	 D_flip_flop D2(ff_out1, clk, ff_out2, reset);
	 
	 assign jmp_mux = (ff_out1==1'b1) ? 16'hF000 : jmp_address_pm;
	 assign ca_mux1 = (interrupt==1'b1) ? (current_address + 1'b1 ): ca_reg_temp;
	 //assign ca_reg = ca_mux1;)
	 assign ca_mux2 = (RET==1) ? ca_reg_temp : jmp_mux;
	 assign jmp_loc = ca_mux2;
	
	 
	 assign mux_flag_ex1 = (ff_out2 == 1'b1) ? flag_ex : fex_reg_temp ;
	 //assign flag_ex_reg = mux_flag_ex1;
	 assign mux_flag_ex2 = (RET == 1'b1) ? fex_reg_temp : flag_ex ;
	 
	 
	 assign and1 = (JV & mux_flag_ex2[0]);
	 assign and2 = (JNV & ~mux_flag_ex2[0]);
	 assign and3 = (JZ & mux_flag_ex2[1]);
	 assign and4 = (JNZ & ~mux_flag_ex2[1]);
	 
	 assign pc_mux_sel = ( and1 | and2 | and3 | and4 | JMP | RET | ff_out1 );
	 
	 
	 
	 always@(posedge clk)
	 begin
	 
	  if(reset)
		begin
		fex_reg_temp <= mux_flag_ex1;
		ca_reg_temp <= ca_mux1;
	   end
	  else
	   begin
		fex_reg_temp <= 0;
		ca_reg_temp <= 0;
		end
		
	 end
	 
	 
	 
endmodule

module D_flip_flop(
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
