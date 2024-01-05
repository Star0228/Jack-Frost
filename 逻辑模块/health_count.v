 `timescale 1ms / 10ns
module health_count(
    input clk,
    input [1:0]slim_damage,
    input reset,
    input ipcnt,
    output reg [3:0]health
);
///the number of bk_for
initial begin
    health <= 4'd8;
end
reg wudi;
reg [3:0]num;
always@(posedge clk)begin
    if(ipcnt==6000000)begin
        num<=(num+1)%16;
    end
    if(reset)begin
        health<=4'd8;
    end
    if(slim_damage&&!wudi)begin
        health<=health-4'd1;
        wudi<=1'b1;
        if(num==15)begin
            wudi<=1'b0;
        end
    end
end
endmodule
