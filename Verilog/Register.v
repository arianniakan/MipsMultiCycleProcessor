module REG (clk,in,out,rst);
parameter n = 3;
input clk;
input rst;
input [n-1:0] in;
output reg [n-1:0] out;
always @(posedge clk) begin
    if (rst==1) out=0;
    else out<=in;
end


endmodule