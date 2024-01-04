module clk_10000(
    input wire clk,
    output reg clk_10000,
);
    reg [31:0] cnt = 0;
    always @(posedge clk) begin
        if (cnt < 5000) begin
            cnt <= cnt + 1;
        end else begin
            clk_10000 <= ~clk_10000;
            cnt <= 0;
        end
    end
endmodule