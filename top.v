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
end

//调用ip核输出背景

background bg2(.clka(clk),.addra(bg),.douta(vga_bg));

reg [9:0]x_blue;
reg [8:0]y_blue;
initial begin
    x_blue=10'b0;
    y_blue=9'b0;
end
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

//怪物1坐标
reg [9:0]x_slim1;
reg [8:0]y_slim1;
initial begin
    x_slim1=10'b48;
    y_slim1=9'b0;
end
reg [9:0]x_slim2;
reg [8:0]y_slim2;
initial begin
    x_slim1=10'b96;
    y_slim1=9'b0;
end
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
    //5.怪物62*36 028
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

    //6.蓝色小人（筛选静态运动及删除背景色）47*41  428
    if(col_addr_x>=x_blue&&col_addr_x<=x_blue+46&&row_addr_y>=y_blue&&row_addr_y<=y_blue+40)begin
        if(vga_blue_st[11:0]!=4*256+2*16+8)begin
            vga_data<=vga_blue_st[11:0];   
        end
    end

    //7.蓝色小人（筛选奔跑及删除背景色）47*43 028
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

end

endmodule