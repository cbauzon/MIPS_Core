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
    input [12:0] i_A,
    
    output logic [31:0] o_RD
);

// instantiate memory (word addressable)
(* ram_style = "block" *) logic [31:0] mem [2**13-1:0];

initial begin
    $readmemh("memdump.mem", mem, 0, 2**12-1);
end


assign o_RD = mem[i_A];

endmodule
