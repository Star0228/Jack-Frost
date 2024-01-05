module dt_slim_bk(
    input clk,
    input [9:0]x_blue,x_slim,
    input [8:0]y_blue,y_slim,
    input isfrozen,
    output reg broken
);
initial begin
    broken <= 0;
end
always @(posedge clk) begin
    if (!isfrozen && x_blue < x_slim+10'd55&&x_blue > x_slim-10'd55&& y_blue < y_slim+9'd38&&y_blue > y_slim-9'd38) begin
        broken <= 1;
    end
    else begin
        broken <= 0;
    end
    //the situation that the jack touch the slim
end


endmodule