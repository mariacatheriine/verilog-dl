module comparator_2bit(
    input [1:0] A,
    input [1:0] B,
    output A_greater,
    output A_equal,
    output A_less
);

    assign A_greater = (A[1] & ~B[1]) |
                       ((A[1] ~^ B[1]) & A[0] & ~B[0]);

    assign A_equal = (A[1] ~^ B[1]) &
                     (A[0] ~^ B[0]);

    assign A_less = (~A[1] & B[1]) |
                    ((A[1] ~^ B[1]) & ~A[0] & B[0]);

endmodule

module tb_comparator;

    reg [1:0] A, B;
    wire A_greater, A_equal, A_less;

    comparator_2bit uut(
        A, B,
        A_greater, A_equal, A_less
    );

    initial begin

        A=2'b00; B=2'b00;
        #10 A=2'b01; B=2'b00;
        #10 A=2'b00; B=2'b01;
        #10 A=2'b10; B=2'b10;
        #10 A=2'b11; B=2'b01;
        #10 A=2'b01; B=2'b11;

        #10 $finish;

    end

    initial
        $monitor("A=%b B=%b | A>B=%b A=B=%b A<B=%b",
                 A, B, A_greater, A_equal, A_less);

endmodule