module mux4to1_logical(
    input I0, I1, I2, I3,
    input S1, S0,
    output Y
);

    assign Y = (~S1 & ~S0 & I0) |
               (~S1 &  S0 & I1) |
               ( S1 & ~S0 & I2) |
               ( S1 &  S0 & I3);

endmodule

module mux4to1_conditional(
    input I0, I1, I2, I3,
    input S1, S0,
    output Y
);

    assign Y = S1 ? (S0 ? I3 : I2) :
                     (S0 ? I1 : I0);

endmodule

module tb_mux;

    reg I0, I1, I2, I3;
    reg S1, S0;
    wire Y;

    mux4to1_logical uut(I0,I1,I2,I3,S1,S0,Y);

    initial begin

        I0=0; I1=1; I2=0; I3=1;

        S1=0; S0=0;
        #10 S1=0; S0=1;
        #10 S1=1; S0=0;
        #10 S1=1; S0=1;

        #10 $finish;

    end

    initial
        $monitor("S1=%b S0=%b | Y=%b", S1,S0,Y);

endmodule