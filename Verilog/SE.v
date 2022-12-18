module SE16to32(input [15:0] in, output [31:0] out);
    assign out = $signed(in);
endmodule

module SE26to28(input [25:0] in, output [27:0] out);
    assign out = $signed(in);
endmodule

