module dt_block_fz(
    input clk,
    input [9:0]x_blue,x_ground,
    input [8:0]y_blue,y_ground,
    input reset,
    output reg touched
);  
initial begin
    touched <= 0;
end
always @(posedge clk) begin
    if(reset)begin
        touched <= 0;
    end
    if (x_blue+10'd23 > x_ground+10'd2&&x_blue+10'd23<x_ground+10'd26&& y_blue +9'd41> y_ground-9'd10&&y_blue+9'd41<y_ground+9'd10) begin
        touched <= 1;
    end 
end

endmodule