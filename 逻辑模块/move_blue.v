module move_blue(
    input clk,
    input ps2_clk,
    input ps2_data,
    input [9:0] current_x,
    input [8:0] current_y,
    input [1:0] collision_state,
    output ready,
    output reg[9:0] x_blue,
    output reg[8:0] y_blue,
    output reg[2:0] blue_state,
    output reset
);
    // Instantiate the PS2 Keyboard module
    wire [9:0] instruction;
    wire ready, overflow;
    wire [3:0] wsad_down;
    wire [9:0] x_temp;
    wire [8:0] y_temp;
    reg rdn;
    initial begin
        rdn = 1'b0;
    end
    ps2_keyboard keyboard (.clk(clk), .clrn(1'b1), .ps2_clk(ps2_clk), .ps2_data(ps2_data), .rdn(rdn), .data(instruction), .ready(ready), .overflow(overflow), .wsad_down(wsad_down));
    always @ (posedge clk) begin
        if(wsad_down[0] == 1'b1) begin
            y_temp = current_y + 1'b1;
        end
        else if(wsad_down[2] == 1'b1) begin
            y_temp = current_y - 1'b1;
        end
        else begin
            y_temp = current_y;
        end
        if(wsad_down[1] == 1'b1) begin
            x_temp = current_x - 1'b1;
        end
        else if(wsad_down[3] == 1'b1) begin
            x_temp = current_x + 1'b1;
        end
        else begin
            x_temp = current_x;
        end
    end
    
endmodule
