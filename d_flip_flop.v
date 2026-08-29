module d_ff(
    input D,
    input clk,
    output reg Q
);

    always @(posedge clk) begin
        Q <= D;
    end

endmodule

module tb_d_ff;

    reg D, clk;
    wire Q;

    d_ff uut(D, clk, Q);

    initial begin
        clk = 0;
        D = 0;

        #10 D = 1;
        #10 D = 0;
        #10 D = 1;
        #10 D = 1;

        #10 $finish;
    end

    always #5 clk = ~clk;

    initial
        $monitor("Time=%0t | CLK=%b D=%b Q=%b",
                 $time, clk, D, Q);

endmodule