module sr_ff(
    input S,
    input R,
    input clk,
    output reg Q
);

    always @(posedge clk) begin
        case ({S,R})
            2'b00: Q <= Q;
            2'b01: Q <= 0;
            2'b10: Q <= 1;
            2'b11: Q <= 1'bx;
        endcase
    end

endmodule

module tb_sr_ff;

    reg S, R, clk;
    wire Q;

    sr_ff uut(S, R, clk, Q);

    initial begin
        clk = 0;

        S = 0; R = 0;
        #10 S = 1; R = 0;
        #10 S = 0; R = 1;
        #10 S = 0; R = 0;
        #10 S = 1; R = 1;

        #10 $finish;
    end

    always #5 clk = ~clk;

    initial
        $monitor("Time=%0t | CLK=%b S=%b R=%b Q=%b",
                 $time, clk, S, R, Q);

endmodule