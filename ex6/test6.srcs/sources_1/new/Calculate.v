`timescale 1ns / 1ps
module Calculate(
    input wire[15:0] num1,
    input wire[7:0] num2,
    input wire[3:0] op,
    output reg[15:0] result
    );
    wire[15:0] new1=num1[15:12]*10'd1000+num1[11:8]*7'd100+num1[7:4]*4'd10+num1[3:0];
    wire[7:0] new2=num2[7:4]*4'd10+num2[3:0];
    reg[15:0] r;
    always @(*)begin
        case(op)
            4'hd:if(|new2)r=new1/new2;
            else r=16'h0;
            4'hc:r=new1*new2;
            4'hb:r=new1-new2;
            4'ha:r=new1+new2;
            default:r=16'h0;
            endcase
        result[15:12]=r/1000;
        result[11:8]=r/100%10;
        result[7:4]=r/10%10;
        result[3:0]=r%10;
    end
endmodule