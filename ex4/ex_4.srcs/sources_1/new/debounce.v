`timescale 1ns / 1ps
module debounce(
    input wire clk,
    input wire rst,
    input wire button,
    output reg d_button
    );
    wire up,down;
    wire up_button=button &~d_button;
    wire down_button=~button&d_button;
    clk_new d1(.clk(clk),.rst(rst),.button(up_button),.freq_set(2'b01),.clk_new(up));
    clk_new d2(.clk(clk),.rst(rst),.button(down_button),.freq_set(2'b01),.clk_new(down));
    always @(posedge clk or posedge rst) begin
        if(rst) d_button<=1'b0;
        else if(up) d_button<=1'b1;
        else if(down) d_button<=1'b0;
        else d_button<=d_button;
    end
endmodule
