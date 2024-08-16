`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2024 08:25:35 PM
// Design Name: 
// Module Name: single_cycle_mips
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module single_cycle_mips(
    input i_clk,
    input i_rst_n
);

/* PROGRAM COUNTER */ 
logic [31:0] prev_PC, curr_PC;
program_counter pc(
    .i_clk      (i_clk),
    .i_rst_n    (i_rst_n),
    .i_prev_PC  (prev_PC),
    .i_curr_PC  (curr_PC)
);

/* INSTRUCTION MEMORY */
logic [31:0] instr;
instr_mem im(
    .i_A    (curr_PC),
    .o_RD   (instr)
);

/* sign extension */
logic [31:0] signImm;
always_comb begin
    signImm = {{16{instr[15]}},instr[15:0]};
end

/* REGISTER FILE */
register_file rf(
    .i_clk      (i_clk),
    .i_rst_n    (i_rst_n),
    .i_A1       (instr[25:21]), 
    .i_A2       (), 
    .i_A3       (),
    .i_WD3      (),
    .i_WE3      (),
    
    .o_RD1      (), 
    .o_RD2      ()       
);


endmodule
