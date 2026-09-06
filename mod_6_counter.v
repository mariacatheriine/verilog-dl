module mod6_counter(
    input clk,
    output reg [2:0] Q
);

    initial
        Q = 3'b000;

    always @(negedge clk)
        Q[0] <= ~Q[0];

    always @(negedge Q[0])
        Q[1] <= ~Q[1];

    always @(negedge Q[1])
        Q[2] <= ~Q[2];

    // Reset when count reaches 6 (110)
    always @(Q) begin
        if (Q == 3'b110)
            Q <= 3'b000;
    end

endmodule

module tb_mod6_counter;

    reg clk;
    wire [2:0] Q;

    mod6_counter uut(clk, Q);

    initial begin
        clk = 0;

        repeat(20) begin
            #10 clk = ~clk;
        end

        #10 $finish;
    end

    initial
        $monitor("Time=%0t | CLK=%b | Q=%b",
                 $time, clk, Q);

endmodule