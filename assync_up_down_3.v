module up_down_counter_3bit(
    input clk,
    input mode,
    output reg [2:0] Q
);

    initial
        Q = 3'b000;

    always @(negedge clk)
        Q[0] <= ~Q[0];

    always @(negedge Q[0])
        if (mode)
            Q[1] <= ~Q[1];

    always @(posedge Q[0])
        if (!mode)
            Q[1] <= ~Q[1];

    always @(negedge Q[1])
        if (mode)
            Q[2] <= ~Q[2];

    always @(posedge Q[1])
        if (!mode)
            Q[2] <= ~Q[2];

endmodule

module tb_up_down_counter;

    reg clk;
    reg mode;
    wire [2:0] Q;

    up_down_counter_3bit uut(clk, mode, Q);

    initial begin
        clk = 0;
        mode = 1;       // UP

        #80 mode = 0;   // DOWN

        #80 $finish;
    end

    always #5 clk = ~clk;

    initial
        $monitor("Time=%0t | CLK=%b | MODE=%b | Q=%b",
                 $time, clk, mode, Q);

endmodule