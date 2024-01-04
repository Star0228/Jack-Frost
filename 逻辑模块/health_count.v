 `timescale 1ms / 10ns
module health_count(
    input clk,
    input [1:0]slim_damage,
    output reg [3:0]health
);
///the number of bk_for
initial begin
    health <= 4'd8;
end
reg wudi;
always@(posedge clk)begin
    if(slim_damage&&!wudi)begin
        health<=health-4'd1;
        wudi<=1'b1;
        #300000000;
        wudi<=1'b0;
    end
end
endmodule
