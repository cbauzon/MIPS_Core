`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2024 09:09:31 PM
// Design Name: 
// Module Name: alu
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


module alu(
    input [31:0] i_SrcA,
    input [31:0] i_SrcB,
    input [2:0] i_ALUControl,

    output logic [31:0] o_ALUResult,
    output logic o_zero_flag    
);

always_comb begin
    o_zero_flag = (o_ALUResult == 0)? 1:0;
end

always_comb begin
    case(i_ALUControl)

        010: begin// lw
            o_ALUResult = i_SrcA + i_SrcB;
        end

        default: o_ALUResult = 0;
    endcase
end
endmodule
