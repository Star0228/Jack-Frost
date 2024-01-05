module score_count(
    input clk,
    input [14:0]snowf_get,
    output reg [3:0]score
);
///the number of snowflakes is 15,if needed ,it can be changed
integer i;
reg [3:0]tem;
always @(posedge clk) begin
    tem <= 4'd0;
    if(snowf_get[0])begin
        tem <= tem + 4'd1;
    end
    if(snowf_get[1])begin
        tem <= tem + 4'd1;
    end
    if(snowf_get[2])begin
        tem <= tem + 4'd1;
    end
    if(snowf_get[3])begin
        tem <= tem + 4'd1;
    end
    if(snowf_get[4])begin
        tem <= tem + 4'd1;
    end
    if(snowf_get[5])begin
        tem <= tem + 4'd1;
    end
    if(snowf_get[6])begin
        tem <= tem + 4'd1;
    end
    if(snowf_get[7])begin
        tem <= tem + 4'd1;
    end
    if(snowf_get[8])begin
        tem <= tem + 4'd1;
    end
    if(snowf_get[9])begin
        tem <= tem + 4'd1;
    end
    if(snowf_get[10])begin
        tem <= tem + 4'd1;
    end
    if(snowf_get[11])begin
        tem <= tem + 4'd1;
    end
    if(snowf_get[12])begin
        tem <= tem + 4'd1;
    end
    if(snowf_get[13])begin
        tem <= tem + 4'd1;
    end
    if(snowf_get[14])begin
        tem <= tem + 4'd1;
    end
    score[3:0] <= tem[3:0];
end
endmodule
