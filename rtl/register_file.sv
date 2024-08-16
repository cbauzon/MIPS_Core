`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2024 07:26:19 PM
// Design Name: register file
// Module Name: register_file
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: read and write data into registers
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register_file(
    input i_clk,
    input i_rst_n,
    input [4:0] i_A1, i_A2, i_A3,
    input [31:0] i_WD3,
    input i_WE3,
    
    output logic [31:0] o_RD1, o_RD2    
);

// create registers (32 x 32 bits)
logic [31:0] rf [31:0];

// resetting rf
integer i;
always_ff @(posedge i_clk) begin
    if (!i_rst_n) begin
        for (i=0; i<32; ++i) begin
            rf[i] <= 0;
        end
    end
end

// o_RD1 logic
always_ff @(posedge i_clk) begin
    if (!i_rst_n) begin
        o_RD1 <= 0;
    end else begin
        o_RD1 <= rf[i_A1];
    end
end

// o_RD2 logic
always_ff @(posedge i_clk) begin
    if (!i_rst_n) begin
        o_RD2 <= 0;
    end else begin
        o_RD2 <= rf[i_A2];
    end
end

// write logic
always_ff @(posedge i_clk) begin
    if (i_WE3) begin
        rf[i_A3] <= i_WD3;
    end
end


endmodule
