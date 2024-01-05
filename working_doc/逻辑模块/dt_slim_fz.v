 `timescale 1ms / 10ns
module dt_slim_fz(
    input clk,
    input [9:0]x_blue,x_slim,
    input [8:0]y_blue,y_slim,
    input [31:0]ipcnt,
    output reg frozen
);
initial begin
    frozen <= 0;
end
reg [7:0]num;
always @(posedge clk) begin
    //the situation that the jack ice the slim
    if (ipcnt == 6000000) begin
        num <= (num+1)%256;
    end
    //reset
    if(frozen==0)begin
        num<=0;     
    end
    if (x_blue+10'd24 < x_slim+10'd62&&x_blue+10'd24 > x_slim && y_blue + 9'd41< y_slim+9'd2&&y_blue+9'd41 > y_slim-9'd2) begin
        frozen <= 1;
    //the situation that the jack ice the slim
    end
    if(num == 255)begin
        frozen <= 0;
        //long time ice
    end
end
endmodule
 

