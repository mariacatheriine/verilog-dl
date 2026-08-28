module basic_gates_dataflow(
    input A, B,
    output Y_AND,
    output Y_OR,
    output Y_NOT,
    output Y_NAND,
    output Y_NOR,
    output Y_XOR,
    output Y_XNOR
);

    assign Y_AND  = A & B;
    assign Y_OR   = A | B;
    assign Y_NOT  = ~A;
    assign Y_NAND = ~(A & B);
    assign Y_NOR  = ~(A | B);
    assign Y_XOR  = A ^ B;
    assign Y_XNOR = ~(A ^ B);

endmodule

module tb_dataflow;

    reg A, B;

    wire Y_AND;
    wire Y_OR;
    wire Y_NOT;
    wire Y_NAND;
    wire Y_NOR;
    wire Y_XOR;
    wire Y_XNOR;

    basic_gates_dataflow uut (
        A, B,
        Y_AND,
        Y_OR,
        Y_NOT,
        Y_NAND,
        Y_NOR,
        Y_XOR,
        Y_XNOR
    );

    initial begin

        $monitor("A=%b B=%b | AND=%b OR=%b NOT=%b NAND=%b NOR=%b XOR=%b XNOR=%b",
                 A, B, Y_AND, Y_OR, Y_NOT, Y_NAND, Y_NOR, Y_XOR, Y_XNOR);

        A = 0; B = 0;
        #10 A = 0; B = 1;
        #10 A = 1; B = 0;
        #10 A = 1; B = 1;

        #10 $finish;

    end

endmodule