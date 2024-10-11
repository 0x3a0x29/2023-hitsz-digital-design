`timescale 1ns / 1ps
module top(
    input wire clk,
    input wire rst,
    input wire[3:0] key_row,
    input wire calc,
    input wire save,
    input wire last,
    input wire next,
    output wire[3:0] key_col,
    output wire[7:0] A,
    output wire[7:0] c
    );
    wire [31:0] number;
    wire sig;
    wire debounce_calc,debounce_save,debounce_last,debounce_next;
    wire [3:0] out;
    KeyBoard f(.clk(clk),.rst(rst),.key_row(key_row),.key_col(key_col),.out(out),.sig(sig));
    ValueReg VR(.clk(clk),.rst(rst),.sig(sig),.in(out),.num(number),
    .calc(calc),.save(save),.last(last),.next(next));
    display DP(.clk(clk),.rst(rst),.number(number),.en(A),.c(c));
endmodule
