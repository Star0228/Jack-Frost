module clk_1ms(
    input wire clk,
    output reg clk_1ms 
);
    reg [31:0] cnt = 0;
    always @(posedge clk) begin
        if (cnt < 5000_000) begin
            cnt <= cnt + 1;
        end else begin
            clk_1ms <= ~clk_1ms;
            cnt <= 0;
        end
    end
endmodule