`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Module Name:    execution block (ALU)
// Group Members : PATEL MANAV AU1841037
//                 RIDHAM SHAH AU1841007
//                 VIDISH JOSHI AU1841019
//                 HARSHIL MEHTA AU1841010
//////////////////////////////////////////////////////////////////////////////////

module execution_block(
    output reg [15:0] ans_ex ,
    output reg [15:0] DM_data ,
    output reg [15:0] data_out ,
    output reg [1:0] flag_ex ,

    input [15:0] A ,
    input [15:0] B ,
    input [15:0] data_in ,
    input [5:0] op_dec, 
    input clk,
    input reset
);
parameter ADD = 6'b000000;
parameter SUB = 6'b000001;
parameter MOV = 6'b000010;
parameter AND = 6'b000100;

parameter OR  = 6'b000101;
parameter XOR = 6'b000110;
parameter NOT = 6'b000111;
parameter ADI = 6'b001000;

parameter SBI = 6'b001001;
parameter MVI = 6'b001010;
parameter ANI = 6'b001100;
parameter ORI = 6'b001101;

parameter XRI = 6'b001110;
parameter NTI = 6'b001111;
parameter RET = 6'b010000;
parameter HLT = 6'b010001;

parameter LD  = 6'b010100;
parameter ST  = 6'b010101;
parameter IN  = 6'b010110;
parameter OUT = 6'b010111;

parameter JMP = 6'b011000;
parameter LS  = 6'b011001;
parameter RS  = 6'b011010;
parameter RSA = 6'b011011;

parameter JV  = 6'b011100;
parameter JNV = 6'b011101;
parameter JZ  = 6'b011110;
parameter JNZ = 6'b011111;

wire [15:0] ans_tmp;
wire [15:0] data_out_buffer;
reg [1:0] flag_prv;
wire [1:0] flag_ex_1;




assign ans_tmp =  (op_dec==ADD) ?   A+B:
						(op_dec==SUB) ?   A-B:
						(op_dec==MOV) ?   B:
						(op_dec==AND) ?   A&B: 
 
						(op_dec==OR) ?   A|B:( op_dec==XOR ) ?   A^B:
						(op_dec==NOT) ?   ~B:( op_dec==ADI ) ?   A+data_in: 
   
						(op_dec==SBI) ?   A-data_in:( op_dec==MVI ) ?   data_in:
						(op_dec==ANI) ?   A&data_in:( op_dec==ORI ) ?   A|data_in: 
   
						(op_dec==XRI) ?   A^data_in:( op_dec==NTI ) ?   ~data_in:
						(op_dec==RET) ?   ans_ex:( op_dec==HLT ) ?   ans_ex: 
   
						(op_dec==LD) ?   A:( op_dec==ST  ) ?   A:( op_dec==IN  ) ?   data_in:

   
						(op_dec==JMP) ?   ans_ex:( op_dec==LS  ) ?   A<<B:
						(op_dec==RS) ?   A>>B:( op_dec==RSA ) ?   A>>>B:

						(op_dec==JV) ?   ans_ex:( op_dec==JNV ) ?   ans_ex:
						(op_dec==JZ) ?   ans_ex:( op_dec==JNZ ) ?   ans_ex: 0;


assign data_out_buffer = (op_dec == 6'b010111) ? A: 0;

/////////////////////////////////////////////////////////////////////////////////////////
assign flag_ex_1 =   (op_dec==ADD && A+B>16'b1111111111111111) ? 2'b01:
							(op_dec==ADD && A+B==0) ? 2'b10:(op_dec==SUB && A-B==0) ? 2'b10:(op_dec==SUB && A-B<0) ? 2'b01:(op_dec==MOV && B==0) ? 2'b10:
							
							(op_dec==AND && ans_tmp==0) ? 2'b10:(op_dec==OR  && ans_tmp==0) ? 2'b10:(op_dec==XOR && ans_tmp==0 ) ? 2'b10:
							(op_dec==NOT && ~B==0) ? 2'b10:(op_dec==ADI && A+data_in>16'b1111111111111111) ? 2'b01: (op_dec==ADI && A+data_in==0) ? 2'b10:
							(op_dec==SBI && A-data_in==0) ? 2'b10:(op_dec==SBI && A-data_in<0) ? 2'b01:(op_dec==MVI && data_in==0) ? 2'b10:(op_dec==ANI && ans_tmp==0 ) ? 2'b10:
							(op_dec==ORI && ans_tmp==0 ) ? 2'b10:(op_dec==XRI && ans_tmp==0) ? 2'b10:
							
							(op_dec==NTI && ~data_in==0) ? 2'b10:(op_dec==RET ) ? 2'b00:(op_dec==HLT ) ? 2'b00:   
							(op_dec==LD) ? 2'b00:(op_dec==ST) ? 2'b00:(op_dec==IN) ? 2'b10:(op_dec==OUT) ? 2'b00:    
							(op_dec==JMP) ? 2'b00:(op_dec==LS) ? 2'b10:(op_dec==RS) ? 2'b10:(op_dec==RSA) ? 2'b10:   
							(op_dec==JV) ? flag_prv:(op_dec==JNV) ? flag_prv:(op_dec==JZ) ? flag_prv:(op_dec==JNZ) ? flag_prv: 0;

////////////////////////////////////////////////////////////////////////////////////////////

 always@(posedge clk)
 begin
		if(reset==1'b0)
		begin
			DM_data = 16'b0;
			ans_ex = 16'b0;
			flag_prv = 2'b0;
			data_out = 16'b0;
		end
		else
		begin
			ans_ex = ans_tmp;
			data_out = data_out_buffer;
			flag_ex = flag_ex_1;
			flag_prv = flag_ex;
			DM_data = B;
		end
 end

endmodule 
