module encoder4to2_logical(
    input D0, D1, D2, D3,
    output Y1, Y0
);

    assign Y1 = D2 | D3;
    assign Y0 = D1 | D3;

endmodule

module encoder4to2_conditional(
    input D0, D1, D2, D3,
    output Y1, Y0
);

    assign Y1 = D3 ? 1'b1 :
                D2 ? 1'b1 :
                1'b0;

    assign Y0 = D3 ? 1'b1 :
                D1 ? 1'b1 :
                1'b0;

endmodule

module tb_encoder;

    reg D0,D1,D2,D3;
    wire Y1,Y0;

    encoder4to2_logical uut(D0,D1,D2,D3,Y1,Y0);

    initial begin

        D0=1; D1=0; D2=0; D3=0;
        #10 D0=0; D1=1; D2=0; D3=0;
        #10 D0=0; D1=0; D2=1; D3=0;
        #10 D0=0; D1=0; D2=0; D3=1;

        #10 $finish;

    end

    initial
        $monitor("D3D2D1D0=%b%b%b%b | Y1Y0=%b%b",
                 D3,D2,D1,D0,Y1,Y0);

endmodule