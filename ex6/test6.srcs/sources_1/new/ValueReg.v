`timescale 1ns / 1ps
module ValueReg(
    input wire clk,
    input wire rst,
    input wire sig,
    input wire[3:0] in,
    input wire calc,
    input wire save,
    input wire last,
    input wire next,
    output reg[31:0] num
    );
    wire d_save,d_last,d_next,pos_save,pos_last,pos_next;
    wire[15:0] result;
    debounce dsave(.clk(clk),.rst(rst),.button(save),.d_button(d_save));
    debounce dlast(.clk(clk),.rst(rst),.button(last),.d_button(d_last));
    debounce dnext(.clk(clk),.rst(rst),.button(next),.d_button(d_next));
    pos_edge psave(.clk(clk),.rst(rst),.button(d_save),.pos_edge(pos_save));
    pos_edge plast(.clk(clk),.rst(rst),.button(d_last),.pos_edge(pos_last));
    pos_edge pnext(.clk(clk),.rst(rst),.button(d_next),.pos_edge(pos_next));
    parameter Num11=4'h0;
    parameter Num12=4'h1;
    parameter Op=4'h2;
    parameter Num21=4'h3;
    parameter Num22=4'h4;
    parameter Wait=4'h5;
    reg[3:0] state,state_n;
    reg type;
    reg[3:0] s;
    reg in_ctrl;
    reg[15:0] InputReg;
    reg[15:0] NumReg1;
    reg[7:0] NumReg2;
    reg[3:0] OpReg;
    reg[15:0] ResultReg;
    reg[63:0] MReg;
    Calculate r(.num1(NumReg1),.num2(NumReg2),.op(OpReg),.result(result));
    always @(*)begin
        if (in<4'ha) type=1'b1;//num
        else type=1'b0;//op
    end
    always@(posedge clk or posedge rst)begin
        if (rst) state<=Num11;
        else state<=state_n;
    end
    always@(*)begin
        case(state)
            Num11:if (sig&type) state_n=Num12;
            else state_n=Num11;
            Num12:if (sig&type) state_n=Op;
            else if (sig&~type) state_n=Num21;
            else state_n=Num12;
            Op:if (sig&~type) state_n=Num21;
            else state_n=Op;
            Num21:if (sig&type) state_n=Num22;
            else state_n=Num21;
            Num22:if (sig&type) state_n=Wait;
            else if(sig&~type) state_n=Num22;
            else if(calc) state_n=Op;
            else state_n=Num22;
            Wait:if (calc) state_n=Op;
            else state_n=Wait;
            default:state_n=state;
        endcase
    end
    always@(*)begin
        case({state,state_n})
            8'h01:begin in_ctrl=1'b1;s=4'h0;end
            8'h12:begin in_ctrl=1'b1;s=4'h1;end
            8'h13:begin in_ctrl=1'b1;s=4'h2;end
            8'h23:begin in_ctrl=1'b1;s=4'h3;end
            8'h34:begin in_ctrl=1'b1;s=4'h4;end
            8'h45:begin in_ctrl=1'b1;s=4'h5;end
            8'h42:begin in_ctrl=1'b0;s=4'h6;end
            8'h52:begin in_ctrl=1'b0;s=4'h7;end
            default:begin in_ctrl=1'b0;s=4'h8;end
        endcase
    end
    always @(posedge clk or posedge rst)begin
        if (rst)begin
            NumReg1<=16'h0;
            NumReg2<=8'h0;
            OpReg<=4'h0;
            ResultReg<=16'h0;
        end
        else begin
            case(s)
            4'h0:NumReg1<={12'h0,in};
            4'h1:NumReg1<={8'h0,NumReg1[3:0],in};
            4'h2:OpReg<=in;
            4'h3:OpReg<=in;
            4'h4:NumReg2<={4'h0,in};
            4'h5:NumReg2<={NumReg2[3:0],in};
            4'h6:begin NumReg1<=result;
            NumReg2<=8'h0;
            OpReg<=4'h0;
            ResultReg<=result;
            end
            4'h7:begin NumReg1<=result;
            NumReg2<=8'h0;
            OpReg<=4'h0;
            ResultReg<=result;
            end
            default:begin NumReg1<=NumReg1;
            NumReg2<=NumReg2;
            OpReg<=OpReg;
            end
            endcase
        end
    end
    
    always@(posedge clk or posedge rst)begin
        if(rst) InputReg<=16'h0;
        else if(in_ctrl) InputReg<={InputReg[12:0],in};
        else InputReg<=InputReg;
    end
    reg[2:0] m_pos;
    always @(posedge clk or posedge rst)begin
    if(rst) begin m_pos<=3'h0;
        MReg<=64'h0;
    end
     else begin
        if(pos_save)begin MReg<={MReg[47:0],ResultReg};end
        else if(pos_last) begin
                if(m_pos==3'h4) m_pos<=m_pos;
                else m_pos<=m_pos+3'h1;
            end
        else if(pos_next) begin
                if(m_pos==3'h0) m_pos<=m_pos;
                else m_pos<=m_pos-3'h1; 
            end
        end
    end
    always @(*)begin
    num[31:16]=InputReg;
    case(m_pos)
    3'h0:num[15:0]=ResultReg[15:0];
    3'h1:num[15:0]=MReg[15:0];
    3'h2:num[15:0]=MReg[31:16];
    3'h3:num[15:0]=MReg[47:32];
    3'h4:num[15:0]=MReg[63:48];
    endcase
    end
endmodule