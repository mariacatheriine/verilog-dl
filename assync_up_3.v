module up_counter_3bit(
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

endmodule

module tb_up_counter;

    reg clk;
    wire [2:0] Q;

    up_counter_3bit uut(clk, Q);

    initial begin
        clk = 0;

        #10 clk = 1;
        #10 clk = 0;
        #10 clk = 1;
        #10 clk = 0;
        #10 clk = 1;
        #10 clk = 0;
        #10 clk = 1;
        #10 clk = 0;
        #10 clk = 1;
        #10 clk = 0;
        #10 clk = 1;
        #10 clk = 0;
        #10 clk = 1;
        #10 clk = 0;
        #10 clk = 1;
        #10 clk = 0;

        #10 $finish;
    end

    initial
        $monitor("Time=%0t | CLK=%b | Q=%b",
                 $time, clk, Q);

endmodule

