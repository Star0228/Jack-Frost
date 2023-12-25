`timescale 1ms / 10ns
module top(
    input clk,
    input rstn,
    //input ps2_clk,ps2_data,
    // output SEGLED_Clk,
    // output SEGLED_CLR,
    // output SEGLED_DO,
    // output SEGLED_PEN,
    output [3:0] r,g,b,
    output hs,vs
);
//photo's size 551*401
reg [11:0]vga_data;
wire [9:0]col_addr_x;
wire [8:0]row_addr_y;
wire clk_total;
reg isFinish;
reg [31:0]score;
initial begin
    isFinish=0;
    score=32'b0;
end
reg [31:0] clkdiv;
always@(posedge clk)begin
	clkdiv <= clkdiv+1'b1;
end
wire [31:0]clk_240ms;
clk_240ms clkm1(.clk(clk),.clk_240ms(clk_240ms));

vgac v1(.vga_clk(clkdiv[1]),.clrn(1'b1),.d_in(vga_data),.row_addr(row_addr_y),.col_addr(col_addr_x),.hs(hs),.vs(vs),.r(r),.g(g),.b(b));
//坐标赋值
//蓝色小人坐标
reg [9:0]x_blue;
reg [8:0]y_blue;
initial begin
    x_blue=10'd0;
    y_blue=9'd0;
end
//怪物1坐标
reg [9:0]x_slim1;
reg [8:0]y_slim1;
initial begin
    x_slim1=10'd48;
    y_slim1=9'd0;
end
//怪物2坐标
reg [9:0]x_slim2;
reg [8:0]y_slim2;
initial begin
    x_slim1=10'd96;
    y_slim1=9'd0;
end
//雪花1坐标
reg [9:0] x_snowf1,x_snowf2,x_snowf3,x_snowf4,x_snowf5,x_snowf6,x_snowf7,x_snowf8,x_snowf9,x_snowf10,x_snowf11,x_snowf12,x_snowf13,x_snowf14,x_snowf15;
reg [8:0] y_snowf1,y_snowf2,y_snowf3,y_snowf4,y_snowf5,y_snowf6,y_snowf7,y_snowf8,y_snowf9,y_snowf10,y_snowf11,y_snowf12,y_snowf13,y_snowf14,y_snowf15;
initial begin
    x_snowf1=x_snowf2=x_snowf3=x_snowf4=x_snowf5=x_snowf6=x_snowf7=x_snowf8=x_snowf9=x_snowf10=x_snowf11=x_snowf12=x_snowf13=x_snowf14=x_snowf15=10'd144;
    y_snowf1=9'd0;
    y_snowf2=9'd26;
    y_snowf3=9'd52;
    y_snowf4=9'd78;
    y_snowf5=9'd104;
    y_snowf6=9'd130;
    y_snowf7=9'd156;
    y_snowf8=9'd182;
    y_snowf9=9'd208;
    y_snowf10=9'd234;
    y_snowf11=9'd260;
    y_snowf12=9'd286;
    y_snowf13=9'd312;
    y_snowf14=9'd338;
    y_snowf15=9'd364;
end



reg [18:0] bg;
wire [11:0] vga_bg; 
reg [13:0]blue_st;
reg [11:0]vga_blue_st;
reg [13:0]blue_rwk;
reg [11:0]vga_blue_rwk;
reg [11:0]vga_slim1_st;
reg [13:0]slim1_st;
reg [11:0]vga_slim2_st;
reg [13:0]slim2_st;
reg [11:0]vga_snowf1,vga_snowf_3,vga_snowf_5,vga_snowf_7,vga_snowf_9,vga_snowf11,vga_snowf13,vga_snowf15;
reg [10:0]snowf1,snowf2,snowf3,snowf4,snowf5,snowf6,snowf7,snowf8,snowf9,snowf10,snowf11,snowf12,snowf13,snowf14,snowf15;

//给照片地址赋值(判断框里面是即将显示的范围，尺寸是551*401，就填550+400，？后面的值是coe文件的像素点的地址0-size-1)
always @(posedge clk)begin
    //背景551*401
    bg<= (col_addr_x>=0&&col_addr_x<=550&&row_addr_y>=0&&row_addr_y<=400)?(row_addr_y)*551+col_addr_x:0;
    //蓝色小人静态图片47*41（x_blue,y_blue）图片自带428的背景色
    blue_st<= (col_addr_x>=x_blue&&col_addr_x<=x_blue+46&&row_addr_y>=y_blue&&row_addr_y<=y_blue+40)?(row_addr_y-y_blue)*47+col_addr_x-x_blue:0;
    //蓝色小人向右奔跑的图片47*43（x_blue,y_blue）图片自带028的背景色
    blue_rwk<= (col_addr_x>=x_blue&&col_addr_x<=x_blue+46&&row_addr_y>=y_blue&&row_addr_y<=y_blue+42)?(row_addr_y-y_blue)*47+col_addr_x-x_blue:0;
    //怪物1静止62*36（x_slim1,y_slim1）图片自带028的背景色
    slim1_st<= (col_addr_x>=x_slim1&&col_addr_x<=x_slim1+61&&row_addr_y>=y_slim1&&row_addr_y<=y_slim1+35)?(row_addr_y-y_slim1)*62+col_addr_x-x_slim1:0;
    //怪物2静止62*36（x_slim2,y_slim2）图片自带028的背景色
    slim2_st<= (col_addr_x>=x_slim2&&col_addr_x<=x_slim2+61&&row_addr_y>=y_slim2&&row_addr_y<=y_slim2+35)?(row_addr_y-y_slim2)*62+col_addr_x-x_slim2:0;
    //雪花1图片24*26（x_snowf1,y_snowf1）图片自带028的背景色
    snowf1<= (col_addr_x>=x_snowf1&&col_addr_x<=x_snowf1+23&&row_addr_y>=y_snowf1&&row_addr_y<=y_snowf1+25)?(row_addr_y-y_snowf1)*24+col_addr_x-x_snowf1:0;
    snowf2<= (col_addr_x>=x_snowf2&&col_addr_x<=x_snowf2+23&&row_addr_y>=y_snowf2&&row_addr_y<=y_snowf2+25)?(row_addr_y-y_snowf2)*24+col_addr_x-x_snowf2:0;
    snowf3<= (col_addr_x>=x_snowf3&&col_addr_x<=x_snowf3+23&&row_addr_y>=y_snowf3&&row_addr_y<=y_snowf3+25)?(row_addr_y-y_snowf3)*24+col_addr_x-x_snowf3:0;
    snowf4<= (col_addr_x>=x_snowf4&&col_addr_x<=x_snowf4+23&&row_addr_y>=y_snowf4&&row_addr_y<=y_snowf4+25)?(row_addr_y-y_snowf4)*24+col_addr_x-x_snowf4:0;
    snowf5<= (col_addr_x>=x_snowf5&&col_addr_x<=x_snowf5+23&&row_addr_y>=y_snowf5&&row_addr_y<=y_snowf5+25)?(row_addr_y-y_snowf5)*24+col_addr_x-x_snowf5:0;
    snowf6<= (col_addr_x>=x_snowf6&&col_addr_x<=x_snowf6+23&&row_addr_y>=y_snowf6&&row_addr_y<=y_snowf6+25)?(row_addr_y-y_snowf6)*24+col_addr_x-x_snowf6:0;
    snowf7<= (col_addr_x>=x_snowf7&&col_addr_x<=x_snowf7+23&&row_addr_y>=y_snowf7&&row_addr_y<=y_snowf7+25)?(row_addr_y-y_snowf7)*24+col_addr_x-x_snowf7:0;
    snowf8<= (col_addr_x>=x_snowf8&&col_addr_x<=x_snowf8+23&&row_addr_y>=y_snowf8&&row_addr_y<=y_snowf8+25)?(row_addr_y-y_snowf8)*24+col_addr_x-x_snowf8:0;
    snowf9<= (col_addr_x>=x_snowf9&&col_addr_x<=x_snowf9+23&&row_addr_y>=y_snowf9&&row_addr_y<=y_snowf9+25)?(row_addr_y-y_snowf9)*24+col_addr_x-x_snowf9:0;
    snowf10<= (col_addr_x>=x_snowf10&&col_addr_x<=x_snowf10+23&&row_addr_y>=y_snowf10&&row_addr_y<=y_snowf10+25)?(row_addr_y-y_snowf10)*24+col_addr_x-x_snowf10:0;
    snowf11<= (col_addr_x>=x_snowf11&&col_addr_x<=x_snowf11+23&&row_addr_y>=y_snowf11&&row_addr_y<=y_snowf11+25)?(row_addr_y-y_snowf11)*24+col_addr_x-x_snowf11:0;
    snowf12<= (col_addr_x>=x_snowf12&&col_addr_x<=x_snowf12+23&&row_addr_y>=y_snowf12&&row_addr_y<=y_snowf12+25)?(row_addr_y-y_snowf12)*24+col_addr_x-x_snowf12:0;
    snowf13<= (col_addr_x>=x_snowf13&&col_addr_x<=x_snowf13+23&&row_addr_y>=y_snowf13&&row_addr_y<=y_snowf13+25)?(row_addr_y-y_snowf13)*24+col_addr_x-x_snowf13:0;
    snowf14<= (col_addr_x>=x_snowf14&&col_addr_x<=x_snowf14+23&&row_addr_y>=y_snowf14&&row_addr_y<=y_snowf14+25)?(row_addr_y-y_snowf14)*24+col_addr_x-x_snowf14:0;
    snowf15<= (col_addr_x>=x_snowf15&&col_addr_x<=x_snowf15+23&&row_addr_y>=y_snowf15&&row_addr_y<=y_snowf15+25)?(row_addr_y-y_snowf15)*24+col_addr_x-x_snowf15:0;
end

//调用ip核输出背景像素值
background bg2(.clka(clk),.addra(bg),.douta(vga_bg));


//调用ip核输出蓝色小人静态图片像素值
wire [11:0]vga_blue_st_1;
blue_static_1 blue_st_1f(.clka(clk),.addra(blue_st),.douta(vga_blue_st_1));
wire [11:0]vga_blue_st_2;
blue_static_5 blue_st_2f(.clka(clk),.addra(blue_st),.douta(vga_blue_st_2));
wire [11:0]vga_blue_st_3;
blue_static_9 blue_st_3f(.clka(clk),.addra(blue_st),.douta(vga_blue_st_3));
wire [11:0]vga_blue_st_4;
blue_static_13 blue_st_4f(.clka(clk),.addra(blue_st),.douta(vga_blue_st_4));
//蓝色小人向右奔跑的图片像素值

wire [11:0]vga_blue_rwk_1;
blue_r_walk_1 blue_rwk_1f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_1));
wire [11:0]vga_blue_rwk_3;
blue_r_walk_3 blue_rwk_3f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_3));
wire [11:0]vga_blue_rwk_5;
blue_r_walk_5 blue_rwk_5f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_5));
wire [11:0]vga_blue_rwk_7;
blue_r_walk_7 blue_rwk_7f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_7));
wire [11:0]vga_blue_rwk_9;
blue_r_walk_9 blue_rwk_9f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_9));
wire [11:0]vga_blue_rwk_11;
blue_r_walk_11 blue_rwk_11f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_11));
wire [11:0]vga_blue_rwk_13;
blue_r_walk_13 blue_rwk_13f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_13));
wire [11:0]vga_blue_rwk_15;
blue_r_walk_15 blue_rwk_15f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_15));


//粘液怪物1静止像素值
wire [11:0]vga_slim1_st_1;
slim1_static_1 slim1_st_1f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_1));
wire [11:0]vga_slim1_st_11;
slim1_static_11 slim1_st_11f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_11));
wire [11:0]vga_slim1_st_13;
slim1_static_13 slim1_st_13f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_13));
wire [11:0]vga_slim1_st_18;
slim1_static_18 slim1_st_18f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_18));
wire [11:0]vga_slim1_st_20;
slim1_static_20 slim1_st_20f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_20));
wire [11:0]vga_slim1_st_22;
slim1_static_22 slim1_st_22f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_22));
wire [11:0]vga_slim1_st_24;
slim1_static_24 slim1_st_24f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_24));
wire [11:0]vga_slim1_st_26;
slim1_static_26 slim1_st_26f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_26));
wire [11:0]vga_slim1_st_28;
slim1_static_28 slim1_st_28f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_28));
wire [11:0]vga_slim1_st_30;
slim1_static_30 slim1_st_30f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_30));
wire [11:0]vga_slim1_st_32;
slim1_static_32 slim1_st_32f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_32));
wire [11:0]vga_slim1_st_34;
slim1_static_34 slim1_st_34f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_34));
wire [11:0]vga_slim1_st_36;
slim1_static_36 slim1_st_36f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_36));
wire [11:0]vga_slim1_st_38;
slim1_static_38 slim1_st_38f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_38));
//粘液怪物2静止像素值
wire [11:0]vga_slim2_st_1;
slim1_static_1 slim1_st_1f(.clka(clk),.addra(slim1_st),.douta(vga_slim2_st_1));
wire [11:0]vga_slim2_st_11;
slim1_static_11 slim1_st_11f(.clka(clk),.addra(slim1_st),.douta(vga_slim2_st_11));
wire [11:0]vga_slim2_st_13;
slim1_static_13 slim1_st_13f(.clka(clk),.addra(slim1_st),.douta(vga_slim2_st_13));
wire [11:0]vga_slim2_st_18;
slim1_static_18 slim1_st_18f(.clka(clk),.addra(slim1_st),.douta(vga_slim2_st_18));
wire [11:0]vga_slim2_st_20;
slim1_static_20 slim1_st_20f(.clka(clk),.addra(slim1_st),.douta(vga_slim2_st_20));
wire [11:0]vga_slim2_st_22;
slim1_static_22 slim1_st_22f(.clka(clk),.addra(slim1_st),.douta(vga_slim2_st_22));
wire [11:0]vga_slim2_st_24;
slim1_static_24 slim1_st_24f(.clka(clk),.addra(slim1_st),.douta(vga_slim2_st_24));
wire [11:0]vga_slim2_st_26;
slim1_static_26 slim1_st_26f(.clka(clk),.addra(slim1_st),.douta(vga_slim2_st_26));
wire [11:0]vga_slim2_st_28;
slim1_static_28 slim1_st_28f(.clka(clk),.addra(slim1_st),.douta(vga_slim2_st_28));
wire [11:0]vga_slim2_st_30;
slim1_static_30 slim1_st_30f(.clka(clk),.addra(slim1_st),.douta(vga_slim2_st_30));
wire [11:0]vga_slim2_st_32;
slim1_static_32 slim1_st_32f(.clka(clk),.addra(slim1_st),.douta(vga_slim2_st_32));
wire [11:0]vga_slim2_st_34;
slim1_static_34 slim1_st_34f(.clka(clk),.addra(slim1_st),.douta(vga_slim2_st_34));
wire [11:0]vga_slim2_st_36;
slim1_static_36 slim1_st_36f(.clka(clk),.addra(slim1_st),.douta(vga_slim2_st_36));
wire [11:0]vga_slim2_st_38;
slim1_static_38 slim1_st_38f(.clka(clk),.addra(slim1_st),.douta(vga_slim2_st_38));
//雪花1像素值
wire [11:0]vga_snowf1_1,vga_snowf2_1,vga_snowf3_1,vga_snowf4_1,vga_snowf5_1,vga_snowf6_1,vga_snowf7_1,vga_snowf8_1,vga_snowf9_1,vga_snowf10_1,vga_snowf11_1,vga_snowf12_1,vga_snowf13_1,vga_snowf14_1,vga_snowf15_1;
snowf_1 snowf1_1f(.clka(clk),.addra(snowf1),.douta(vga_snowf1_1));
snowf_1 snowf2_1f(.clka(clk),.addra(snowf2),.douta(vga_snowf2_1));
snowf_1 snowf3_1f(.clka(clk),.addra(snowf3),.douta(vga_snowf3_1));
snowf_1 snowf4_1f(.clka(clk),.addra(snowf4),.douta(vga_snowf4_1));
snowf_1 snowf5_1f(.clka(clk),.addra(snowf5),.douta(vga_snowf5_1));
snowf_1 snowf6_1f(.clka(clk),.addra(snowf6),.douta(vga_snowf6_1));
snowf_1 snowf7_1f(.clka(clk),.addra(snowf7),.douta(vga_snowf7_1));
snowf_1 snowf8_1f(.clka(clk),.addra(snowf8),.douta(vga_snowf8_1));
snowf_1 snowf9_1f(.clka(clk),.addra(snowf9),.douta(vga_snowf9_1));
snowf_1 snowf10_1f(.clka(clk),.addra(snowf10),.douta(vga_snowf10_1));
snowf_1 snowf11_1f(.clka(clk),.addra(snowf11),.douta(vga_snowf11_1));
snowf_1 snowf12_1f(.clka(clk),.addra(snowf12),.douta(vga_snowf12_1));
snowf_1 snowf13_1f(.clka(clk),.addra(snowf13),.douta(vga_snowf13_1));
snowf_1 snowf14_1f(.clka(clk),.addra(snowf14),.douta(vga_snowf14_1));
snowf_1 snowf15_1f(.clka(clk),.addra(snowf15),.douta(vga_snowf15_1));
wire [11:0]vga_snowf1_3,vga_snowf2_3,vga_snowf3_3,vga_snowf4_3,vga_snowf5_3,vga_snowf6_3,vga_snowf7_3,vga_snowf8_3,vga_snowf9_3,vga_snowf10_3,vga_snowf11_3,vga_snowf12_3,vga_snowf13_3,vga_snowf14_3,vga_snowf15_3;
snowf_3 snowf1_3f(.clka(clk),.addra(snowf1),.douta(vga_snowf1_3));
snowf_3 snowf2_3f(.clka(clk),.addra(snowf2),.douta(vga_snowf2_3));
snowf_3 snowf3_3f(.clka(clk),.addra(snowf3),.douta(vga_snowf3_3));
snowf_3 snowf4_3f(.clka(clk),.addra(snowf4),.douta(vga_snowf4_3));
snowf_3 snowf5_3f(.clka(clk),.addra(snowf5),.douta(vga_snowf5_3));
snowf_3 snowf6_3f(.clka(clk),.addra(snowf6),.douta(vga_snowf6_3));
snowf_3 snowf7_3f(.clka(clk),.addra(snowf7),.douta(vga_snowf7_3));
snowf_3 snowf8_3f(.clka(clk),.addra(snowf8),.douta(vga_snowf8_3));
snowf_3 snowf9_3f(.clka(clk),.addra(snowf9),.douta(vga_snowf9_3));
snowf_3 snowf10_3f(.clka(clk),.addra(snowf10),.douta(vga_snowf10_3));
snowf_3 snowf11_3f(.clka(clk),.addra(snowf11),.douta(vga_snowf11_3));
snowf_3 snowf12_3f(.clka(clk),.addra(snowf12),.douta(vga_snowf12_3));
snowf_3 snowf13_3f(.clka(clk),.addra(snowf13),.douta(vga_snowf13_3));
snowf_3 snowf14_3f(.clka(clk),.addra(snowf14),.douta(vga_snowf14_3));
snowf_3 snowf15_3f(.clka(clk),.addra(snowf15),.douta(vga_snowf15_3));


wire [11:0]vga_snowf1_5,vga_snowf2_5,vga_snowf3_5,vga_snowf4_5,vga_snowf5_5,vga_snowf6_5,vga_snowf7_5,vga_snowf8_5,vga_snowf9_5,vga_snowf10_5,vga_snowf11_5,vga_snowf12_5,vga_snowf13_5,vga_snowf14_5,vga_snowf15_5;
snowf_5 snowf1_5f(.clka(clk),.addra(snowf1),.douta(vga_snowf1_5));
snowf_5 snowf2_5f(.clka(clk),.addra(snowf2),.douta(vga_snowf2_5));
snowf_5 snowf3_5f(.clka(clk),.addra(snowf3),.douta(vga_snowf3_5));
snowf_5 snowf4_5f(.clka(clk),.addra(snowf4),.douta(vga_snowf4_5));
snowf_5 snowf5_5f(.clka(clk),.addra(snowf5),.douta(vga_snowf5_5));
snowf_5 snowf6_5f(.clka(clk),.addra(snowf6),.douta(vga_snowf6_5));
snowf_5 snowf7_5f(.clka(clk),.addra(snowf7),.douta(vga_snowf7_5));
snowf_5 snowf8_5f(.clka(clk),.addra(snowf8),.douta(vga_snowf8_5));
snowf_5 snowf9_5f(.clka(clk),.addra(snowf9),.douta(vga_snowf9_5));
snowf_5 snowf10_5f(.clka(clk),.addra(snowf10),.douta(vga_snowf10_5));
snowf_5 snowf11_5f(.clka(clk),.addra(snowf11),.douta(vga_snowf11_5));
snowf_5 snowf12_5f(.clka(clk),.addra(snowf12),.douta(vga_snowf12_5));
snowf_5 snowf13_5f(.clka(clk),.addra(snowf13),.douta(vga_snowf13_5));
snowf_5 snowf14_5f(.clka(clk),.addra(snowf14),.douta(vga_snowf14_5));
snowf_5 snowf15_5f(.clka(clk),.addra(snowf15),.douta(vga_snowf15_5));

wire [11:0]vga_snowf1_7,vga_snowf2_7,vga_snowf3_7,vga_snowf4_7,vga_snowf5_7,vga_snowf6_7,vga_snowf7_7,vga_snowf8_7,vga_snowf9_7,vga_snowf10_7,vga_snowf11_7,vga_snowf12_7,vga_snowf13_7,vga_snowf14_7,vga_snowf15_7;
snowf_7 snowf1_7f(.clka(clk),.addra(snowf1),.douta(vga_snowf1_7));
snowf_7 snowf2_7f(.clka(clk),.addra(snowf2),.douta(vga_snowf2_7));
snowf_7 snowf3_7f(.clka(clk),.addra(snowf3),.douta(vga_snowf3_7));
snowf_7 snowf4_7f(.clka(clk),.addra(snowf4),.douta(vga_snowf4_7));
snowf_7 snowf5_7f(.clka(clk),.addra(snowf5),.douta(vga_snowf5_7));
snowf_7 snowf6_7f(.clka(clk),.addra(snowf6),.douta(vga_snowf6_7));
snowf_7 snowf7_7f(.clka(clk),.addra(snowf7),.douta(vga_snowf7_7));
snowf_7 snowf8_7f(.clka(clk),.addra(snowf8),.douta(vga_snowf8_7));
snowf_7 snowf9_7f(.clka(clk),.addra(snowf9),.douta(vga_snowf9_7));
snowf_7 snowf10_7f(.clka(clk),.addra(snowf10),.douta(vga_snowf10_7));
snowf_7 snowf11_7f(.clka(clk),.addra(snowf11),.douta(vga_snowf11_7));
snowf_7 snowf12_7f(.clka(clk),.addra(snowf12),.douta(vga_snowf12_7));
snowf_7 snowf13_7f(.clka(clk),.addra(snowf13),.douta(vga_snowf13_7));
snowf_7 snowf14_7f(.clka(clk),.addra(snowf14),.douta(vga_snowf14_7));
snowf_7 snowf15_7f(.clka(clk),.addra(snowf15),.douta(vga_snowf15_7));

wire [11:0]vga_snowf1_9,vga_snowf2_9,vga_snowf3_9,vga_snowf4_9,vga_snowf5_9,vga_snowf6_9,vga_snowf7_9,vga_snowf8_9,vga_snowf9_9,vga_snowf10_9,vga_snowf11_9,vga_snowf12_9,vga_snowf13_9,vga_snowf14_9,vga_snowf15_9;
snowf_9 snowf1_9f(.clka(clk),.addra(snowf1),.douta(vga_snowf1_9));
snowf_9 snowf2_9f(.clka(clk),.addra(snowf2),.douta(vga_snowf2_9));
snowf_9 snowf3_9f(.clka(clk),.addra(snowf3),.douta(vga_snowf3_9));
snowf_9 snowf4_9f(.clka(clk),.addra(snowf4),.douta(vga_snowf4_9));
snowf_9 snowf5_9f(.clka(clk),.addra(snowf5),.douta(vga_snowf5_9));
snowf_9 snowf6_9f(.clka(clk),.addra(snowf6),.douta(vga_snowf6_9));
snowf_9 snowf7_9f(.clka(clk),.addra(snowf7),.douta(vga_snowf7_9));
snowf_9 snowf8_9f(.clka(clk),.addra(snowf8),.douta(vga_snowf8_9));
snowf_9 snowf9_9f(.clka(clk),.addra(snowf9),.douta(vga_snowf9_9));
snowf_9 snowf10_9f(.clka(clk),.addra(snowf10),.douta(vga_snowf10_9));
snowf_9 snowf11_9f(.clka(clk),.addra(snowf11),.douta(vga_snowf11_9));
snowf_9 snowf12_9f(.clka(clk),.addra(snowf12),.douta(vga_snowf12_9));
snowf_9 snowf13_9f(.clka(clk),.addra(snowf13),.douta(vga_snowf13_9));
snowf_9 snowf14_9f(.clka(clk),.addra(snowf14),.douta(vga_snowf14_9));
snowf_9 snowf15_9f(.clka(clk),.addra(snowf15),.douta(vga_snowf15_9));
wire [11:0]vga_snowf1_11,vga_snowf2_11,vga_snowf3_11,vga_snowf4_11,vga_snowf5_11,vga_snowf6_11,vga_snowf7_11,vga_snowf8_11,vga_snowf9_11,vga_snowf10_11,vga_snowf11_11,vga_snowf12_11,vga_snowf13_11,vga_snowf14_11,vga_snowf15_11;
snowf_11 snowf1_11f(.clka(clk),.addra(snowf1),.douta(vga_snowf1_11));
snowf_11 snowf2_11f(.clka(clk),.addra(snowf2),.douta(vga_snowf2_11));
snowf_11 snowf3_11f(.clka(clk),.addra(snowf3),.douta(vga_snowf3_11));
snowf_11 snowf4_11f(.clka(clk),.addra(snowf4),.douta(vga_snowf4_11));
snowf_11 snowf5_11f(.clka(clk),.addra(snowf5),.douta(vga_snowf5_11));
snowf_11 snowf6_11f(.clka(clk),.addra(snowf6),.douta(vga_snowf6_11));
snowf_11 snowf7_11f(.clka(clk),.addra(snowf7),.douta(vga_snowf7_11));
snowf_11 snowf8_11f(.clka(clk),.addra(snowf8),.douta(vga_snowf8_11));
snowf_11 snowf9_11f(.clka(clk),.addra(snowf9),.douta(vga_snowf9_11));
snowf_11 snowf10_11f(.clka(clk),.addra(snowf10),.douta(vga_snowf10_11));
snowf_11 snowf11_11f(.clka(clk),.addra(snowf11),.douta(vga_snowf11_11));
snowf_11 snowf12_11f(.clka(clk),.addra(snowf12),.douta(vga_snowf12_11));
snowf_11 snowf13_11f(.clka(clk),.addra(snowf13),.douta(vga_snowf13_11));
snowf_11 snowf14_11f(.clka(clk),.addra(snowf14),.douta(vga_snowf14_11));
snowf_11 snowf15_11f(.clka(clk),.addra(snowf15),.douta(vga_snowf15_11));
wire [11:0]vga_snowf1_13,vga_snowf2_13,vga_snowf3_13,vga_snowf4_13,vga_snowf5_13,vga_snowf6_13,vga_snowf7_13,vga_snowf8_13,vga_snowf9_13,vga_snowf10_13,vga_snowf11_13,vga_snowf12_13,vga_snowf13_13,vga_snowf14_13,vga_snowf15_13;
snowf_13 snowf1_13f(.clka(clk),.addra(snowf1),.douta(vga_snowf1_13));
snowf_13 snowf2_13f(.clka(clk),.addra(snowf2),.douta(vga_snowf2_13));
snowf_13 snowf3_13f(.clka(clk),.addra(snowf3),.douta(vga_snowf3_13));
snowf_13 snowf4_13f(.clka(clk),.addra(snowf4),.douta(vga_snowf4_13));
snowf_13 snowf5_13f(.clka(clk),.addra(snowf5),.douta(vga_snowf5_13));
snowf_13 snowf6_13f(.clka(clk),.addra(snowf6),.douta(vga_snowf6_13));
snowf_13 snowf7_13f(.clka(clk),.addra(snowf7),.douta(vga_snowf7_13));
snowf_13 snowf8_13f(.clka(clk),.addra(snowf8),.douta(vga_snowf8_13));
snowf_13 snowf9_13f(.clka(clk),.addra(snowf9),.douta(vga_snowf9_13));
snowf_13 snowf10_13f(.clka(clk),.addra(snowf10),.douta(vga_snowf10_13));
snowf_13 snowf11_13f(.clka(clk),.addra(snowf11),.douta(vga_snowf11_13));
snowf_13 snowf12_13f(.clka(clk),.addra(snowf12),.douta(vga_snowf12_13));
snowf_13 snowf13_13f(.clka(clk),.addra(snowf13),.douta(vga_snowf13_13));
snowf_13 snowf14_13f(.clka(clk),.addra(snowf14),.douta(vga_snowf14_13));
snowf_13 snowf15_13f(.clka(clk),.addra(snowf15),.douta(vga_snowf15_13));
wire [11:0]vga_snowf1_15,vga_snowf2_15,vga_snowf3_15,vga_snowf4_15,vga_snowf5_15,vga_snowf6_15,vga_snowf7_15,vga_snowf8_15,vga_snowf9_15,vga_snowf10_15,vga_snowf11_15,vga_snowf12_15,vga_snowf13_15,vga_snowf14_15,vga_snowf15_15;
snowf_15 snowf1_15f(.clka(clk),.addra(snowf1),.douta(vga_snowf1_15));
snowf_15 snowf2_15f(.clka(clk),.addra(snowf2),.douta(vga_snowf2_15));
snowf_15 snowf3_15f(.clka(clk),.addra(snowf3),.douta(vga_snowf3_15));
snowf_15 snowf4_15f(.clka(clk),.addra(snowf4),.douta(vga_snowf4_15));
snowf_15 snowf5_15f(.clka(clk),.addra(snowf5),.douta(vga_snowf5_15));
snowf_15 snowf6_15f(.clka(clk),.addra(snowf6),.douta(vga_snowf6_15));
snowf_15 snowf7_15f(.clka(clk),.addra(snowf7),.douta(vga_snowf7_15));
snowf_15 snowf8_15f(.clka(clk),.addra(snowf8),.douta(vga_snowf8_15));
snowf_15 snowf9_15f(.clka(clk),.addra(snowf9),.douta(vga_snowf9_15));
snowf_15 snowf10_15f(.clka(clk),.addra(snowf10),.douta(vga_snowf10_15));
snowf_15 snowf11_15f(.clka(clk),.addra(snowf11),.douta(vga_snowf11_15));
snowf_15 snowf12_15f(.clka(clk),.addra(snowf12),.douta(vga_snowf12_15));
snowf_15 snowf13_15f(.clka(clk),.addra(snowf13),.douta(vga_snowf13_15));
snowf_15 snowf14_15f(.clka(clk),.addra(snowf14),.douta(vga_snowf14_15));
snowf_15 snowf15_15f(.clka(clk),.addra(snowf15),.douta(vga_snowf15_15));


//显示图片
always@(posedge clk)begin
    //采用层刷的覆盖流
    //1.背景
    if(col_addr_x>=0&&col_addr_x<=639&&row_addr_y>=0&&row_addr_y<=600)begin
        vga_data<=vga_bg[11:0];   
    end
    //2.方块
    //3.树
    //4.小石块
    //5.雪花
    if(col_addr_x>=x_snowf1&&col_addr_x<=x_snowf1+23&&row_addr_y>=y_snowf1&&row_addr_y<=y_snowf1+25)begin
        if(vga_snowf1[11:0]!=0*256+2*16+8)begin
            vga_data<=vga_snowf1[11:0];   
        end
    end
    if(col_addr_x>=x_snowf2&&col_addr_x<=x_snowf2+23&&row_addr_y>=y_snowf2&&row_addr_y<=y_snowf2+25)begin
        if(vga_snowf2[11:0]!=0*256+2*16+8)begin
            vga_data<=vga_snowf2[11:0];   
        end
    end
    if(col_addr_x>=x_snowf3&&col_addr_x<=x_snowf3+23&&row_addr_y>=y_snowf3&&row_addr_y<=y_snowf3+25)begin
        if(vga_snowf3[11:0]!=0*256+2*16+8)begin
            vga_data<=vga_snowf3[11:0];   
        end
    end
    if(col_addr_x>=x_snowf4&&col_addr_x<=x_snowf4+23&&row_addr_y>=y_snowf4&&row_addr_y<=y_snowf4+25)begin
        if(vga_snowf4[11:0]!=0*256+2*16+8)begin
            vga_data<=vga_snowf4[11:0];   
        end
    end
    if(col_addr_x>=x_snowf5&&col_addr_x<=x_snowf5+23&&row_addr_y>=y_snowf5&&row_addr_y<=y_snowf5+25)begin
        if(vga_snowf5[11:0]!=0*256+2*16+8)begin
            vga_data<=vga_snowf5[11:0];   
        end
    end
    if(col_addr_x>=x_snowf6&&col_addr_x<=x_snowf6+23&&row_addr_y>=y_snowf6&&row_addr_y<=y_snowf6+25)begin
        if(vga_snowf6[11:0]!=0*256+2*16+8)begin
            vga_data<=vga_snowf6[11:0];   
        end
    end
    if(col_addr_x>=x_snowf7&&col_addr_x<=x_snowf7+23&&row_addr_y>=y_snowf7&&row_addr_y<=y_snowf7+25)begin
        if(vga_snowf7[11:0]!=0*256+2*16+8)begin
            vga_data<=vga_snowf7[11:0];   
        end
    end
    if(col_addr_x>=x_snowf8&&col_addr_x<=x_snowf8+23&&row_addr_y>=y_snowf8&&row_addr_y<=y_snowf8+25)begin
        if(vga_snowf8[11:0]!=0*256+2*16+8)begin
            vga_data<=vga_snowf8[11:0];   
        end
    end
    if(col_addr_x>=x_snowf9&&col_addr_x<=x_snowf9+23&&row_addr_y>=y_snowf9&&row_addr_y<=y_snowf9+25)begin
        if(vga_snowf9[11:0]!=0*256+2*16+8)begin
            vga_data<=vga_snowf9[11:0];   
        end
    end
    if(col_addr_x>=x_snowf10&&col_addr_x<=x_snowf10+23&&row_addr_y>=y_snowf10&&row_addr_y<=y_snowf10+25)begin
        if(vga_snowf10[11:0]!=0*256+2*16+8)begin
            vga_data<=vga_snowf10[11:0];   
        end
    end
    if(col_addr_x>=x_snowf11&&col_addr_x<=x_snowf11+23&&row_addr_y>=y_snowf11&&row_addr_y<=y_snowf11+25)begin
        if(vga_snowf11[11:0]!=0*256+2*16+8)begin
            vga_data<=vga_snowf11[11:0];   
        end
    end
    if(col_addr_x>=x_snowf12&&col_addr_x<=x_snowf12+23&&row_addr_y>=y_snowf12&&row_addr_y<=y_snowf12+25)begin
        if(vga_snowf12[11:0]!=0*256+2*16+8)begin
            vga_data<=vga_snowf12[11:0];   
        end
    end
    if(col_addr_x>=x_snowf13&&col_addr_x<=x_snowf13+23&&row_addr_y>=y_snowf13&&row_addr_y<=y_snowf13+25)begin
        if(vga_snowf13[11:0]!=0*256+2*16+8)begin
            vga_data<=vga_snowf13[11:0];   
        end
    end
    if(col_addr_x>=x_snowf14&&col_addr_x<=x_snowf14+23&&row_addr_y>=y_snowf14&&row_addr_y<=y_snowf14+25)begin
        if(vga_snowf14[11:0]!=0*256+2*16+8)begin
            vga_data<=vga_snowf14[11:0];   
        end
    end
    if(col_addr_x>=x_snowf15&&col_addr_x<=x_snowf15+23&&row_addr_y>=y_snowf15&&row_addr_y<=y_snowf15+25)begin
        if(vga_snowf15[11:0]!=0*256+2*16+8)begin
            vga_data<=vga_snowf15[11:0];   
        end
    end

    //6.怪物62*36 028
    if(col_addr_x>=x_slim1&&col_addr_x<=x_slim1+61&&row_addr_y>=y_slim1&&row_addr_y<=y_slim1+35)begin
        if(vga_slim1_st[11:0]!=0*256+2*16+8)begin
            vga_data<=vga_slim1_st[11:0];   
        end
    end
    if(col_addr_x>=x_slim2&&col_addr_x<=x_slim2+61&&row_addr_y>=y_slim2&&row_addr_y<=y_slim2+35)begin
        if(vga_slim2_st[11:0]!=0*256+2*16+8)begin
            vga_data<=vga_slim2_st[11:0];   
        end
    end

    //7.蓝色小人（筛选静态运动及删除背景色）47*41  428
    if(col_addr_x>=x_blue&&col_addr_x<=x_blue+46&&row_addr_y>=y_blue&&row_addr_y<=y_blue+40)begin
        if(vga_blue_st[11:0]!=4*256+2*16+8)begin
            vga_data<=vga_blue_st[11:0];   
        end
    end

    //8.蓝色小人（筛选奔跑及删除背景色）47*43 028
    if(col_addr_x>=x_blue&&col_addr_x<=x_blue+46&&row_addr_y>=y_blue&&row_addr_y<=y_blue+42)begin
        if(vga_blue_rwk[11:0]!=0*256+2*16+8)begin
            vga_data<=vga_blue_rwk[11:0];   
        end
    end



end
reg [31:0]ipcnt;
reg [4:0]ip_blue_st;
reg [4:0]ip_blue_rwk;
reg [7:0]ip_slim1_st;
reg [7:0]ip_slim2_st;
reg [4:0]ip_snowf1,ip_snowf2,ip_snowf3,ip_snowf4,ip_snowf5,ip_snowf6,ip_snowf7,ip_snowf8,ip_snowf9,ip_snowf10,ip_snowf11,ip_snowf12,ip_snowf13,ip_snowf14,ip_snowf15;
always @(posedge clk) begin
    if(ipcnt == 6_000_000) begin  // 40ms*100M=4M，由于计数器只有3位，所以这里实例只能计数到500k，所以选用了40ms/5=8ms，即2.5*100k
        ipcnt <= 0;
        ip_blue_st <= ip_blue_st + 1;
        ip_slim1_st <= ip_slim1_st + 1;
        if(ip_blue_st == 15) begin
        ip_blue_st <= 0;  // 6个ip核循环16帧
        end
        if(ip_slim1_st == 79) begin
        ip_slim1_st <= 0;  // 14个ip核循环80帧
        end
        if(ip_slim2_st == 79) begin
        ip_slim2_st <= 0;  // 14个ip核循环80帧
        end
        if(ip_blue_rwk == 15) begin
        ip_blue_rwk <= 0;  // 8个ip核循环16帧
        end
        if(ip_snowf1 == 15) begin
        ip_snowf1 <= 0;  // 8个ip核循环16帧
        ip_snowf2 <= 0;  // 8个ip核循环16帧
        ip_snowf3 <= 0;  // 8个ip核循环16帧
        ip_snowf4 <= 0;  // 8个ip核循环16帧
        ip_snowf5 <= 0;  // 8个ip核循环16帧
        ip_snowf6 <= 0;  // 8个ip核循环16帧
        ip_snowf7 <= 0;  // 8个ip核循环16帧
        ip_snowf8 <= 0;  // 8个ip核循环16帧
        ip_snowf9 <= 0;  // 8个ip核循环16帧
        ip_snowf10 <= 0;  // 8个ip核循环16帧
        ip_snowf11 <= 0;  // 8个ip核循环16帧
        ip_snowf12 <= 0;  // 8个ip核循环16帧
        ip_snowf13 <= 0;  // 8个ip核循环16帧
        ip_snowf14 <= 0;  // 8个ip核循环16帧
        ip_snowf15 <= 0;  // 8个ip核循环16帧
        end
    else begin
        ipcnt <= ipcnt + 1;
    end
end

always @(posedge clk) begin
    case(ip_blue_st)
        0: vga_blue_st <= vga_blue_st_1[11:0];
        // 1: vga_blue_st <= vga_blue_st_1[11:0];
        // 2: vga_blue_st <= vga_blue_st_1[11:0];
        // 3: vga_blue_st <= vga_blue_st_1[11:0];
        4: vga_blue_st <= vga_blue_st_2[11:0];
        // 5: vga_blue_st <= vga_blue_st_2[11:0];
        // 6: vga_blue_st <= vga_blue_st_2[11:0];
        // 7: vga_blue_st <= vga_blue_st_2[11:0];
        8: vga_blue_st <= vga_blue_st_3[11:0];
        // 9: vga_blue_st <= vga_blue_st_3[11:0];
        // 10: vga_blue_st <= vga_blue_st_3[11:0];
        // 11: vga_blue_st <= vga_blue_st_3[11:0];
        12: vga_blue_st <= vga_blue_st_4[11:0];
        // 13: vga_blue_st <= vga_blue_st_4[11:0];
        // 14: vga_blue_st <= vga_blue_st_4[11:0];
        // 15: vga_blue_st <= vga_blue_st_4[11:0];
    endcase
    case(ip_slim1_st)
        0: vga_slim1_st <= vga_slim1_st_1[11:0];
        10: vga_slim1_st <= vga_slim1_st_11[11:0];
        12: vga_slim1_st <= vga_slim1_st_13[11:0];
        17: vga_slim1_st <= vga_slim1_st_18[11:0];
        19: vga_slim1_st <= vga_slim1_st_20[11:0];
        21: vga_slim1_st <= vga_slim1_st_22[11:0];
        23: vga_slim1_st <= vga_slim1_st_24[11:0];
        25: vga_slim1_st <= vga_slim1_st_26[11:0];
        27: vga_slim1_st <= vga_slim1_st_28[11:0];
        29: vga_slim1_st <= vga_slim1_st_30[11:0];
        31: vga_slim1_st <= vga_slim1_st_32[11:0];
        33: vga_slim1_st <= vga_slim1_st_34[11:0];
        35: vga_slim1_st <= vga_slim1_st_36[11:0];
        37: vga_slim1_st <= vga_slim1_st_38[11:0];
        39: vga_slim1_st <= vga_slim1_st_1[11:0];
    endcase
    case(ip_slim2_st)
        0: vga_slim2_st <= vga_slim2_st_1[11:0];
        10: vga_slim2_st <= vga_slim2_st_11[11:0];
        12: vga_slim2_st <= vga_slim2_st_13[11:0];
        17: vga_slim2_st <= vga_slim2_st_18[11:0];
        19: vga_slim2_st <= vga_slim2_st_20[11:0];
        21: vga_slim2_st <= vga_slim2_st_22[11:0];
        23: vga_slim2_st <= vga_slim2_st_24[11:0];
        25: vga_slim2_st <= vga_slim2_st_26[11:0];
        27: vga_slim2_st <= vga_slim2_st_28[11:0];
        29: vga_slim2_st <= vga_slim2_st_30[11:0];
        31: vga_slim2_st <= vga_slim2_st_32[11:0];
        33: vga_slim2_st <= vga_slim2_st_34[11:0];
        35: vga_slim2_st <= vga_slim2_st_36[11:0];
        37: vga_slim2_st <= vga_slim2_st_38[11:0];
        39: vga_slim2_st <= vga_slim2_st_1[11:0];
    endcase
    case(ip_blue_rwk)
        0: vga_blue_rwk <= vga_blue_rwk_1[11:0];
        2: vga_blue_rwk <= vga_blue_rwk_3[11:0];    
        4: vga_blue_rwk <= vga_blue_rwk_5[11:0];
        6: vga_blue_rwk <= vga_blue_rwk_7[11:0];
        8: vga_blue_rwk <= vga_blue_rwk_9[11:0];
        10: vga_blue_rwk <= vga_blue_rwk_11[11:0];
        12: vga_blue_rwk <= vga_blue_rwk_13[11:0];
        14: vga_blue_rwk <= vga_blue_rwk_15[11:0];
    endcase
    case(ip_snowf1)
        0: vga_snowf1 <= vga_snowf_1[11:0];
        2: vga_snowf1 <= vga_snowf_3[11:0];    
        4: vga_snowf1 <= vga_snowf_5[11:0];
        6: vga_snowf1 <= vga_snowf_7[11:0];
        8: vga_snowf1 <= vga_snowf_9[11:0];
        10: vga_snowf1 <= vga_snowf11[11:0];
        12: vga_snowf1 <= vga_snowf13[11:0];
        14: vga_snowf1 <= vga_snowf15[11:0];
    endcase
end

endmodule