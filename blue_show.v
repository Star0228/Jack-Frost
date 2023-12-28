`timescale 1ms / 10ns
module blue_show(
    input clk,
    input [31:0]ipcnt,
    input [11:0]blue,
    input bk_touched,
    output reg [11:0]vga_blue
    );
//只放三帧
wire [11:0]vga_blue_st_1,vga_blue_st_2,vga_blue_st_3,vga_blue_st_4;
blue_static_1 blue_st_1f(.clka(clk),.addra(blue_st),.douta(vga_blue_st_1));
blue_static_5 blue_st_2f(.clka(clk),.addra(blue_st),.douta(vga_blue_st_2));
blue_static_9 blue_st_3f(.clka(clk),.addra(blue_st),.douta(vga_blue_st_3));
blue_static_13 blue_st_4f(.clka(clk),.addra(blue_st),.douta(vga_blue_st_4));
//蓝色小人向右奔跑的图片像素值  1 5 9 13
wire [11:0]vga_blue_rwk_1,vga_blue_rwk_5,vga_blue_rwk_9,vga_blue_rwk_13;
blue_r_walk_1 blue_rwk_1f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_1));
blue_r_walk_5 blue_rwk_5f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_5));
blue_r_walk_9 blue_rwk_9f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_9));
blue_r_walk_13 blue_rwk_13f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_13));

reg [4:0]ip_blue;
always @(posedge clk )begin
    if(ipcnt == 6000000)begin
        ip_blue <=ip_blue+1;
    end
    case(ip_blue)
        0:vga_blue <= vga_blue_1;
        13:vga_blue <= vga_blue_2;
        31:begin
            vga_blue <= vga_blue_3;
             bk_tc_finish <= 1;
        end
    endcase
end
endmodule

