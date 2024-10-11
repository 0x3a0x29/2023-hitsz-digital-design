`timescale 1ns / 1ps
module pos_edge(
    input wire clk,
    input wire rst,
    input wire button,
    output wire pos_edge
    );
    reg r0,r1;
    always @(posedge clk or posedge rst)
    begin
        if(rst)begin 
        r0<=1'b0;
        r1<=1'b0;
        end
        else begin 
        r0<=button;
        r1<=r0;
        end
    end
    assign pos_edge=~r1&r0;
endmodule
