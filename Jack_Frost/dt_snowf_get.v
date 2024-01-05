module dt_snowf_get(
    input clk,
    input [9:0]x_blue,x_snowf,
    input [8:0]y_blue,y_snowf,
    input reset,
    output reg snowf_get
);  
initial begin
    snowf_get <= 0;
end
always @(posedge clk) begin
    if (reset) begin
        snowf_get <= 0;
    end
    if (x_blue+10'd23 > x_snowf+10'd10&&x_blue+10'd23<x_snowf+10'd14&&y_blue+9'd20>y_snowf+9'd13-9'd10&&y_blue+9'd20<y_snowf+9'd23+9'd10) begin
        snowf_get <= 1;
    end 
end
endmodule