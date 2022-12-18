module MIPS(input clk, rst);
wire Branch, jump, jr, RegDst, R31, WriteSrc, Regwrite, ALUsrc, MemRead, MemWrite, MemtoReg,Flush,eq;
wire [1:0]  DFasel, DFbsel;
wire [2:0] ALUcontrol;
wire [5:0]opc,func;
wire [4:0] Rs_lv2,Rt_lv2,WriteReg_lv3, WriteReg_lv4;
wire RegWrite_lv3,RegWrite_lv4;
DataPath dp (clk, rst, Branch, jump, jr, RegDst, R31, WriteSrc, Regwrite, ALUsrc, MemRead, MemWrite, MemtoReg, ALUcontrol, opc, func, DFasel, DFbsel,Flush, eq, Rs_lv2,Rt_lv2,WriteReg_lv3, WriteReg_lv4, RegWrite_lv3,RegWrite_lv4);
DataForward DF (Rs_lv2,Rt_lv2,RegWrite_lv3,WriteReg_lv3,RegWrite_lv4,WriteReg_lv4,DFasel,DFbsel);
ControllUnit cu (opc, func, clk, rst, Branch, jump, jr, RegDst, R31, WriteSrc, Regwrite, ALUsrc, MemRead, MemWrite, MemtoReg, ALUcontrol,Flush,eq);

endmodule