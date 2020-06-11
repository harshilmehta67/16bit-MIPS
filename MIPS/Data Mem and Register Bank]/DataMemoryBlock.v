`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:54:32 09/05/2019 
// Design Name: 
// Module Name:    DataMemoryBlock 
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
module DataMemoryBlock(
    input [15:0] ans_ex,
    input [15:0] DM_data,
    input [0:0] mem_rw_ex,
    input [0:0] mem_en_ex,
    input [0:0] mem_mux_sel_dm,
    input [0:0] reset,
    input [0:0] clk,
    output [15:0] ans_dm
    );
	 
	 
reg [15:0]Ex_out;
wire [15:0]DM_out;
reg Reg[15:0];
	 
 DMem your_instance_name (
  .clka(clk), // input clka
  .ena(mem_en_ex), // input ena
  .wea(mem_rw_ex), // input [0 : 0] wea
  .addra(ans_ex), // input [15 : 0] addra
  .dina(DM_data), // input [15 : 0] dina
  .douta(DM_out) // output [15 : 0] douta
);
	 
	 
	 


always @(posedge clk)
begin

  Ex_out = (reset==1'b1) ? ans_ex : 16'b0 ;

end


assign ans_dm = (mem_mux_sel_dm == 1'b1) ? DM_out : Ex_out ;

endmodule
