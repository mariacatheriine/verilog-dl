module pipo(
    input [3:0] parallel_in,
    input clk,
    output [3:0] parallel_out
);

    reg [3:0] q;

    always @(posedge clk) begin
        q <= parallel_in;
    end

    assign parallel_out = q;

endmodule

module tb_pipo;

    reg [3:0] parallel_in;
    reg clk;
    wire [3:0] parallel_out;

    pipo uut(parallel_in, clk, parallel_out);

    initial begin
        clk = 0;

        parallel_in = 4'b1010;
        #10 parallel_in = 4'b1100;
        #10 parallel_in = 4'b0110;
        #10 parallel_in = 4'b1111;

        #10 $finish;
    end

    always #5 clk = ~clk;

    initial
        $monitor("Time=%0t | Parallel_in=%b | Parallel_out=%b",
                 $time, parallel_in, parallel_out);

endmodule