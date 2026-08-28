module decoder2to4_logical(
    input A, B,
    output Y0, Y1, Y2, Y3
);

    assign Y0 = ~A & ~B;
    assign Y1 = ~A & B;
    assign Y2 = A & ~B;
    assign Y3 = A & B;

endmodule

module decoder2to4_conditional(
    input A, B,
    output Y0, Y1, Y2, Y3
);

    assign Y0 = (!A && !B) ? 1'b1 : 1'b0;
    assign Y1 = (!A &&  B) ? 1'b1 : 1'b0;
    assign Y2 = ( A && !B) ? 1'b1 : 1'b0;
    assign Y3 = ( A &&  B) ? 1'b1 : 1'b0;

endmodule

module tb_decoder;

    reg A,B;
    wire Y0,Y1,Y2,Y3;

    decoder2to4_logical uut(A,B,Y0,Y1,Y2,Y3);

    initial begin

        A=0; B=0;
        #10 A=0; B=1;
        #10 A=1; B=0;
        #10 A=1; B=1;

        #10 $finish;

    end

    initial
        $monitor("AB=%b%b | Y0=%b Y1=%b Y2=%b Y3=%b",
                 A,B,Y0,Y1,Y2,Y3);

endmodule