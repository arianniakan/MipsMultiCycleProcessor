module DataForward(Rs_lv2,Rt_lv2,RegWrite_lv3,WriteReg_lv3,RegWrite_lv4,WriteReg_lv4,DFA,DFB);
input [4:0] Rs_lv2,Rt_lv2, WriteReg_lv3, WriteReg_lv4;
input RegWrite_lv3,RegWrite_lv4;
output reg [1:0] DFA,DFB;

always @(Rs_lv2,Rt_lv2,WriteReg_lv3,WriteReg_lv4,RegWrite_lv3,RegWrite_lv4)
begin
if(RegWrite_lv3==1'b1&&WriteReg_lv3==Rs_lv2&&WriteReg_lv3!=5'b00000)
	{DFA}=2'b10;
else if(RegWrite_lv4==1'b1&&WriteReg_lv4==Rs_lv2&&WriteReg_lv4!=5'b00000)
	{DFA}=2'b01;
	else
	{DFA}=2'b00;
if(RegWrite_lv3==1'b1&&WriteReg_lv3==Rt_lv2&&WriteReg_lv3!=5'b00000)
	{DFB}=2'b10;
else if(RegWrite_lv3==1'b1&&WriteReg_lv4==Rt_lv2&&WriteReg_lv4!=5'b00000)
	{DFB}=2'b01;
	else
	{DFB}=2'b00;
end

endmodule
