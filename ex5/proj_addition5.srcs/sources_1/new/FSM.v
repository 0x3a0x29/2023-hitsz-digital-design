`timescale 1ns / 1ps
module FSM(
    input wire clk,
    input wire rst,
    input wire[3:0] key_row,
    output reg[3:0] key_col,
    output reg[7:0] out,
    output reg out_en
    );//FSM实际上就是keyboard
    reg[3:0] count,last_col;
    reg en,special,read;
    reg[2:0] state,state_n,state_l;
    wire ctrl=~state_l[2]&state[2];
    always@(*)begin
        last_col=key_col;
    end
    always @(*)begin
    case(key_row)
    4'b1110:read=1;
    4'b1101:read=1;
    4'b1011:read=1;
    4'b0111:read=1;
    default:read=0;
    endcase
    end
    parameter C0=3'h0;
    parameter C1=3'h1;
    parameter C2=3'h2;
    parameter C3=3'h3;
    parameter CR=3'h4;
    always@(*)begin
        case({key_col,key_row})
            8'b1101_1110 : out_en=1'b0;
            8'b0111_1110 : out_en=1'b0;
            default:out_en=en;
        endcase
    end
    always @(posedge clk or posedge rst)begin
        if (rst)begin
            en<=1'b0;
        end
        else begin
            if (ctrl) en<=1'b1;
            else en<=1'b0;
        end
    end
    always@(posedge clk or posedge rst)begin
        if (rst)begin
            state<=C0;
            state_l<=C0;
            count<=4'h0;
        end
        else begin
            if(count==4'he) begin state<=state_n;count<=4'h0;end
            else begin state<=state;count<=count+4'h1;end
            if (state_l!=state) state_l<=state;
            else state_l<=state_l;
        end
    end
    always @(*)begin
        if (~read)begin
            case(state)
            C0:state_n=C1;
            C1:state_n=C2;
            C2:state_n=C3;
            C3:state_n=C0;
            CR:state_n=C0;
            default:state_n=C0;
            endcase
        end
        else begin
            state_n=CR;
        end
    end
    always@(posedge clk or posedge rst)begin
        if (rst) key_col<=4'b1111;
        else begin
            case(state)
            C0:key_col<=4'b1110;
            C1:key_col<=4'b1101;
            C2:key_col<=4'b1011;
            C3:key_col<=4'b0111;
            CR:key_col<=last_col;
            endcase
        end
    end
    always @(posedge clk or posedge rst)begin
        if (rst)begin
            special<=1'b0;
        end
        else begin
        if (en)begin
                 if (~special)
                    if ({key_col,key_row}==8'b0111_1110)
                        special<=1'b1;
                    else special<=special;
                 else
                    if (key_col==4'b1110)
                        special<=1'b0;
                    else if ({key_col,key_row}==8'b0111_1110)
                        special<=1'b0;
                    else special<=special;
            end
        else special<=special;
        end
    end
    always @(posedge clk or posedge rst)begin
    if (rst) out<=8'h0;
    else begin
    if (state==CR)begin
        if (~special)begin
        case ({key_col,key_row})  //      
        8'b1110_1110 : out<= 8'hd;   // key_posedge[0]
        8'b1110_1101 : out<= 8'hc;   // key_posedge[1]
        8'b1110_1011 : out<= 8'hb;   // key_posedge[2]
        8'b1110_0111 : out<= 8'ha;
        8'b1101_1110 : out<= out;    //#
        8'b1101_1101 : out<= 8'h9;
        8'b1101_1011 : out<= 8'h6;
        8'b1101_0111 : out<= 8'h3;
        8'b1011_1110 : out<= 8'h0;
        8'b1011_1101 : out<= 8'h8;
        8'b1011_1011 : out<= 8'h5;
        8'b1011_0111 : out<= 8'h2;
        8'b0111_1110 : out<= out;//*
        8'b0111_1101 : out<= 8'h7;
        8'b0111_1011 : out<= 8'h4;
        8'b0111_0111 : out<= 8'h1;
        endcase
        end
        else begin
        case ({key_col,key_row})  //      
        8'b1110_1110 :out<= 8'h1d;  // key_posedge[0]
        8'b1110_1101 :out<= 8'h1c;  // key_posedge[1]
        8'b1110_1011 :out<= 8'h1b;  // key_posedge[2]
        8'b1110_0111 :out<= 8'h1a;
        8'b1101_1110 : out<= out;    //#
        8'b1101_1101 : out<= 8'h9;
        8'b1101_1011 : out<= 8'h6;
        8'b1101_0111 : out<= 8'h3;
        8'b1011_1110 : out<= 8'h0;
        8'b1011_1101 : out<= 8'h8;
        8'b1011_1011 : out<= 8'h5;
        8'b1011_0111 : out<= 8'h2;
        8'b0111_1110 : out<= out;//*
        8'b0111_1101 : out<= 8'h7;
        8'b0111_1011 : out<= 8'h4;
        8'b0111_0111 : out<= 8'h1;
        endcase
        end
        end
        end
    end
endmodule