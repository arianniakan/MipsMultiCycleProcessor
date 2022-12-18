`include "MIPS.v"
`default_nettype none

module tb_MIPS;
reg clk;
reg rst;

MIPS mips1
(
    .rst (rst),
    .clk (clk)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;


initial begin
    #1 rst<=1'bx;clk<=1'bx;
    #(CLK_PERIOD*3) rst<=1;clk<=0;
    #(CLK_PERIOD*3) rst<=0;
    #500000 $stop;
end

endmodule
`default_nettype wire