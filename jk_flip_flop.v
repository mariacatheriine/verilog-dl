module jk_ff(
    input J,
    input K,
    input clk,
    output reg Q
);

    always @(posedge clk) begin
        case ({J,K})
            2'b00: Q <= Q;
            2'b01: Q <= 0;
            2'b10: Q <= 1;
            2'b11: Q <= ~Q;
        endcase
    end

endmodule

module tb_jk_ff;

    reg J, K, clk;
    wire Q;

    jk_ff uut(J, K, clk, Q);

    initial begin
        clk = 0;

        J = 0; K = 0;
        #10 J = 0; K = 1;
        #10 J = 1; K = 0;
        #10 J = 1; K = 1;
        #10 J = 1; K = 1;
        #10 J = 0; K = 0;

        #10 $finish;
    end

    always #5 clk = ~clk;

    initial
        $monitor("Time=%0t | CLK=%b J=%b K=%b Q=%b",
                 $time, clk, J, K, Q);

endmodule