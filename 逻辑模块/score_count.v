module score_count(
    input clk,
    input [14:0]snowf_get,
    output reg [3:0]score
);
///the number of snowflakes is 15,if needed ,it can be changed
integer i;
always @(posedge clk) begin
    score<= 0;  // 初始的"1"的数量是0
    for (i = 0; i < 15; i = i+1) begin
        // 如果寄存器的某个位是"1"，那么我们增加一比特
        if (snowf_get[i]) begin
            score <= score + 4'd1;
        end
    end
end
endmodule
