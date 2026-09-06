module priority_encoder_3bit(
    input D2,
    input D1,
    input D0,
    output [1:0] Y
);

    assign Y[1] = D2;
    assign Y[0] = ~D2 & D1;

endmodule

module tb_priority_encoder;

    reg D2, D1, D0;
    wire [1:0] Y;

    priority_encoder_3bit uut(
        D2, D1, D0,
        Y
    );

    initial begin

        D2=0; D1=0; D0=0;
        #10 D2=0; D1=0; D0=1;
        #10 D2=0; D1=1; D0=0;
        #10 D2=0; D1=1; D0=1;
        #10 D2=1; D1=0; D0=0;
        #10 D2=1; D1=0; D0=1;
        #10 D2=1; D1=1; D0=0;
        #10 D2=1; D1=1; D0=1;

        #10 $finish;

    end

    initial
        $monitor("D2=%b D1=%b D0=%b | Y=%b",
                 D2, D1, D0, Y);

endmodule