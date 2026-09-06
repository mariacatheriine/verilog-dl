module bidirectional_shift_register(
    input clk,
    input reset,
    input dir,
    input serial_in,
    output reg [3:0] Q
);

    always @(posedge clk) begin

        if (reset)
            Q <= 4'b0000;

        else if (dir)
            Q <= {serial_in, Q[3:1]};   // Shift right

        else
            Q <= {Q[2:0], serial_in};   // Shift left

    end

endmodule

module tb_bidirectional_shift_register;

    reg clk;
    reg reset;
    reg dir;
    reg serial_in;

    wire [3:0] Q;

    bidirectional_shift_register uut(
        clk,
        reset,
        dir,
        serial_in,
        Q
    );

    initial begin

        clk = 0;
        reset = 1;
        dir = 1;
        serial_in = 0;

        #10 reset = 0;

        // Shift right
        dir = 1;
        serial_in = 1;
        #10 serial_in = 0;
        #10 serial_in = 1;
        #10 serial_in = 1;

        // Shift left
        dir = 0;
        serial_in = 0;
        #10 serial_in = 1;
        #10 serial_in = 0;
        #10 serial_in = 1;

        #10 $finish;

    end

    always #5 clk = ~clk;

    initial
        $monitor("Time=%0t | CLK=%b | DIR=%b | Serial_in=%b | Q=%b",
                 $time, clk, dir, serial_in, Q);

endmodule