module alu_cu (input [1:0] alu_op, input [5:0] func, output reg [2:0] ALUcontrol);
  
  always @(alu_op, func)
  begin
    ALUcontrol = 3'b100;
    if (alu_op == 2'b00)        // lw or sw
            ALUcontrol = 3'b010;
    else if (alu_op == 2'b01)   // beq
            ALUcontrol = 3'b011;
    else if (alu_op == 2'b11)   // slti
            ALUcontrol = 3'b111;
    else if (alu_op == 2'b10)    // R-type
      begin
        case (func)
          6'b000001: ALUcontrol = 3'b000;  // and
          6'b000010: ALUcontrol = 3'b001;  // or
          6'b000100: ALUcontrol = 3'b010;  // add
          6'b001000: ALUcontrol = 3'b011;  // sub
          6'b010000: ALUcontrol = 3'b111;  // slt
        default:   ALUcontrol = 3'b100;
        endcase
      end
        
  end
  
endmodule
