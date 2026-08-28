module boolean_structural(
    input A, B, C,
    input W, X, Y, Z,
    output F,
    output F1
);

    // Complement signals
    wire nA, nB, nC;
    wire nX, nY;

    // Minterms for F = Σ(0,2,5,6)
    wire m0, m2, m5, m6;

    not (nA, A);
    not (nB, B);
    not (nC, C);

    // m0 = A'B'C'
    and (m0, nA, nB, nC);

    // m2 = A'BC'
    and (m2, nA, B, nC);

    // m5 = AB'C
    and (m5, A, nB, C);

    // m6 = ABC'
    and (m6, A, B, nC);

    // F = m0 + m2 + m5 + m6
    or (F, m0, m2, m5, m6);


    // F1 = (W + X' + Y)(X + Y')(X + Y' + Z)

    not (nX, X);
    not (nY, Y);

    wire p1, p2, p3;

    or (p1, W, nX, Y);
    or (p2, X, nY);
    or (p3, X, nY, Z);

    and (F1, p1, p2, p3);

endmodule

module boolean_dataflow(
    input A, B, C,
    input W, X, Y, Z,
    output F,
    output F1
);

    assign F = (~A & ~B & ~C) |
               (~A & B & ~C) |
               (A & ~B & C) |
               (A & B & ~C);

    assign F1 = (W | ~X | Y) &
                (X | ~Y) &
                (X | ~Y | Z);

endmodule

module boolean_behavioral(
    input A, B, C,
    input W, X, Y, Z,
    output reg F,
    output reg F1
);

    always @(*) begin

        F = (~A & ~B & ~C) |
            (~A & B & ~C) |
            (A & ~B & C) |
            (A & B & ~C);

        F1 = (W | ~X | Y) &
             (X | ~Y) &
             (X | ~Y | Z);

    end

endmodule

module tb_boolean;

    reg A, B, C;
    reg W, X, Y, Z;

    wire F, F1;

    boolean_dataflow uut (
        A, B, C,
        W, X, Y, Z,
        F, F1
    );

    initial begin

        $monitor("ABC=%b%b%b | F=%b || WXYZ=%b%b%b%b | F1=%b",
                 A, B, C, F, W, X, Y, Z, F1);

        // Test all combinations
        A=0; B=0; C=0;
        W=0; X=0; Y=0; Z=0;
        #10;

        A=0; B=0; C=1;
        W=0; X=0; Y=0; Z=1;
        #10;

        A=0; B=1; C=0;
        W=0; X=0; Y=1; Z=0;
        #10;

        A=0; B=1; C=1;
        W=0; X=0; Y=1; Z=1;
        #10;

        A=1; B=0; C=0;
        W=0; X=1; Y=0; Z=0;
        #10;

        A=1; B=0; C=1;
        W=0; X=1; Y=0; Z=1;
        #10;

        A=1; B=1; C=0;
        W=0; X=1; Y=1; Z=0;
        #10;

        A=1; B=1; C=1;
        W=0; X=1; Y=1; Z=1;
        #10;

        A=0; B=0; C=0;
        W=1; X=0; Y=0; Z=0;
        #10;

        A=0; B=0; C=1;
        W=1; X=0; Y=0; Z=1;
        #10;

        A=0; B=1; C=0;
        W=1; X=0; Y=1; Z=0;
        #10;

        A=0; B=1; C=1;
        W=1; X=0; Y=1; Z=1;
        #10;

        A=1; B=0; C=0;
        W=1; X=1; Y=0; Z=0;
        #10;

        A=1; B=0; C=1;
        W=1; X=1; Y=0; Z=1;
        #10;

        A=1; B=1; C=0;
        W=1; X=1; Y=1; Z=0;
        #10;

        A=1; B=1; C=1;
        W=1; X=1; Y=1; Z=1;
        #10;

        $finish;

    end

endmodule