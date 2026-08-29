module sipo(
    input serial_in,
    input clk,
    output [3:0] parallel_out
);

    reg [3:0] q;

    always @(posedge clk) begin
        q[0] <= serial_in;
        q[1] <= q[0];
        q[2] <= q[1];
        q[3] <= q[2];
    end

    assign parallel_out = q;

endmodule

module tb_sipo;

    reg serial_in;
    reg clk;
    wire [3:0] parallel_out;

    sipo uut(serial_in, clk, parallel_out);

    initial begin
        clk = 0;
        serial_in = 0;

        #10 serial_in = 1;
        #10 serial_in = 0;
        #10 serial_in = 1;
        #10 serial_in = 1;

        #10 serial_in = 0;
        #10 $finish;
    end

    always #5 clk = ~clk;

    initial
        $monitor("Time=%0t | Serial_in=%b | Parallel_out=%b",
                 $time, serial_in, parallel_out);

endmodule