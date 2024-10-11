`timescale 1ns / 1ps
module testbench(
    );
    reg clk,rst;
    reg [3:0] key_row;
    wire [3:0] key_col;
    wire [7:0] en;
    wire [7:0] c;//在这里设置了clk_new.v中A=20
    top T(.clk(clk),.rst(rst),.key_row(key_row),.key_col(key_col),.A(en),.c(c));
    initial begin
    rst=1'b1;
    clk=1'b0;
    key_row=4'b1111;
    #5
    rst=1'b0;
    #500
    key_row=4'b1110;
    #1000
    key_row=4'b1111;
    #850
    key_row=4'b1110;
    #1000
    key_row=4'b1111;
    #100
    key_row=4'b1011;
    #1000
    key_row=4'b1111;
    #1000
    key_row=4'b1011;
    #1000
    key_row=4'b1111;
    #1000
    key_row=4'b1011;
    #1000
    key_row=4'b1111;
    #1000
    key_row=4'b1011;
    #1000
    key_row=4'b1111;
    #1000
    key_row=4'b1101;
    #1000
    key_row=4'b1111;
    #1000
    key_row=4'b1110;
    #1000
    key_row=4'b1111;
    #1000
    key_row=4'b1110;
    #1000
    key_row=4'b1111;
    #1000
    $finish;
    end
    always #5 clk = ~clk;
endmodule