`timescale 1ns / 1ps

module dff(
    input wire clk,
    input wire clr,
    input wire en,
    input wire[7:0] d,
    output reg[7:0] q
    );
always @(posedge clk or posedge clr)begin
    if (clr) q<=8'h00;
    else begin
        if (en)begin
            q<=d;
        end
        else q<=q;
    end 
end
endmodule
