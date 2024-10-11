`timescale 1ns / 1ps
module led_display_ctrl(
    input wire clk,
    input wire rst,//异步置位
    input wire button1,//持续计数
    input wire button2,//单步计数
    output wire [7:0] A,
    output wire [7:0] c
    );
    reg [31:0]number;
    reg c_button;
    wire cn;
    wire d_button1,d_button2;
    wire edge1,edge2;
    display d(.clk(clk),.rst(rst),.number(number),.en(A),.c(c));
    always @(posedge clk or posedge rst) begin
       if(rst) number[31:16]<=16'h0000;
       else number<=number; 
    end
    clk_new c_new(.clk(clk),.rst(rst),.button(c_button),.freq_set(2'b11),.clk_new(cn));
    debounce d1(.clk(clk),.rst(rst),.button(button1),.d_button(d_button1));
    debounce d2(.clk(clk),.rst(rst),.button(button2),.d_button(d_button2));
    pos_edge p1(.clk(clk),.rst(rst),.button(d_button1),.pos_edge(edge1));
    pos_edge p2(.clk(clk),.rst(rst),.button(d_button2),.pos_edge(edge2));
    always @(posedge clk or posedge rst) begin
        if(rst) c_button<=1'b0;
        else if(number[7:0]==8'h20) c_button<=1'b0;
        else if(number[7:0]==8'h00&&edge1) c_button<=1'b1;
        else c_button<=c_button;
    end 
    always @(posedge clk or posedge rst) begin
        if(rst) number[15:8]<=8'h00;
        else if(~edge2) number[15:8]<=number[15:8];
        else if(number[15:8]==8'h99) number[15:8]<=8'h00;
        else if(number[11:8]==4'h9) number[15:8]<={number[15:12]+4'h1,4'h0};
        else number[15:8]<=number[15:8]+8'h01;
    end
    always @(posedge clk or posedge rst) begin
        if(rst) number[7:0]<=8'h00;
        else if(number[7:0]==8'h20&&edge1) number[7:0]<=8'h00;
        else if(~cn) number[7:0]<=number[7:0];
        else if(number[3:0]==4'h9) number[7:0]<={number[7:4]+4'h1,4'h0};
        else number[7:0]<=number[7:0]+8'h01;
    end 
endmodule