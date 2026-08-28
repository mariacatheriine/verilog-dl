module boolean_structural(
    input A, B, C,
    output F,
    output F1
);

    wire nA, nB, nC;
    wire term1, term2;
    wire term3, term4, term5, term6;

    // F = AB + A'C
    not (nA, A);

    and (term1, A, B);
    and (term2, nA, C);

    or (F, term1, term2);

    // F1 = (A+B+C)(A+B'+C)(A'+B+C')(A'+B'+C')

    not (nB, B);
    not (nC, C);

    or (term3, A, B, C);
    or (term4, A, nB, C);
    or (term5, nA, B, nC);
    or (term6, nA, nB, nC);

    and (F1, term3, term4, term5, term6);

endmodule

module boolean_dataflow(
    input A, B, C,
    output F,
    output F1
);

    assign F  = (A & B) | (~A & C);

    assign F1 = (A | B | C) &
                (A | ~B | C) &
                (~A | B | ~C) &
                (~A | ~B | ~C);

endmodule

module boolean_behavioral(
    input A, B, C,
    output reg F,
    output reg F1
);

    always @(*) begin

        F = (A & B) | (~A & C);

        F1 = (A | B | C) &
             (A | ~B | C) &
             (~A | B | ~C) &
             (~A | ~B | ~C);

    end

endmodule

module tb_boolean_structural;

    reg A, B, C;
    wire F, F1;

    boolean_structural uut (
        A, B, C,
        F, F1
    );

    initial begin

        $monitor("A=%b B=%b C=%b | F=%b F1=%b",
                 A, B, C, F, F1);

        A = 0; B = 0; C = 0;
        #10 A = 0; B = 0; C = 1;
        #10 A = 0; B = 1; C = 0;
        #10 A = 0; B = 1; C = 1;
        #10 A = 1; B = 0; C = 0;
        #10 A = 1; B = 0; C = 1;
        #10 A = 1; B = 1; C = 0;
        #10 A = 1; B = 1; C = 1;

        #10 $finish;

    end

endmodule