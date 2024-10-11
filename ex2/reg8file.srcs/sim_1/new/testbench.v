`timescale 1ns/1ps

module testbench (
);

reg clk,clr,en;
reg[7:0] d;
reg[2:0] wsel;
reg[2:0] rsel;
wire[7:0] q;
reg8file rf_t(
    .clk(clk),
    .clr(clr),
    .en(en),
    .d(d),
    .q(q),
    .wsel(wsel),
    .rsel(rsel)
   );
initial begin
    clk=1'b0;
    clr=1'b1;
    en=1'b0;
    d=8'h00;
    wsel=3'h0;
    rsel=3'h0;
    #10
    clr=1'b0;
    en=1'b1;
    d=8'h53;
    #10
    wsel=3'h1;
    d=8'h12;
    #10
    rsel=3'h1;
    #10
    en=1'b0;
    d=8'h93;
    #10
    en=1'b1;
    d=8'h35;
    wsel=3'h0;
    #10
    rsel=3'h0;
    #10
    clr=1'b1;
    #10
    d=8'h00;
    clr=1'b0;
    rsel=3'h1;
    #10
    $finish;
end

always #5 clk = ~clk;

endmodule
