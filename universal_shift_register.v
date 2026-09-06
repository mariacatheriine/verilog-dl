module universal_shift_register(
    input clk,
    input reset,
    input [1:0] mode,
    input serial_right,
    input serial_left,
    input [3:0] parallel_in,
    output reg [3:0] Q
);

    always @(posedge clk) begin

        if (reset)
            Q <= 4'b0000;

        else begin
            case (mode)

                2'b00: Q <= Q;                         // Hold

                2'b01: Q <= {serial_right, Q[3:1]};   // Shift right

                2'b10: Q <= {Q[2:0], serial_left};   // Shift left

                2'b11: Q <= parallel_in;             // Parallel load

            endcase
        end

    end

endmodule

module tb_universal_shift_register;

    reg clk;
    reg reset;
    reg [1:0] mode;
    reg serial_right;
    reg serial_left;
    reg [3:0] parallel_in;

    wire [3:0] Q;

    universal_shift_register uut(
        clk,
        reset,
        mode,
        serial_right,
        serial_left,
        parallel_in,
        Q
    );

    initial begin

        clk = 0;
        reset = 1;
        mode = 2'b00;
        serial_right = 0;
        serial_left = 0;
        parallel_in = 4'b0000;

        // Reset
        #10 reset = 0;

        // Parallel load: 1011
        mode = 2'b11;
        parallel_in = 4'b1011;
        #10;

        // Hold
        mode = 2'b00;
        #10;

        // Shift right
        mode = 2'b01;
        serial_right = 1;
        #10;
        serial_right = 0;
        #10;

        // Shift left
        mode = 2'b10;
        serial_left = 1;
        #10;
        serial_left = 0;
        #10;

        #10 $finish;

    end

    always #5 clk = ~clk;

    initial
        $monitor("Time=%0t | CLK=%b | Mode=%b | Parallel_in=%b | Q=%b",
                 $time, clk, mode, parallel_in, Q);

endmodule