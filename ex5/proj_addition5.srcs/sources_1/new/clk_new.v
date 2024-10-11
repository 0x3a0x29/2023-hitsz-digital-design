`timescale 1ns / 1ps
module clk_new(
    input wire clk,
    input wire rst,
    input wire button,
    input wire[1:0] freq_set,
    output wire clk_new
    );
reg [23:0] cnt;
reg cnt_inc;
reg [23:0] state;
assign clk_new=cnt_inc&(cnt==state);//·ÂÕæÉèÖÃclk_new.vÖĞA=20
parameter A=24'd200000; //200000,2ms
parameter B=24'd1500000; //1500000,15ms
parameter C=24'd10000000; //10000000,0.1s
always @ (*) begin
        case(freq_set)
        2'b00: state=A-24'd1; 
        2'b01: state=B-24'd1; 
        default: state=C-24'd1; 
        endcase
    end
always @ (posedge clk or posedge rst) begin
    if(rst) cnt_inc<=1'b0;          
    else if(button) cnt_inc<=1'b1;       
    else cnt_inc<=1'b0;
end
always @ (posedge clk or posedge rst) begin
    if(rst)       cnt<=24'h0;          
    else if(clk_new) cnt<=24'h0;
    else if(cnt_inc) cnt<=cnt+24'h1;       
    else cnt<=24'h0; 
end
endmodule