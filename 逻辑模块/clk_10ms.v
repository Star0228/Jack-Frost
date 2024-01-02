module clk_10ms(
    input wire clk,
    output reg clk_10ms = 0
);
    reg [31:0] cnt = 0;
    always @(posedge clk) begin
        if (cnt < 500_000) begin
            cnt <= cnt + 1;
        end else begin
            clk_10ms <= ~clk_10ms;
            cnt <= 0;
        end
    end
endmodule