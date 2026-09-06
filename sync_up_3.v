module sync_up_counter(
    input clk,
    output reg [2:0] Q
);

    always @(posedge clk) begin
        Q[0] <= ~Q[0];

        if (Q[0])
            Q[1] <= ~Q[1];

        if (Q[0] && Q[1])
            Q[2] <= ~Q[2];
    end

endmodule

module tb_sync_up_counter;

    reg clk;
    wire [2:0] Q;

    sync_up_counter uut(clk, Q);

    initial begin
        clk = 0;

        repeat(16)
            #5 clk = ~clk;

        #10 $finish;
    end

    initial
        $monitor("Time=%0t | CLK=%b | Q=%b",
                 $time, clk, Q);

endmodule