module dt_slim_fz(
    input clk,
    input [9:0]x_blue,x_slim,
    input [8:0]y_blue,y_slim,
    output reg frozen
);
initial begin
    frozen <= 0;//62*36   47*41/43
end
always @(posedge clk) begin
    if (x_blue+10'd24 < x_slim+10'd62&&x_blue+10'd24 > x_slim && y_blue + 9'd41< y_slim+9'd2&&y_blue+9'd41 > y_slim-9'd2) begin
        frozen <= 1;
    end
    else begin
        frozen <= 0;
    end 
end
endmodule