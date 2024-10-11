`timescale 1ns / 1ps
module ValueReg(
    input wire clk,
    input wire rst,
    input wire sig,
    input wire[7:0] in,
    output reg[63:0] num
    );
always @(posedge clk or posedge rst)begin
if (rst) num<=64'h0;
else begin
    if (sig) num<={num[55:0],in};
    else num<=num;
     end
end
endmodule