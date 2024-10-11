`timescale 1ns / 1ps
module testbench();
    reg clk;
    reg rst;
    reg[3:0] key_row;
    reg calc;
    reg save;
    reg last;
    reg next;
    wire[3:0] key_col;
    wire[7:0] A;
    wire[7:0] c;
    top t(.clk(clk),.rst(rst),.key_row(key_row),.calc(calc),.save(save),
    .last(last),.next(next),.key_col(key_col),.A(A),.c(c));
    always #5 clk = ~clk;
    reg button_en;
    reg[3:0] button;
    always @(*)begin
        if(button_en)begin
        case(button)
        4'h0:if(key_col==4'b1011)key_row=4'b1110;else key_row=4'b1111;
        4'h1:if(key_col==4'b0111)key_row=4'b0111;else key_row=4'b1111;
        4'h2:if(key_col==4'b1011)key_row=4'b0111;else key_row=4'b1111;
        4'h3:if(key_col==4'b1101)key_row=4'b0111;else key_row=4'b1111;
        4'h4:if(key_col==4'b0111)key_row=4'b1011;else key_row=4'b1111;
        4'h5:if(key_col==4'b1011)key_row=4'b1011;else key_row=4'b1111;
        4'h6:if(key_col==4'b1101)key_row=4'b1011;else key_row=4'b1111;
        4'h7:if(key_col==4'b0111)key_row=4'b1101;else key_row=4'b1111;
        4'h8:if(key_col==4'b1011)key_row=4'b1101;else key_row=4'b1111;
        4'h9:if(key_col==4'b1101)key_row=4'b1101;else key_row=4'b1111;
        4'ha:if(key_col==4'b1110)key_row=4'b0111;else key_row=4'b1111;
        4'hb:if(key_col==4'b1110)key_row=4'b1011;else key_row=4'b1111;
        4'hc:if(key_col==4'b1110)key_row=4'b1101;else key_row=4'b1111;
        4'hd:if(key_col==4'b1110)key_row=4'b1110;else key_row=4'b1111;
        default:key_row=4'b1111;
        endcase
        end
        else key_row=4'hf;
    end
    always #5 clk=~clk;
    //仿真时将clk_new参数调整为A=20,B=16,C=100
    //23*32/12+67-8
    initial begin
    clk=1'b0;
    rst=1'b1;
    calc=1'b0;
    save=1'b0;
    last=1'b0;
    next=1'b0;
    button_en=1'b0;
    button=4'h2;
    #10
    rst=1'b0;
    button_en=1'b1;
    #1000
    button=4'h3;
    #1000
    button=4'hc;
    #1000
    button=4'h3;
    #1000
    button=4'h2;
    #1000
    button_en=1'b0;
    calc=1'b1;
    button=4'hd;
    #20
    save=1'b1;
    #1000
    save=1'b0;
    calc=1'b0;
    button_en=1'b1;
    #1000
    button=4'h1;
    #1000
    button=4'h2;
    #1000
    calc=1'b1;
    #20
    save=1'b1;
    button=4'ha;
    button_en=1'b0;
    #1000
    save=1'b0;
    calc=1'b0;
    button_en=1'b1;
    #1000
    button=4'h6;
    #1000
    button=4'h7;
    #1000
    calc=1'b1;
    #20
    save=1'b1;
    button=4'hb;
    button_en=1'b0;
    #1000
    save=1'b0;
    calc=1'b0;
    button_en=1'b1;
    #1000
    button=4'h8;
    #1000
    calc=1'b1;
    #20
    last=1'b1;
    #500
    calc=1'b0;
    last=1'b0;
    #500
    last=1'b1;
    #500
    last=1'b0;
    #500
    last=1'b1;
    #500
    last=1'b0;
    #500
    next=1'b1;
    #500
    next=1'b0;
    #500
    next=1'b1;
    #500
    next=1'b0;
    #500
    next=1'b1;
    #500
    next=1'b0;
    #500
    next=1'b1;
    #500
    next=1'b0;
    #500
    $finish;
    end
endmodule
