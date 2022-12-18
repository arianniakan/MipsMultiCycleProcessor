module InstMem(input clk, input [31:0] address, output [31:0] Inst);
reg[7:0] mem[0:65535];
initial begin
$readmemb("InstMem.mem",mem);    
end
assign Inst={mem[address],mem[address+1],mem[address+2],mem[address+3]};
endmodule