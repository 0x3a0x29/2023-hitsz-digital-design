`timescale 1ns / 1ps
module top(
    input wire clk,
    input wire rst,
    input wire[3:0] key_row,
    output wire[3:0] key_col,
    output wire[7:0] A,
    output wire[7:0] c
    );
    wire [63:0] number;
    wire out_en;
    wire [7:0] out;//FSM实际上就是keyboard
    FSM f(.clk(clk),.rst(rst),.key_row(key_row),.key_col(key_col),.out(out),.out_en(out_en));
    ValueReg VR(.clk(clk),.rst(rst),.sig(out_en),.in(out),.num(number));
    display DP(.clk(clk),.rst(rst),.number(number),.en(A),.c(c));
endmodule

