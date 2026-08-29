module piso(
    input [3:0] parallel_in,
    input load,
    input clk,
    output serial_out
);

    reg [3:0] q;

    always @(posedge clk) begin
        if (load)
            q <= parallel_in;
        else begin
            q[0] <= q[1];
            q[1] <= q[2];
            q[2] <= q[3];
            q[3] <= 1'b0;
        end
    end

    assign serial_out = q[0];

endmodule

module tb_piso;

    reg [3:0] parallel_in;
    reg load;
    reg clk;
    wire serial_out;

    piso uut(parallel_in, load, clk, serial_out);

    initial begin
        clk = 0;
        load = 1;
        parallel_in = 4'b1011;

        #10 load = 0;
        #10;
        #10;
        #10;
        #10;

        #10 $finish;
    end

    always #5 clk = ~clk;

    initial
        $monitor("Time=%0t | Load=%b | Parallel_in=%b | Register=%b | Serial_out=%b",
                 $time, load, parallel_in, uut.q, serial_out);

endmodule