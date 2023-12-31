module move_blue(
    input clk,
    input [3:0] wsad_down,
    input [9:0] current_x,
    input [8:0] current_y,
    input [1:0] collision_state,
    output ready,
    output reg[9:0] x_blue,
    output reg[8:0] y_blue,
    output reg[2:0] blue_state,
    output reset
);
    wire [9:0] x_temp;
    wire [8:0] y_temp;
    reg [8:0] vertical_speed, vertical_speed_temp;

    always @ (posedge clk) begin
        if(wsad_down[0] == 1'b1) begin
            vertical_speed = 9'd14;
        end
        if(wsad_down[1] == 1'b1) begin
            x_temp = current_x - 1'b1;
        end
        else if(wsad_down[3] == 1'b1) begin
            x_temp = current_x + 1'b1;
        end

        if(collision_state[0] == 1'b1) begin
            y_temp = current_y - 1'b1;
        end
        else begin
            y_temp = current_y + vertical_speed;
        end
    end
    
endmodule
