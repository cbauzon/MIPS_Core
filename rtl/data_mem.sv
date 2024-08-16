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
    input i_rst_n,
    
    input [31:0] i_A, 
    input [31:0] i_WD,
    input i_WE,
    
    output logic [31:0] o_RD
);

// create memory
logic [7:0] mem [(2**32)-1:0];

// resetting memory
integer i;
logic [31:0] MEM_HEIGHT = (2**32)-1;
always_ff @(posedge i_clk) begin
    if (!i_rst_n) begin
        for (i=0; i< MEM_HEIGHT; ++i) begin
            mem[i] <= 0;
        end
    end
end

// read logic
always_comb begin
    if (!i_WE) begin
        o_RD <= {mem[i_A+3], mem[i_A+2], mem[i_A+1], mem[i_A]};
    end
end

// write logic
always_ff @(posedge i_clk) begin
    if (i_WE) begin
        for (int i=0; i<4; ++i) begin
            mem[i_A + i] <= i_WD[i*8+:8];
        end
    end
end
endmodule
