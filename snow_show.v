`timescale 1ms / 10ns
module snow_show(
    input clk,
    input [31:0]ipcnt,
    input [11:0]snow,
    output reg [11:0]vga_snow
    );
//3帧  1  5   13   1
wire [11:0]vga_snow_1;
wire [11:0]vga_snow_2;
wire [11:0]vga_snow_3;
snowf_1 snow_f1(.clka(clk),.addra(snow),.douta(vga_snow_1));
snowf_5 snow_f2(.clka(clk),.addra(snow),.douta(vga_snow_2));
snowf_13 snow_f3(.clka(clk),.addra(snow),.douta(vga_snow_3));
reg [3:0]ip_snow;
always @(posedge clk )begin
    if(ipcnt == 6000000)begin
        ip_snow <=ip_snow+1;
    end
    case(ip_snow)
        0:vga_snow <= vga_snow_1;
        4:vga_snow <= vga_snow_2;
        8:vga_snow <= vga_snow_3;
        15:begin
            vga_snow <= vga_snow_1;
            ip_snow <= 0;
        end
    endcase
end
endmodule
//使用的时候直接调用snow_show模块，输入
//snow_show snow_f1(.clk(clk),.ipcnt(ipcnt),.snow(snow[11:0]),.vga_snow(vga_snowf1));