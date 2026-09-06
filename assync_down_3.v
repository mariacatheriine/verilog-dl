module down_counter_3bit(
    input clk,
    output reg [2:0] Q
);

    initial
        Q = 3'b111;

    always @(negedge clk)
        Q[0] <= ~Q[0];

    always @(posedge Q[0])
        Q[1] <= ~Q[1];

    always @(posedge Q[1])
        Q[2] <= ~Q[2];

endmodule

module tb_down_counter;

    reg clk;
    wire [2:0] Q;

    down_counter_3bit uut(clk, Q);

    initial begin
        clk = 0;

        repeat(16) begin
            #10 clk = ~clk;
        end

        #10 $finish;
    end

    initial
        $monitor("Time=%0t | CLK=%b | Q=%b",
                 $time, clk, Q);

endmodule