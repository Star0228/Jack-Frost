module game_state(
    input clk,
    input [3:0]health,
    input [49:0]bk_touched,
    input reset,
    output reg[1:0] game_state
);
//gamestate  00->begin  01:ing  11->win  10->lose
always@(posedge clk)begin
    if(reset)begin
        game_state<=2'b00;
    end
    if(bk_touched==50'b11111111111111111111111111111111111111111111111111)begin
        game_state<=2'b11;
    end
    else if(health == 0) begin
        game_state<=2'b10;
    end
    else begin
        game_state<=2'b01;
    end
end


endmodule