module shl2_28(input [27:0] in_SHL2, output [27:0] outSHL2);
    assign outSHL2 = in_SHL2<<2;
endmodule

module shl2_32(input [31:0] in_SHL2, output [31:0] outSHL2);
    assign outSHL2 = in_SHL2<<2;
endmodule