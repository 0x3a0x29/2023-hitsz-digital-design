`timescale 1ns / 1ps

module reg8file(
    input wire clk,
    input wire clr,
    input wire en,
    input wire[7:0] d,
    input wire[2:0] wsel,
    input wire[2:0] rsel,
    output reg[7:0] q
    );
reg [7:0] e;
wire [7:0] r[7:0];
dff d1(.clk(clk),.clr(clr),.en(e[0]),.d(d),.q(r[0]));
dff d2(.clk(clk),.clr(clr),.en(e[1]),.d(d),.q(r[1]));
dff d3(.clk(clk),.clr(clr),.en(e[2]),.d(d),.q(r[2]));
dff d4(.clk(clk),.clr(clr),.en(e[3]),.d(d),.q(r[3]));
dff d5(.clk(clk),.clr(clr),.en(e[4]),.d(d),.q(r[4]));
dff d6(.clk(clk),.clr(clr),.en(e[5]),.d(d),.q(r[5]));
dff d7(.clk(clk),.clr(clr),.en(e[6]),.d(d),.q(r[6]));
dff d8(.clk(clk),.clr(clr),.en(e[7]),.d(d),.q(r[7]));
always@(*)begin
    if (en)begin
    case(wsel)
        3'h0:e=8'h01;
        3'h1:e=8'h02;
        3'h2:e=8'h04;
        3'h3:e=8'h08;
        3'h4:e=8'h10;
        3'h5:e=8'h20;
        3'h6:e=8'h40;
        3'h7:e=8'h80;
        default:e=8'h00;
    endcase
    end
    else e=8'h00;
    case(rsel)
        3'h0:q=r[0];
        3'h1:q=r[1];
        3'h2:q=r[2];
        3'h3:q=r[3];
        3'h4:q=r[4];
        3'h5:q=r[5];
        3'h6:q=r[6];
        3'h7:q=r[7];
        default:q=8'h00;
    endcase
end    
    
    
endmodule
