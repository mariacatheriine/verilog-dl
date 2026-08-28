module basic_gates_behavioral(
    input A, B,
    output reg Y_AND,
    output reg Y_OR,
    output reg Y_NOT,
    output reg Y_NAND,
    output reg Y_NOR,
    output reg Y_XOR,
    output reg Y_XNOR
);

    always @(*) begin

        Y_AND  = A & B;
        Y_OR   = A | B;
        Y_NOT  = ~A;
        Y_NAND = ~(A & B);
        Y_NOR  = ~(A | B);
        Y_XOR  = A ^ B;
        Y_XNOR = ~(A ^ B);

    end

endmodule

module tb_behavioral;

    reg A, B;

    wire Y_AND;
    wire Y_OR;
    wire Y_NOT;
    wire Y_NAND;
    wire Y_NOR;
    wire Y_XOR;
    wire Y_XNOR;

    basic_gates_behavioral uut (
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