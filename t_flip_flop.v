module t_ff(
    input T,
    input clk,
    output reg Q
);

    always @(posedge clk) begin
        if (T == 1)
            Q <= ~Q;
        else
            Q <= Q;
    end

endmodule

module tb_t_ff;

    reg T, clk;
    wire Q;

    t_ff uut(T, clk, Q);

    initial begin
        clk = 0;
        T = 0;

        #10 T = 1;
        #20 T = 0;
        #10 T = 1;

        #20 $finish;
    end

    always #5 clk = ~clk;

    initial
        $monitor("Time=%0t | CLK=%b T=%b Q=%b",
                 $time, clk, T, Q);

endmodule