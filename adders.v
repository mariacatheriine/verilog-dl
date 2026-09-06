// Half Adder

module half_adder(
    input A, B,
    output Sum, Carry
);

    assign Sum = A ^ B;
    assign Carry = A & B;

endmodule


// Full Adder

module full_adder(
    input A, B, Cin,
    output Sum, Carry
);

    assign Sum = A ^ B ^ Cin;
    assign Carry = (A & B) | (B & Cin) | (A & Cin);

endmodule

module tb_adders;

    reg A, B, Cin;
    wire HA_Sum, HA_Carry;
    wire FA_Sum, FA_Carry;

    half_adder HA(
        A, B,
        HA_Sum, HA_Carry
    );

    full_adder FA(
        A, B, Cin,
        FA_Sum, FA_Carry
    );

    initial begin

        A=0; B=0; Cin=0;
        #10 A=0; B=0; Cin=1;
        #10 A=0; B=1; Cin=0;
        #10 A=0; B=1; Cin=1;
        #10 A=1; B=0; Cin=0;
        #10 A=1; B=0; Cin=1;
        #10 A=1; B=1; Cin=0;
        #10 A=1; B=1; Cin=1;

        #10 $finish;

    end

    initial begin
        $monitor("A=%b B=%b Cin=%b | HA: Sum=%b Carry=%b | FA: Sum=%b Carry=%b",
                 A, B, Cin, HA_Sum, HA_Carry, FA_Sum, FA_Carry);
    end

endmodule