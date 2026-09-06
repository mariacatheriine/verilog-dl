// Half Subtractor

module half_subtractor(
    input A, B,
    output Difference, Borrow
);

    assign Difference = A ^ B;
    assign Borrow = ~A & B;

endmodule


// Full Subtractor

module full_subtractor(
    input A, B, Bin,
    output Difference, Borrow
);

    assign Difference = A ^ B ^ Bin;
    assign Borrow = (~A & B) | (~A & Bin) | (B & Bin);

endmodule
module tb_subtractors;

    reg A, B, Bin;
    wire HS_Difference, HS_Borrow;
    wire FS_Difference, FS_Borrow;

    half_subtractor HS(
        A, B,
        HS_Difference, HS_Borrow
    );

    full_subtractor FS(
        A, B, Bin,
        FS_Difference, FS_Borrow
    );

    initial begin

        A=0; B=0; Bin=0;
        #10 A=0; B=0; Bin=1;
        #10 A=0; B=1; Bin=0;
        #10 A=0; B=1; Bin=1;
        #10 A=1; B=0; Bin=0;
        #10 A=1; B=0; Bin=1;
        #10 A=1; B=1; Bin=0;
        #10 A=1; B=1; Bin=1;

        #10 $finish;

    end

    initial begin
        $monitor("A=%b B=%b Bin=%b | HS: Difference=%b Borrow=%b | FS: Difference=%b Borrow=%b",
                 A, B, Bin,
                 HS_Difference, HS_Borrow,
                 FS_Difference, FS_Borrow);
    end

endmodule
