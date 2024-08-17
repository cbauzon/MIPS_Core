`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2024 07:10:54 PM
// Design Name: program counter
// Module Name: program_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: increments instruction memory to the next address
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module program_counter(
    input i_clk,
    input i_rst_n,
    input [31:0] i_prev_PC,
    output logic [31:0] o_curr_PC
);
    
    always_ff @(posedge i_clk) begin
        if (!i_rst_n) begin
            o_curr_PC <= 0;
        end else begin
            o_curr_PC <= i_prev_PC;
        end
    end

    
endmodule
