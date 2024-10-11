`timescale 1ns / 1ps
module display(
    input wire clk,
    input wire rst,
    input wire [63:0] number,
    output reg [7:0] en,
    output reg [7:0] c
    );
    reg[7:0] num;
    reg[3:0] count;
    wire cn;
    clk_new c_new(.clk(clk),.rst(rst),.button(1'b1),.freq_set(2'b00),.clk_new(cn));//
    always @(posedge clk or posedge rst) begin
        if(rst) en<=8'hfe;
        else if(cn)en<={en[6:0],en[7]};
        else en<=en;
    end
    always @(*)begin
        case(num)
            8'h0:c=8'h03;
            8'h1:c=8'h9f;
            8'h2:c=8'h25;
            8'h3:c=8'h0d;
            8'h4:c=8'h99;
            8'h5:c=8'h49;
            8'h6:c=8'h41;
            8'h7:c=8'h1f;
            8'h8:c=8'h01;
            8'h9:c=8'h19;
            8'ha:c=8'h11;
            8'hb:c=8'hc1;
            8'hc:c=8'he5;
            8'hd:c=8'h85;
            8'he:c=8'h61;
            8'hf:c=8'h71;
            8'h1a:c=8'hc5;
            8'h1b:c=8'h83;
            8'h1c:c=8'h63;
            8'h1d:c=8'h00;
            default:c=8'hff;
        endcase
    end
    always@(*)begin
        case(1'b0)
            en[0]:num=number[7:0];
            en[1]:num=number[15:8];
            en[2]:num=number[23:16];
            en[3]:num=number[31:24];
            en[4]:num=number[39:32];
            en[5]:num=number[47:40];
            en[6]:num=number[55:48];
            default:num=number[63:56];
        endcase
    end
endmodule

