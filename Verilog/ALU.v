module ALU(input [31:0] ina, inb, input [2:0] ALUcontrol, output zero, output [31:0] out);
assign zero = (out==0)? 1:0;

assign out = (ALUcontrol == 3'b000) ? (ina&inb):
             (ALUcontrol == 3'b001) ? (ina|inb):
             (ALUcontrol == 3'b010) ? (ina+inb):
             (ALUcontrol == 3'b011) ? (ina-inb):
             (ALUcontrol == 3'b111) ? (ina<inb):
             32'bz;
endmodule

