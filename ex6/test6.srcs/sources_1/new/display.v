`timescale 1ns / 1ps
module display(
    input wire clk,
    input wire rst,
    input wire [31:0] number,
    output reg [7:0] en,
    output reg [7:0] c
    );
    reg[3:0] num;
    reg[3:0] count;
    wire cn;
    clk_new c_new(.clk(clk),.rst(rst),.button(1'b1),.freq_set(2'b00),.clk_new(cn));
    always @(posedge clk or posedge rst) begin
        if(rst) en<=8'hfe;
        else if(cn)en<={en[6:0],en[7]};
        else en<=en;
    end
    always @(*)begin
        case(num)
            4'h0:c=8'h03;
            4'h1:c=8'h9f;
            4'h2:c=8'h25;
            4'h3:c=8'h0d;
            4'h4:c=8'h99;
            4'h5:c=8'h49;
            4'h6:c=8'h41;
            4'h7:c=8'h1f;
            4'h8:c=8'h01;
            4'h9:c=8'h19;
            4'ha:c=8'h11;
            4'hb:c=8'hc1;
            4'hc:c=8'he5;
            4'hd:c=8'h85;
            4'he:c=8'h61;
            4'hf:c=8'h71;
        endcase
    end
    always@(*)begin
        case(1'b0)
            en[0]:num=number[3:0];
            en[1]:num=number[7:4];
            en[2]:num=number[11:8];
            en[3]:num=number[15:12];
            en[4]:num=number[19:16];
            en[5]:num=number[23:20];
            en[6]:num=number[27:24];
            default:num=number[31:28];
        endcase
    end
endmodule