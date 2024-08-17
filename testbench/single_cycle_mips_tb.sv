`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/16/2024 05:53:19 PM
// Design Name: 
// Module Name: single_cycle_mips_tb
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


module single_cycle_mips_tb();
    
logic i_clk, i_rst_n;

initial begin
    i_clk = 0;
    i_rst_n = 1;
    forever #10 i_clk = ~i_clk;
end

single_cycle_mips DUT(
    .i_clk (i_clk),
    .i_rst_n (i_rst_n)   
);

initial begin
@(posedge i_clk);
i_rst_n = 0;
@(negedge i_clk);
i_rst_n = 1;
#500;
$finish;

end
endmodule
