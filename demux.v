module demux1to4_logical(
    input D,
    input S1, S0,
    output Y0, Y1, Y2, Y3
);

    assign Y0 = D & ~S1 & ~S0;
    assign Y1 = D & ~S1 &  S0;
    assign Y2 = D &  S1 & ~S0;
    assign Y3 = D &  S1 &  S0;

endmodule

module demux1to4_conditional(
    input D,
    input S1, S0,
    output Y0, Y1, Y2, Y3
);

    assign Y0 = (!S1 && !S0) ? D : 1'b0;
    assign Y1 = (!S1 &&  S0) ? D : 1'b0;
    assign Y2 = ( S1 && !S0) ? D : 1'b0;
    assign Y3 = ( S1 &&  S0) ? D : 1'b0;

endmodule

module tb_demux;

    reg D;
    reg S1, S0;
    wire Y0,Y1,Y2,Y3;

    demux1to4_logical uut(D,S1,S0,Y0,Y1,Y2,Y3);

    initial begin

        D=1;

        S1=0; S0=0;
        #10 S1=0; S0=1;
        #10 S1=1; S0=0;
        #10 S1=1; S0=1;

        #10 $finish;

    end

    initial
        $monitor("S1=%b S0=%b | Y0=%b Y1=%b Y2=%b Y3=%b",
                 S1,S0,Y0,Y1,Y2,Y3);

endmodule