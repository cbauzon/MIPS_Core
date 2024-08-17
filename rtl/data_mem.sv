`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2024 07:44:40 PM
// Design Name: 
// Module Name: data_mem
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


module data_mem(
    input i_clk,
    
    input [12:0] i_A, 
    input [31:0] i_WD,
    input i_WE,
    
    output logic [31:0] o_RD
);

// create memory
(* ram_style="block" *) logic [31:0] mem [(2**13)-1:0];
initial begin
    $readmemh("memdump_mem.mem", mem, 0, 2**13-1);
end

// read logic
always_comb begin
    if (!i_WE) begin
        o_RD <= mem[i_A];
    end
end

// write logic
always_ff @(posedge i_clk) begin
    if (i_WE) begin
        mem[i_A] <= i_WD;
    end
end
endmodule
