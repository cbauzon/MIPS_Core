`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2024 07:18:43 PM
// Design Name: instruction memory
// Module Name: instr_mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: stores the instructions (ROM)
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module instr_mem(
    input [15:0] i_A,
    output logic [31:0] o_RD
);

// instantiate memory (byte addressable)
(* ram_style="block" *) logic [7:0] mem [65535:0];

always_comb begin
    o_RD = {mem[i_A+3], mem[i_A+2], mem[i_A+1], mem[i_A]};
end
endmodule
