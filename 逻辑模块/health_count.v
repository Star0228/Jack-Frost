 `timescale 1ms / 10ns
module health_count(
    input clk,
    input [1:0]slim_damage,
    input reset,
    input [31:0]ipcnt,
    output reg [3:0]health
);
///the number of bk_for
initial begin
    health <= 4'd3;
end
reg wudi;
reg [7:0]num;
always@(posedge clk)begin
    if(ipcnt==6000000)begin
        num<=(num+1)%256;
        if(wudi==0)begin
            num<=0;
        end
    end
    if(reset)begin
        health<=4'd3;
    end
    if(slim_damage>0&&wudi==0)begin
        health<=health-4'd1;
        wudi<=1'b1;
    end
    if(num==64)begin
        wudi<=1'b0;
    end
end
endmodule
