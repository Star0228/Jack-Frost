module collision(
    input clk,
    input [9:0] x_blue, x_ground,
    input [8:0] y_blue, y_ground,
    output reg [3:0] is_Collision
);
always @(posedge clk) begin
    //the size of the blue block is 47*41
    //the size of the ground is 25*24
    //detect whether the blue has collided with the block
    
    //the down side of the blue
    if(x_blue + 10'd20 >= x_ground && x_blue + 10'd26 <= x_ground+10'd25 && y_blue + 9'd41 >= y_ground && y_blue + 9'd41 <= y_ground + 9'd3) begin
        is_Collision[0] <= 1;
    end else begin
        is_Collision[0] <= 0;
    end
    //the up side of the blue
    if(x_blue + 10'd20 >= x_ground && x_blue + 10'd26 <= x_ground+10'd25 &&  y_blue >= y_ground+9'd24  && y_blue <= y_ground + 9'd30) begin
        is_Collision[1] <= 1;
    end else begin
        is_Collision[1] <= 0;
    end

    //the right side of the blue
    if(x_blue + 10'd45 >= x_ground-10'd3 && x_blue + 10'd45 <= x_ground+10'd3 && y_blue + 9'd41 <= y_ground+9'd24 && y_blue - 9'd30 >= y_ground ) begin
        is_Collision[2] <= 1;
    end else begin
        is_Collision[2] <= 0;
    end
    
    //the left side of the blue
    if(x_blue >= x_ground+10'd23 && x_blue <= x_ground+10'd28 && y_blue + 9'd41 <= y_ground+9'd24 && y_blue - 9'd30 >= y_ground ) begin
        is_Collision[3] <= 1;
    end else begin
        is_Collision[3] <= 0;
    end
end
endmodule
