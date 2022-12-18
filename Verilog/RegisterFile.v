module RegisterFile(input clk, rst, Regwrite, input[4:0]read1, read2, WriteReg, input [31:0] WriteData, output[31:0] ReadData1,ReadData2);
reg [31:0] Registers[0:31];

assign ReadData1 = (read1==5'b0) ? 32'b0 : Registers[read1];
assign ReadData2 = (read2==5'b0) ? 32'b0 : Registers[read2];

integer i;
always @(posedge clk) begin
    if (rst) 
        for (i=0;i<32;i=i+1)
            Registers[i]<=32'b0;
    else if (Regwrite)
             if (WriteReg!=5'b0)
                 Registers[WriteReg]<=WriteData;

end

endmodule
