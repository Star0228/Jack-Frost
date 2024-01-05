 `timescale 1ms / 10ns
module dt_slim_fz(
    input clk,
    input [9:0]x_blue,x_slim,
    input [8:0]y_blue,y_slim,
    input ipcnt,
    output reg frozen
);
initial begin
    frozen <= 0;//62*36   47*41/43
end
reg [3:0]num;
always @(posedge clk) begin
    if (ipcnt == 6000000) begin
        num <= (num+1)%16;
    end
    if(frozen==0)begin
        num<=0;     
    end
    if (x_blue+10'd24 < x_slim+10'd62&&x_blue+10'd24 > x_slim && y_blue + 9'd41< y_slim+9'd2&&y_blue+9'd41 > y_slim-9'd2) begin
        frozen <= 1;
        
    end
    if(num == 15)begin
            frozen <= 0;
    end
end
endmodule
 

