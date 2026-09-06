module sequence_detector(
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [1:0] state;

    parameter S0 = 2'b00,
              S1 = 2'b01,
              S2 = 2'b10,
              S3 = 2'b11;

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next-state logic
    reg [1:0] next_state;

    always @(*) begin

        case (state)

            S0: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S2;
            end

            S2: begin
                if (x)
                    next_state = S3;
                else
                    next_state = S0;
            end

            S3: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S2;
            end

            default:
                next_state = S0;

        endcase
    end

    // Output logic
    always @(*) begin

        if ((state == S3) && (x == 1))
            z = 1;
        else
            z = 0;

    end

endmodule

module tb_sequence_detector;

    reg clk;
    reg reset;
    reg x;

    wire z;

    sequence_detector uut(
        clk,
        reset,
        x,
        z
    );

    initial begin

        clk = 0;
        reset = 1;
        x = 0;

        #10 reset = 0;

        // Input sequence: 1011011
        #10 x = 1;
        #10 x = 0;
        #10 x = 1;
        #10 x = 1;
        #10 x = 0;
        #10 x = 1;
        #10 x = 1;

        #10 $finish;

    end

    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t | CLK=%b | RESET=%b | Input=%b | State=%b | Output=%b",
                 $time, clk, reset, x, uut.state, z);
    end

endmodule