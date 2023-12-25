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
//调用ip核输出背景
reg [18:0] bg;
wire [11:0] vga_bg; 
background bg2(.clka(clk),.addra(bg),.douta(vga_bg));
//background2 bg3(.clka(clk),.addra(bg),.douta(vga_bg));
//调用ip核输出蓝色小人静态图片
reg [9:0]x_blue;
reg [8:0]y_blue;
initial begin
    x_blue=10'b0;
    y_blue=9'b0;
end
//蓝色小人静态图片的坐标
reg [11:0]vga_blue_st;
reg [10:0]blue_st;
wire [11:0]vga_blue_st_1;
blue_static_1 blue_st_1f(.clka(clk),.addra(blue_st),.douta(vga_blue_st_1));
// reg [10:0]blue_st_2;
wire [11:0]vga_blue_st_2;
blue_static_2 blue_st_2f(.clka(clk),.addra(blue_st),.douta(vga_blue_st_2));
// reg [10:0]blue_st_3;
wire [11:0]vga_blue_st_3;
blue_static_3 blue_st_3f(.clka(clk),.addra(blue_st),.douta(vga_blue_st_3));
// reg [10:0]blue_st_4;
wire [11:0]vga_blue_st_4;
blue_static_4 blue_st_4f(.clka(clk),.addra(blue_st),.douta(vga_blue_st_4));
// reg [10:0]blue_st_5;
wire [11:0]vga_blue_st_5;
blue_static_5 blue_st_5f(.clka(clk),.addra(blue_st),.douta(vga_blue_st_5));
// reg [10:0]blue_st_6;
wire [11:0]vga_blue_st_6;
blue_static_6 blue_st_6f(.clka(clk),.addra(blue_st),.douta(vga_blue_st_6));


//给照片地址赋值(判断框里面是即将显示的范围，尺寸是551*401，就填550+400，？后面的值是coe文件的像素点的地址0-size-1)
always @(posedge clk)begin
    //背景551*401
    bg<= (col_addr_x>=0&&col_addr_x<=550&&row_addr_y>=0&&row_addr_y<=400)?(row_addr_y)*551+col_addr_x:0;
    //蓝色小人静态图片47*41（x_blue,y_blue）图片自带428的背景色
    blue_st<= (col_addr_x>=x_blue&&col_addr_x<=x_blue+47&&row_addr_y>=y_blue&&row_addr_y<=y_blue+41)?(row_addr_y-y_blue)*47+col_addr_x-x_blue:0;
end
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
    //5.怪物
    //6.蓝色小人（筛选静态运动及删除背景色）
    if(col_addr_x>=x_blue&&col_addr_x<=x_blue+46&&row_addr_y>=y_blue&&row_addr_y<=y_blue+40)begin
        if(vga_blue_st[11:0]!=4*256+2*16+8)begin
            vga_data<=vga_blue_st[11:0];   
        end
    end
    //将vga颜色转换为较冷色调
    //由红色变为蓝色，颜色值平移

end
always@(clk_240ms) begin 
    vga_blue_st=vga_blue_st_1[11:0];#40;
    vga_blue_st=vga_blue_st_2[11:0];#40;
    vga_blue_st=vga_blue_st_3[11:0];#40;
    vga_blue_st=vga_blue_st_4[11:0];#40;
    vga_blue_st=vga_blue_st_5[11:0];#40;
    vga_blue_st=vga_blue_st_6[11:0];#40;
end

endmodule