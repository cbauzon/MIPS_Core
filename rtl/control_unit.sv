`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/16/2024 05:18:56 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [5:0] i_Op,
    input [5:0] i_Funct,
    
    output logic o_MemtoReg,
    output logic o_MemWrite,
    output logic o_Branch,
    output logic [2:0] o_ALUControl,
    output logic o_ALUSrc,
    output logic o_RegDst,
    output logic o_RegWrite
);

logic [1:0] ALUOp;

always_comb begin
    case (i_Op)
        6'b00_0000: begin
            o_RegWrite = 1;
            o_RegDst = 1;
            o_ALUSrc = 0;
            o_Branch = 0;
            o_MemWrite = 0;
            o_MemtoReg = 0;
            ALUOp = 'b10;
        end
    
        6'b10_0011: begin
            o_RegWrite = 1;
            o_RegDst = 0;
            o_ALUSrc = 1;
            o_Branch = 0;
            o_MemWrite = 0;
            o_MemtoReg = 1;
            ALUOp = 'b00;
        end

        6'b10_1011: begin
            o_RegWrite = 0;
            o_RegDst = 0;
            o_ALUSrc = 1;
            o_Branch = 0;
            o_MemWrite = 1;
            o_MemtoReg = 0;
            ALUOp = 'b00;
        end

        6'b00_0000: begin
            o_RegWrite = 0;
            o_RegDst = 1;
            o_ALUSrc = 0;
            o_Branch = 1;
            o_MemWrite = 0;
            o_MemtoReg = 0;
            ALUOp = 'b01;
        end

        default: begin
            o_RegWrite = 0;
            o_RegDst = 0;
            o_ALUSrc = 0;
            o_Branch = 0;
            o_MemWrite = 0;
            o_MemtoReg = 0;
            ALUOp = 0;
        end
    endcase
end

always_comb begin
    case (ALUOp)
        'b00: begin
            o_ALUControl = 'b010;
        end

        'bx1: begin
            o_ALUControl = 'b110;
        end

        'b1x: begin
            if (i_Funct == 'b100_0000)  o_ALUControl = 'b010;
            else if (i_Funct == 'b10_0010) o_ALUControl = 'b110;
            else if (i_Funct == 'b10_0100) o_ALUControl = 'b000;
            else if (i_Funct == 'b10_0101) o_ALUControl = 'b001;
            else if (i_Funct == 'b10_1010) o_ALUControl = 'b111;
            else o_ALUControl = 'b000;
        end

        default: o_ALUControl = 'b000;
    endcase
end
endmodule
