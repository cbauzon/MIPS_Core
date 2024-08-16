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
logic [31:0] RD1, RD2;
register_file rf(
    .i_clk      (i_clk),
    .i_rst_n    (i_rst_n),
    .i_A1       (instr[25:21]), 
    .i_A2       (instr[20:16]), 
    .i_A3       (WriteReg),
    .i_WD3      (Result),
    .i_WE3      (),
    
    .o_RD1      (RD1), 
    .o_RD2      (RD2)       
);

/* ALU */
logic [31:0] ALUResult;
logic Zero;
alu alu(
    .i_SrcA         (RD1),
    .i_SrcB         (SrcB),
    .i_ALUControl   ('b010),

    .o_ALUResult    (ALUResult),
    .o_zero_flag    (Zero)    
);

/* DATA MEMORY */
logic [31:0] ReadData;
data_mem dm(
    .i_clk      (i_clk),
    .i_rst_n    (i_rst_n),
    
    .i_A        (ALUResult), 
    .i_WD       (RD2),
    .i_WE       (),
    
    .o_RD       (ReadData)
);

// mem to reg mux
logic MemtoReg;
logic [31:0] Result;
assign Result = (MemtoReg)? ReadData: ALUResult;

// alusrc mux
logic ALUSrc;
logic [31:0] SrcB;
assign SrcB = (ALUSrc)? signImm: RD2;

// regdst mux
logic RegDst;
logic [4:0] WriteReg;
assign WriteReg = (RegDst)? instr[15:11]: instr[20:16];

// PCSrc logic and mux
logic PCSrc;
logic Branch;
assign PCSrc = Branch & Zero;
assign prev_PC = (PCSrc)? PCBranch: curr_PC+4;

// PCBranch logic
logic [31:0] PCBranch;
assign PCBranch = (signImm << 2) + (curr_PC+4);


endmodule
