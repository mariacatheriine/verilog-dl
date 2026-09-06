module sequence_generator(
    input clk,
    input reset,
    output reg [2:0] Q
);

    always @(posedge clk) begin
        if (reset)
            Q <= 3'b001;
        else begin
            Q[2] <= Q[1];
            Q[1] <= Q[0];
            Q[0] <= Q[2];
        end
    end

endmodule

module tb_sequence_generator;

    reg clk;
    reg reset;
    wire [2:0] Q;

    sequence_generator uut(clk, reset, Q);

    initial begin
        clk = 0;
        reset = 1;

        #10 reset = 0;

        #60 $finish;
    end

    always #5 clk = ~clk;

    initial
        $monitor("Time=%0t | CLK=%b | RESET=%b | Q=%b",
                 $time, clk, reset, Q);

endmodule