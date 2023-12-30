module collision(
    input clk,
    input [9:0] x_blue, x_ground,
    input [8:0] y_blue, y_ground,
    output reg [1:0] is_Collision
);
initial begin
    is_Collision <= 2'b0;
end
always @(posedge clk) begin
    //the size of the blue block is 23*45
    //the size of the ground is 25*24
    //detect whether the blue block is touched by the ground
    if (x_blue+10'd23 > x_ground+10'd2&&x_blue+10'd23<x_ground+10'd26&& y_blue == y_ground-9'd45) begin
        is_Collision[0] <= 1;
    end 
    if((x_blue+10'd23 > x_ground+10'd2&&x_blue+10'd23<x_ground+10'd26&& y_blue == y_ground+9‘d24) begin
        is_Collision[1] <= 1;
    end
    if(x_blue+10'd23 == x_ground && y_blue + 10'd2 < y_ground+9‘d24 && y_blue + 9'd45> y_ground + 10'd2) begin
        is_Collision[2] <= 1;
    end
    if(x_blue == x_ground+10'd25 && y_blue + 10'd2 < y_ground+9‘d24 && y_blue + 9'd45> y_ground + 10'd2) begin
        is_Collision[3] <= 1;
    end
end
endmodule