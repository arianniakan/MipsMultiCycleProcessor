module DataPath(input clk, rst, Branch, jump, jr, RegDst, R31, WriteSrc, Regwrite, ALUsrc, MemRead, MemWrite, MemtoReg, input[2:0] ALUcontrol, output[5:0] opc, func, input[1:0] DFasel, DFbsel, input Flush, output Zero, output [4:0] Rs_lv2,Rt_lv2,OWriteReg_lv3, OWriteReg_lv4, output ORegWrite_lv3,ORegWrite_lv4);

reg  [31:0] PC=32'b0;
wire [31:0] nPC;
wire [31:0] PCp4;
wire [31:0] PCb;
wire [31:0] instruction;

wire [27:0] Inst28;
wire [27:0] Adr28;

wire [4:0]regread1,regread2,WriteReg;
wire [31:0]regWriteData, regReadData1, regReadData2;

wire [31:0] aluinb;
wire [31:0] aluout;
wire [31:0] seInst;
wire [31:0] seInstsl2;
wire zerof;
wire [31:0] MemReadData;


wire [31:0] DF2a, DF2b;

//pipeline wire of lv1
wire [31:0] WPCp4_lv1;
wire [31:0] Winstruction_lv1;

//pipeline wire of lv2
    wire [31:0] WPCp4_lv2;
    wire [31:0] WregReadData1_lv2, WregReadData2_lv2;
    wire [31:0] WseInsts_lv2;
    wire [31:0] Winstruction_lv2;
    //EX
        wire WALUsrc_lv2;
        wire [2:0] WALUcontrol_lv2;
        wire WRegDstlv_2;
        wire WR31_lv2;
    //M 
        wire WMemRead_lv2, WMemWrite_lv2;
    //WB
        wire WMemtoReg_lv2, WWriteSrc_lv2; 
        wire WRegwrite_lv2;

//pipeline wire of lv3
    wire [31:0] WPCp4_lv3;
    wire [31:0] Waluout_lv3;
    wire [31:0] WDF2b_lv3;
    wire [4:0] WWriteReg_lv3;
    //M 
    wire WMemRead_lv3, WMemWrite_lv3;
    //WB
        wire WMemtoReg_lv3, WWriteSrc_lv3; 
        wire WRegwrite_lv3;


//pipeline wire of lv4
    wire [31:0] WPCp4_lv4;
    wire [31:0] WMemReadData_lv4;
    wire [31:0] Waluout_lv4;
    wire [4:0] WWriteReg_lv4;
    //WB
        wire WMemtoReg_lv4, WWriteSrc_lv4; 
        wire WRegwrite_lv4;

//pipeline registers of lv1
    REG #32 PCp4_lv1 (clk, PCp4, WPCp4_lv1,Flush);
    REG #32 instruction_lv1(clk, instruction, Winstruction_lv1,Flush);

//pipeline registers of lv2
    REG #32 PCp4_lv2(clk, WPCp4_lv1, WPCp4_lv2,1'b0);
    REG #32 regReadData1_lv2(clk,regReadData1, WregReadData1_lv2,1'b0);
    REG #32 regReadData2_lv2(clk,regReadData2, WregReadData2_lv2,1'b0);
    REG #32 seInstsl2_lv2(clk,seInst,WseInsts_lv2,1'b0);
    REG #32 instruction_lv2(clk,Winstruction_lv1,Winstruction_lv2,1'b0);
    //EX
        REG #1 ALUsrc_lv2 (clk, ALUsrc, WALUsrc_lv2,1'b0);
        REG #3 ALUcontrol_lv2(clk, ALUcontrol, WALUcontrol_lv2,1'b0);
        REG #1 RegDstlv_2(clk, RegDst,WRegDstlv_2,1'b0);
        REG #1 R31_lv2(clk, R31, WR31_lv2,1'b0);
    //M 
        REG #1 MemRead_lv2 (clk, MemRead, WMemRead_lv2,1'b0);
        REG #1 MemWrite_lv2 (clk, MemWrite, WMemWrite_lv2,1'b0);
    //WB
        REG #1 MemtoReg_lv2 (clk, MemtoReg, WMemtoReg_lv2,1'b0);
        REG #1 WriteSrc_lv2 (clk, WriteSrc, WWriteSrc_lv2,1'b0); 
        REG #1 Regwrite_lv2 (clk, Regwrite, WRegwrite_lv2,1'b0 );

//pipeline registers of lv3
REG #32 PCp4_lv3(clk, WPCp4_lv2,WPCp4_lv3,1'b0);
REG #32 aluout_lv3(clk,aluout,Waluout_lv3,1'b0);
REG #32 DF2b_lv3(clk,DF2b ,WDF2b_lv3,1'b0);
REG #5 WriteReg_lv3(clk,WriteReg,WWriteReg_lv3,1'b0);
    //M 
        REG #1 MemRead_lv3 (clk, WMemRead_lv2, WMemRead_lv3,1'b0);
        REG #1 MemWrite_lv3 (clk, WMemWrite_lv2, WMemWrite_lv3,1'b0);
    //WB
        REG #1 MemtoReg_lv3 (clk, WMemtoReg_lv2, WMemtoReg_lv3,1'b0);
        REG #1 WriteSrc_lv3 (clk, WWriteSrc_lv2, WWriteSrc_lv3,1'b0); 
        REG #1 Regwrite_lv3 (clk, WRegwrite_lv2, WRegwrite_lv3,1'b0);

//pipeline registers of lv4
REG #32 PCp4_lv4(clk, WPCp4_lv3,WPCp4_lv4,1'b0);
REG #32 MemReadData_lv4(clk,MemReadData,WMemReadData_lv4,1'b0);
REG #32 aluout_lv4(clk,Waluout_lv3,Waluout_lv4,1'b0);
REG #5 WriteReg_lv4(clk,WWriteReg_lv3,WWriteReg_lv4,1'b0);
    //WB
        REG #1 MemtoReg_lv4 (clk, WMemtoReg_lv3, WMemtoReg_lv4,1'b0);
        REG #1 WriteSrc_lv4 (clk, WWriteSrc_lv3, WWriteSrc_lv4,1'b0); 
        REG #1 Regwrite_lv4 (clk, WRegwrite_lv3, WRegwrite_lv4,1'b0);

always @(posedge clk) begin
    if(rst) PC<=32'b0;
    else PC<=nPC;
end
InstMem inst_mem (clk, PC, instruction);
RegisterFile register_file (clk, rst, WRegwrite_lv4, regread1, regread2, WWriteReg_lv4, regWriteData, regReadData1, regReadData2);
ALU alu (DF2a, aluinb, WALUcontrol_lv2, zerof, aluout);
SE16to32 se1 (Winstruction_lv1[15:0], seInst);
SE26to28 se2 (Winstruction_lv1[25:0], Inst28);

DataMem data_mem (clk, WMemRead_lv3, WMemWrite_lv3, Waluout_lv3, WDF2b_lv3, MemReadData);

adder a1 (32'd4, PC, PCp4);
adder a2 (WPCp4_lv1, seInstsl2,PCb);

shl2_32 shl1(seInst,seInstsl2);

shl2_28 shl2(Inst28, Adr28);

//assign statements of RegFile
assign regread1 = Winstruction_lv1[25:21];
assign regread2 = Winstruction_lv1[20:16];
assign WriteReg = WR31_lv2?5'd31:
               WRegDstlv_2? Winstruction_lv2[15:11]:Winstruction_lv2[20:16];
assign regWriteData = WWriteSrc_lv4?WPCp4_lv4:
                      WMemtoReg_lv4?WMemReadData_lv4:Waluout_lv4;
//assign statements of Alu
assign DF2a = DFasel==2'b00 ? WregReadData1_lv2:
              DFasel==2'b01 ? Waluout_lv3:
              DFasel==2'b10 ? regWriteData:
              32'b0;
assign DF2b = DFbsel==2'b00 ? WregReadData2_lv2:
              DFbsel==2'b01 ? Waluout_lv3:
              DFbsel==2'b10 ? regWriteData:
              32'b0;
assign aluinb = WALUsrc_lv2?WseInsts_lv2:DF2b;

assign Zero = (regReadData1==regReadData2);

//assign statments of next PC
assign nPC = jr?regReadData1:
             jump? {WPCp4_lv1[31:28],Adr28}:
             (Branch&Zero)? PCb:PCp4;
        
assign opc = Winstruction_lv1[31:26];
assign func = Winstruction_lv1[5:0];
//assign DF outputs
assign  Rs_lv2 = Winstruction_lv2[25:21];
assign Rt_lv2 = Winstruction_lv2[20:16];
assign OWriteReg_lv3 = WWriteReg_lv3;
assign OWriteReg_lv4 = WWriteReg_lv4;
assign ORegWrite_lv3 = WRegwrite_lv3;
assign ORegWrite_lv4 = WRegwrite_lv4;
endmodule