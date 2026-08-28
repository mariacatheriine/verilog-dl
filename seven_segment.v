module seven_segment_logical(
    input A, B, C, D,
    output a, b, c, d, e, f, g
);

    assign a = A | C | (B & D) | (~B & ~D);
    assign b = ~B | (~C & ~D) | (C & D);
    assign c = ~C | D | B;
    assign d = A | (~B & ~D) | (~B & C) | (C & ~D) | (B & ~C & D);
    assign e = (~B & ~D) | (C & ~D);
    assign f = A | (~C & ~D) | (B & ~C) | (B & ~D);
    assign g = A | (~B & C) | (B & ~C) | (C & ~D);

endmodule

module seven_segment_conditional(
    input [3:0] bin,
    output [6:0] seg
);

    assign seg = (bin == 4'b0000) ? 7'b1111110 :
                 (bin == 4'b0001) ? 7'b0110000 :
                 (bin == 4'b0010) ? 7'b1101101 :
                 (bin == 4'b0011) ? 7'b1111001 :
                 (bin == 4'b0100) ? 7'b0110011 :
                 (bin == 4'b0101) ? 7'b1011011 :
                 (bin == 4'b0110) ? 7'b1011111 :
                 (bin == 4'b0111) ? 7'b1110000 :
                 (bin == 4'b1000) ? 7'b1111111 :
                 (bin == 4'b1001) ? 7'b1111011 :
                 7'b0000000;

endmodule

module tb_seven_segment;

    reg [3:0] bin;
    wire [6:0] seg;

    seven_segment_conditional uut(bin,seg);

    initial begin

        bin=4'b0000;
        #10 bin=4'b0001;
        #10 bin=4'b0010;
        #10 bin=4'b0011;
        #10 bin=4'b0100;
        #10 bin=4'b0101;
        #10 bin=4'b0110;
        #10 bin=4'b0111;
        #10 bin=4'b1000;
        #10 bin=4'b1001;

        #10 $finish;

    end

    initial
        $monitor("Input=%b | Segments=%b", bin,seg);

endmodule