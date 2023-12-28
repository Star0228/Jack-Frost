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
////////////////Global Variables and Initialize//////////////////////////////
    wire clk_total;
    reg isFinish;
    reg [31:0]score;
    reg [3:0]health;
    initial begin
        isFinish=0;
        score=32'b0;
        health=4'b0000;
    end


    reg [31:0] clkdiv;
    always@(posedge clk)begin
        clkdiv <= clkdiv+1'b1;
    end

    //photo's size 551*401
    reg [11:0]vga_data;
    //vga's coordinate
    wire [9:0]col_addr_x;
    wire [8:0]row_addr_y;
    vgac v1(.vga_clk(clkdiv[1]),.clrn(1'b1),.d_in(vga_data),.row_addr(row_addr_y),.col_addr(col_addr_x),.hs(hs),.vs(vs),.r(r),.g(g),.b(b));
////////////////Global Variables and Initialize//////////////////////////////

////////////////////////////////Initialize the coordinates of various objects//////////////////////////////
    //蓝色小人坐标
    reg [9:0]x_blue;
    reg [8:0]y_blue;
    //record the state of Jack
    //0:stand 1:run 2:jump 3:jump&run
    reg [2:0]blue_state;

    initial begin
        x_blue=10'd0;
        y_blue=9'd0;
        blue_state=2'd0;
    end
   
    //Initialize the coordinate of the monsters with loop
    integer monster_num = 2;
    reg [9:0]x_slim[0:monster_num-1];
    reg [8:0]y_slim[0:monster_num-1];
    initial begin
        for (integer i=0;i<monster_num;i=i+1)begin
            x_slim[i]=10'd48*(i+1);
            y_slim[i]=9'd0;
        end
    end
    //Initialize snowflake's coordinate with loop
    integer snowflake_num = 15;
    reg [9:0]x_snowf[0:snowflake_num-1];
    reg [8:0]y_snowf[0:snowflake_num-1];
    initial begin
        for (integer i=0;i<snowflake_num;i=i+1)begin
            x_snowf[i]=10'd144;
            y_snowf[i]=9'd26*i;
        end
    end

    //Initialize the coordinate of the ground with loop
    //The map is constructed by blocks
    integer ground_num = 50;
    reg [9:0]x_ground[0:ground_num-1];
    reg [8:0]y_ground[0:ground_num-1];
    initial begin
        for (integer i=0;i<ground_num;i=i+1)begin
            x_ground[i]=10'd28*i;
            y_ground[i]=9'd374;
        end
    end
////////////////////////////////Initialize the coordinates of various objects//////////////////////////////

////////////////////////////////Implement the detection logic of the game//////////////////////////////
    //1. icing the ground
    wire [ground_num-1:0]bk_touched;
    //update the signal with loop
    genvar dt_block_fz_i;
    generate
        for (dt_block_fz_i=0;dt_block_fz_i<ground_num;dt_block_fz_i=dt_block_fz_i+1)begin:dt_block_fz
            dt_block_fz dt_block_fz_i(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground[dt_block_fz_i]),.y_ground(y_ground[dt_block_fz_i]),.touched(bk_touched[dt_block_fz_i]));
        end
    endgenerate

    //2. icing the monsters
    wire [monster_num-1:0]bk_frozen;
    //update the signal with loop
    genvar dt_slim_fz_i;
    generate
        for (dt_slim_fz_i=0;dt_slim_fz_i<monster_num;dt_slim_fz_i=dt_slim_fz_i+1)begin:dt_slim_fz
            dt_slim_fz dt_slim_fz_i(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_slim(x_slim[dt_slim_fz_i]),.y_slim(y_slim[dt_slim_fz_i]),.frozen(bk_frozen[dt_slim_fz_i]));
        end
    endgenerate
    
    //3. damaged by the monsters
    
    wire [monster_num-1:0]bk_slim;
    reg wudi;
    //update the signal with loop
    genvar dt_slim_bk_i;
    generate
        for (dt_slim_bk_i=0;dt_slim_bk_i<monster_num;dt_slim_bk_i=dt_slim_bk_i+1)begin:dt_slim_bk
            dt_slim_bk dt_slim_bk_i(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_slim(x_slim[dt_slim_bk_i]),.y_slim(y_slim[dt_slim_bk_i]),.isfrozen(bk_frozen[dt_slim_bk_i]),.broken(bk_slim[dt_slim_bk_i]));
        end
    endgenerate

    always@(posedge clk)begin
        if(bk_slim&&!wudi)begin
            health<=health-4'd1;
            wudi<=1'b1;
            #3000;
            wudi<=1'b0;
        end
    end
////////////////////////////////Implement the detection logic of the game//////////////////////////////

////////////////////////////////Assign the address of the photo to the address register//////////////////////////////
    //The address of the photo and the output of vga
    //背景1的地址寄存器和vga输出
    reg [18:0] bg;
    wire [11:0] vga_bg; 
    //蓝色小人静态图片的地址寄存器和vga输出
    reg [13:0]blue_st;
    reg [11:0]vga_blue_st;
    //蓝色小人向右奔跑的图片的地址寄存器和vga输出
    reg [13:0]blue_rwk;
    reg [11:0]vga_blue_rwk;
    
    //The address of the monsters and the output of vga
    reg [11:0] vga_slim_st[0:monster_num-1];
    reg [13:0] slim_st[0:monster_num-1];
    reg [11:0] vga_slim_fz[0:monster_num-1];
    reg [13:0] slim_fz[0:monster_num-1];

    //The address of the snowflakes and the output of vga
    wire [11:0] vga_snowf[0:snowflake_num-1];
    reg [10:0] snowf[0:snowflake_num-1];

    //The address of the ground and the output of vga
    wire [11:0] vga_ground[0:ground_num-1];
    reg [11:0] ground[0:ground_num-1];

    //assign the address of the photo, the size of the photo is 551*401, so the value is 550+400, the value after ? is the address of the pixel in the coe file
    always @(posedge clk)begin
        //背景551*401
        bg<= (col_addr_x>=0&&col_addr_x<=550&&row_addr_y>=0&&row_addr_y<=400)?(row_addr_y)*551+col_addr_x:0;
        //蓝色小人静态图片47*41（x_blue,y_blue）图片自带428的背景色
        blue_st<= (col_addr_x>=x_blue&&col_addr_x<=x_blue+46&&row_addr_y>=y_blue&&row_addr_y<=y_blue+40)?(row_addr_y-y_blue)*47+col_addr_x-x_blue:0;

        // //怪物1静止62*36（x_slim1,y_slim1）图片自带028的背景色
        for (integer i=0;i<monster_num;i=i+1)begin
            slim_st[i]<= (col_addr_x>=x_slim[i]&&col_addr_x<=x_slim[i]+61&&row_addr_y>=y_slim[i]&&row_addr_y<=y_slim[i]+35)?(row_addr_y-y_slim[i])*62+col_addr_x-x_slim[i]:0;
            slim_fz[i]<= (col_addr_x>=x_slim[i]&&col_addr_x<=x_slim[i]+49&&row_addr_y>=y_slim[i]&&row_addr_y<=y_slim[i]+50)?(row_addr_y-y_slim[i])*50+col_addr_x-x_slim[i]:0;
        end

        //雪花1图片24*26（x_snowf1,y_snowf1）图片自带028的背景色
        for (integer i=0;i<snowflake_num;i=i+1)begin
            snowf[i]<= (col_addr_x>=x_snowf[i]&&col_addr_x<=x_snowf[i]+23&&row_addr_y>=y_snowf[i]&&row_addr_y<=y_snowf[i]+25)?(row_addr_y-y_snowf[i])*24+col_addr_x-x_snowf[i]:0;
        end

        //地面方块28*42（x_ground1,y_ground1）图片自带028的背景色
        for (integer i=0;i<ground_num;i=i+1)begin
            ground[i]<= (col_addr_x>=x_ground[i]&&col_addr_x<=x_ground[i]+27&&row_addr_y>=y_ground[i]&&row_addr_y<=y_ground[i]+41)?(row_addr_y-y_ground[i])*28+col_addr_x-x_ground[i]:0;
        end
    end

    //调用ip核输出背景像素值
    background bg2(.clka(clk),.addra(bg),.douta(vga_bg));

    //Static pixel values and frozen pixel values of the monsters
    wire [11:0] vga_slim_st_1[0:monster_num-1],vga_slim_st_11[0:monster_num-1],vga_slim_st_13[0:monster_num-1],vga_slim_st_18[0:monster_num-1],vga_slim_st_20[0:monster_num-1],vga_slim_st_22[0:monster_num-1],vga_slim_st_24[0:monster_num-1],vga_slim_st_26[0:monster_num-1],vga_slim_st_28[0:monster_num-1],vga_slim_st_30[0:monster_num-1],vga_slim_st_32[0:monster_num-1],vga_slim_st_34[0:monster_num-1],vga_slim_st_36[0:monster_num-1],vga_slim_st_38[0:monster_num-1];
    wire [11:0] vga_slim_fz_1[0:monster_num-1],vga_slim_fz_3[0:monster_num-1],vga_slim_fz_5[0:monster_num-1],vga_slim_fz_7[0:monster_num-1],vga_slim_fz_9[0:monster_num-1];
    //update the signal with loop
    genvar slim_static_i;
    generate
        for (slim_static_i=0;slim_static_i<monster_num;slim_static_i=slim_static_i+1)begin:slim_static
            slim_static_1 slim_st_1f(.clka(clk),.addra(slim_st[slim_static_i]),.douta(vga_slim_st_1[slim_static_i]));
            slim_static_11 slim_st_11f(.clka(clk),.addra(slim_st[slim_static_i]),.douta(vga_slim_st_11[slim_static_i]));
            slim_static_13 slim_st_13f(.clka(clk),.addra(slim_st[slim_static_i]),.douta(vga_slim_st_13[slim_static_i]));
            slim_static_18 slim_st_18f(.clka(clk),.addra(slim_st[slim_static_i]),.douta(vga_slim_st_18[slim_static_i]));
            slim_static_20 slim_st_20f(.clka(clk),.addra(slim_st[slim_static_i]),.douta(vga_slim_st_20[slim_static_i]));
            slim_static_22 slim_st_22f(.clka(clk),.addra(slim_st[slim_static_i]),.douta(vga_slim_st_22[slim_static_i]));
            slim_static_24 slim_st_24f(.clka(clk),.addra(slim_st[slim_static_i]),.douta(vga_slim_st_24[slim_static_i]));
            slim_static_26 slim_st_26f(.clka(clk),.addra(slim_st[slim_static_i]),.douta(vga_slim_st_26[slim_static_i]));
            slim_static_28 slim_st_28f(.clka(clk),.addra(slim_st[slim_static_i]),.douta(vga_slim_st_28[slim_static_i]));
            slim_static_30 slim_st_30f(.clka(clk),.addra(slim_st[slim_static_i]),.douta(vga_slim_st_30[slim_static_i]));
            slim_static_32 slim_st_32f(.clka(clk),.addra(slim_st[slim_static_i]),.douta(vga_slim_st_32[slim_static_i]));
            slim_static_34 slim_st_34f(.clka(clk),.addra(slim_st[slim_static_i]),.douta(vga_slim_st_34[slim_static_i]));
            slim_static_36 slim_st_36f(.clka(clk),.addra(slim_st[slim_static_i]),.douta(vga_slim_st_36[slim_static_i]));
            slim_static_38 slim_st_38f(.clka(clk),.addra(slim_st[slim_static_i]),.douta(vga_slim_st_38[slim_static_i]));
        end
    endgenerate
    //update the signal with loop
    genvar slim_frozen_i;
    generate
        for (slim_frozen_i=0;slim_frozen_i<monster_num;slim_frozen_i=slim_frozen_i+1)begin:slim_frozen
            slim_frozen_1 slim_fz_1f(.clka(clk),.addra(slim_fz[slim_frozen_i]),.douta(vga_slim_fz_1[slim_frozen_i]));
            slim_frozen_3 slim_fz_3f(.clka(clk),.addra(slim_fz[slim_frozen_i]),.douta(vga_slim_fz_3[slim_frozen_i]));
            slim_frozen_5 slim_fz_5f(.clka(clk),.addra(slim_fz[slim_frozen_i]),.douta(vga_slim_fz_5[slim_frozen_i]));
            slim_frozen_7 slim_fz_7f(.clka(clk),.addra(slim_fz[slim_frozen_i]),.douta(vga_slim_fz_7[slim_frozen_i]));
            slim_frozen_9 slim_fz_9f(.clka(clk),.addra(slim_fz[slim_frozen_i]),.douta(vga_slim_fz_9[slim_frozen_i]));
        end
    endgenerate


    //雪花1像素值

    //renew the image
    reg [31:0]ipcnt;
    reg [4:0]ip_blue_st;
    reg [4:0]ip_blue_rwk;
    reg [7:0] ip_slim_st[0:monster_num-1];
    //这里便能控制单次刷新后保持不变
    always @(posedge clk) begin
        if(ipcnt == 6_000_000) begin  // 40ms*100M=4M，由于计数器只有3位，所以这里实例只能计数到500k，所以选用了40ms/5=8ms，即2.5*100k
            ipcnt <= 0;
            ip_blue_st <= ip_blue_st + 1;
            ip_slim1_st <= ip_slim1_st + 1;
            ip_slim2_st <= ip_slim2_st + 1;
            ip_blue_rwk <= ip_blue_rwk + 1;
        end
        else begin
            ipcnt <= ipcnt + 1;
        end
    end
    //assign the address to the vga
    genvar ground_show_i;
    generate
        for (ground_show_i=0;ground_show_i<ground_num;ground_show_i=ground_show_i+1)begin:ground_show
            ground_show ground_show_i(.clk(clk),.ipcnt(ipcnt),.ground(ground[ground_show_i]),.bk_touched(bk_touched[ground_show_i]),.vga_ground(vga_ground[ground_show_i]));
        end
    endgenerate
    //assign the address to the vga
    genvar snow_show_i;
    generate
        for (snow_show_i=0;snow_show_i<snowflake_num;snow_show_i=snow_show_i+1)begin:snow_show
            snow_show snow_show_i(.clk(clk),.ipcnt(ipcnt),.snow(snowf[snow_show_i]),.vga_snow(vga_snowf[snow_show_i]));
        end
    endgenerate
////////////////////////////////Assign the address of the photo to the address register//////////////////////////////

////////////////////////////////Image processing//////////////////////////////
    always@(posedge clk)begin
        //The rendering order is as follows:
        //1.背景
        if(col_addr_x>=0&&col_addr_x<=639&&row_addr_y>=0&&row_addr_y<=600)begin
            vga_data<=vga_bg[11:0];   
        end
        //2.方块
        for(i=0;i<ground_num;i=i+1)begin
            if(col_addr_x>=x_ground[i]&&col_addr_x<=x_ground[i]+27&&row_addr_y>=y_ground[i]&&row_addr_y<=y_ground[i]+41)begin
                if(vga_ground[i][11:0]!=0*256+2*16+8)begin
                    vga_data<=vga_ground[i][11:0];   
                end
            end
        end
        //3.树
        //4.小石块
        //5. snowflakes
        for(i=0;i<snowflake_num;i=i+1)begin
            if(col_addr_x>=x_snowf[i]&&col_addr_x<=x_snowf[i]+23&&row_addr_y>=y_snowf[i]&&row_addr_y<=y_snowf[i]+25)begin
                if(vga_snowf[i][11:0]!=0*256+2*16+8)begin
                    vga_data<=vga_snowf[i][11:0];   
                end
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

    //     //8.蓝色小人（筛选奔跑及删除背景色）47*43 028
    //     if(blue_state==2'd1&&col_addr_x>=x_blue&&col_addr_x<=x_blue+46&&row_addr_y>=y_blue&&row_addr_y<=y_blue+42)begin
    //         if(vga_blue_rwk[11:0]!=0*256+2*16+8)begin
    //             vga_data<=vga_blue_rwk[11:0];   
    //         end
    //     end
    end
////////////////////////////////Image processing//////////////////////////////

endmodule
