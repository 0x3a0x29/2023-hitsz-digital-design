`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/27 16:42:53
// Design Name: 
// Module Name: multiplexer
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


module multiplexer(
    input wire enable,
    input wire select,
    input wire[3:0] input_a,
    input wire[3:0] input_b,
    output reg[3:0] led
    );
    always @(*)begin
        if (enable)begin
            if (select)begin
                led=input_a-input_b;
            end
            else begin
                led=input_a+input_b;
            end
        end
        else begin
            led=4'hf;
        end
    end
endmodule
