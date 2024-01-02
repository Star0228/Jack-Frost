module move_blue(
    input clk,
    input [3:0] wsad_down,//wsad_down[0] = w, wsad_down[1] = a, wsad_down[2] = s, wsad_down[3] = d
    input [9:0] current_x,
    input [8:0] current_y,
    input [8:0] current_speed,
    input [3:0] collision_state,//collision_state[0] = up, collision_state[1] = down, collision_state[2] = right, collision_state[3] = left
    output reg[9:0] x_blue,
    output reg[8:0] y_blue,
    output reg[2:0] blue_state,
    output reg[8:0] vertical_speed
);
    parameter g = 9'd14;
    parameter max_speed = 9'd14;
    always @ (posedge clk) begin
        //update x_blue
        if (wsad_down[1] == 1'b1) begin
            blue_state[0] <= 1'b1;
            blue_state[2] <= 1'b1;
            if(collision_state[3] == 1'b1) begin
                x_blue <= current_x;
            end else begin
                x_blue <= current_x - 10'd1;
            end
        end else if (wsad_down[3] == 1'b1) begin
            blue_state[0] <= 1'b0;
            blue_state[2] <= 1'b1;
            if(collision_state[2] == 1'b1) begin
                x_blue <= current_x;
            end else begin
                x_blue <= current_x + 10'd1;
            end
        end else begin
            x_blue <= current_x;
            blue_state[2] <= 1'b0;
        end
        //update y_blue
        if(collision_state[1] == 1'b1) begin
            vertical_speed <= -g;
        end else if (wsad_down[0] == 1'b1 && collision_state[0] == 1'b1) begin
            vertical_speed <= max_speed;
        end else if(wsad_down[0] == 1'b0 && collision_state[0] == 1'b0 && vertical_speed <0) begin
            vertical_speed <= 0;
        end else begin
            vertical_speed <= vertical_speed - g;
        end
        if (collision_state[0] == 1'b1) begin
            blue_state[1] <= 1'b1;
        end else begin
            blue_state[1] <= 1'b0;
        end
        y_blue <= current_y - vertical_speed;
    end
    
endmodule
