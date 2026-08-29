module siso(
    input serial_in,
    input clk,
    output serial_out
);

    reg [3:0] q;

    always @(posedge clk) begin
        q[0] <= serial_in;
        q[1] <= q[0];
        q[2] <= q[1];
        q[3] <= q[2];
    end

    assign serial_out = q[3];

endmodule

module tb_siso;

    reg serial_in;
    reg clk;
    wire serial_out;

    siso uut(serial_in, clk, serial_out);

    initial begin
        clk = 0;
        serial_in = 0;

        #10 serial_in = 1;
        #10 serial_in = 0;
        #10 serial_in = 1;
        #10 serial_in = 1;
        #10 serial_in = 0;
        #10 serial_in = 0;

        #10 $finish;
    end

    always #5 clk = ~clk;

    initial
        $monitor("Time=%0t | CLK=%b | Serial_in=%b | Register=%b | Serial_out=%b",
                 $time, clk, serial_in, uut.q, serial_out);

endmodule