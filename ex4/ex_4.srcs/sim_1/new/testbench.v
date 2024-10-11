`timescale 1ns / 1ps
module testbench();
    reg clk;
    reg rst;
    reg button1;
    reg button2;
    wire [7:0] A;
    wire [7:0] c;
    //��clk_new.v���޸�A=20,B=16,C=100��Ϊ����ʱ�Ĳ���
    led_display_ctrl lc(.clk(clk),.rst(rst),.button1(button1),.button2(button2),.A(A),.c(c));
    always #5 clk=~clk;
    initial begin
        clk=1'b0;
        rst=1'b1;
        button1=1'b0;
        button2=1'b0;
        #3000
        button1=1'b1;
        button2=1'b1;
        rst=1'b0;
        #3000
        button1=1'b0;
        button2=1'b0;
        #10000
        button2=1'b1;
        button1=1'b1;
        #3000
        button1=1'b0;
        button2=1'b0;#3000
        button1=1'b1;
        button2=1'b1;
        rst=1'b0;
        #3000
        button1=1'b0;
        button2=1'b0;
        #10000
        button2=1'b1;
        button1=1'b1;
        #3000
        button1=1'b0;
        button2=1'b0;
        #3000
        button2=1'b1;
        button1=1'b1;
        #3000
        button1=1'b0;
        button2=1'b0;
        #3000
        $finish;
    end
endmodule

