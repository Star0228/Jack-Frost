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
    //暂未使用>>>>>>>>>>>
    wire clk_total;
    reg isFinish;
    reg [31:0]score;
    reg [3:0]health;
    initial begin
        isFinish=0;
        score=32'b0;
        health=4'b0000;
    end
    wire [31:0]clk_240ms;
    clk_240ms clkm1(.clk(clk),.clk_240ms(clk_240ms));
    //暂未使用<<<<<<<<<<<<<

    reg [31:0] clkdiv;
    always@(posedge clk)begin
        clkdiv <= clkdiv+1'b1;
    end
    //photo's size 551*401
    reg [11:0]vga_data;
    wire [9:0]col_addr_x;
    wire [8:0]row_addr_y;
    vgac v1(.vga_clk(clkdiv[1]),.clrn(1'b1),.d_in(vga_data),.row_addr(row_addr_y),.col_addr(col_addr_x),.hs(hs),.vs(vs),.r(r),.g(g),.b(b));
    //坐标赋值
    //蓝色小人坐标
    reg [9:0]x_blue;
    reg [8:0]y_blue;
    reg [2:0]blue_state;
    //000->right static 001->right_walk ,  010->right_jump, 100->left static 101->left_walk ,  110->left_jump
    initial begin
        x_blue=10'd0;
        y_blue=9'd0;
        blue_state=2'd0;
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
        x_slim2=10'd96;
        y_slim2=9'd0;
    end
    //雪花1坐标
    reg [9:0] x_snowf1,x_snowf2,x_snowf3,x_snowf4,x_snowf5,x_snowf6,x_snowf7,x_snowf8,x_snowf9,x_snowf10,x_snowf11,x_snowf12,x_snowf13,x_snowf14,x_snowf15;
    reg [8:0] y_snowf1,y_snowf2,y_snowf3,y_snowf4,y_snowf5,y_snowf6,y_snowf7,y_snowf8,y_snowf9,y_snowf10,y_snowf11,y_snowf12,y_snowf13,y_snowf14,y_snowf15;
    
    initial begin
    // x_snowf1=x_snowf2=x_snowf3=x_snowf4=x_snowf5=x_snowf6=x_snowf7=x_snowf8=x_snowf9=x_snowf10=x_snowf11=x_snowf12=x_snowf13=x_snowf14=x_snowf15=10'd144;
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

    //地面方块模块
    // reg [499:0] x_ground;
    // reg [449:0] y_ground;
    // initial begin
    //     x_ground=500'd0;
    //     y_ground=450'd0;
    // end
    // relay_ground rg1(.clk(clk),.x_ground(x_ground),.y_ground(y_ground),.x_blue(x_blue), .y_blue(y_blue), .flag(flag));
    //可以依靠这个设计地图，不同的initial或是直接赋值，冰雪动画覆盖地面方块
    reg [9:0]x_ground1,x_ground2,x_ground3,x_ground4,x_ground5,x_ground6,x_ground7,x_ground8,x_ground9,x_ground10,x_ground11,x_ground12,x_ground13,x_ground14,x_ground15,x_ground16,x_ground17,x_ground18,x_ground19,x_ground20,x_ground21,x_ground22,x_ground23,x_ground24,x_ground25,x_ground26,x_ground27,x_ground28,x_ground29,x_ground30,x_ground31,x_ground32,x_ground33,x_ground34,x_ground35,x_ground36,x_ground37,x_ground38,x_ground39,x_ground40,x_ground41,x_ground42,x_ground43,x_ground44,x_ground45,x_ground46,x_ground47,x_ground48,x_ground49,x_ground50;
    reg [8:0]y_ground1,y_ground2,y_ground3,y_ground4,y_ground5,y_ground6,y_ground7,y_ground8,y_ground9,y_ground10,y_ground11,y_ground12,y_ground13,y_ground14,y_ground15,y_ground16,y_ground17,y_ground18,y_ground19,y_ground20,y_ground21,y_ground22,y_ground23,y_ground24,y_ground25,y_ground26,y_ground27,y_ground28,y_ground29,y_ground30,y_ground31,y_ground32,y_ground33,y_ground34,y_ground35,y_ground36,y_ground37,y_ground38,y_ground39,y_ground40,y_ground41,y_ground42,y_ground43,y_ground44,y_ground45,y_ground46,y_ground47,y_ground48,y_ground49,y_ground50;
    initial begin
        x_ground1 = 10'd0; y_ground1 = 9'd374;
        x_ground2 = 10'd28;y_ground2 = 9'd374;
        x_ground3 = 10'd56;y_ground3 = 9'd374;
        x_ground4 = 10'd84;y_ground4 = 9'd374;
        x_ground5 = 10'd112;y_ground5 = 9'd374;
        x_ground6 = 10'd140;y_ground6 = 9'd374;
        x_ground7 = 10'd168;y_ground7 = 9'd374;
        x_ground8 = 10'd196;y_ground8 = 9'd374;
        x_ground9 = 10'd224;y_ground9 = 9'd374;
        x_ground10 = 10'd252;y_ground10 = 9'd374;
        x_ground11 = 10'd280;y_ground11 = 9'd374;
        x_ground12 = 10'd308;y_ground12 = 9'd374;
        x_ground13 = 10'd336;y_ground13 = 9'd374;
        x_ground14 = 10'd364;y_ground14 = 9'd374;
        x_ground15 = 10'd392;y_ground15 = 9'd374;
        x_ground16 = 10'd420;y_ground16 = 9'd374;
        x_ground17 = 10'd448;y_ground17 = 9'd374;
        x_ground18 = 10'd476;y_ground18 = 9'd374;
        x_ground19 = 10'd504;y_ground19 = 9'd374;
        x_ground20 = 10'd0;y_ground20 = 9'd348;
        x_ground21 = 10'd28;y_ground21 = 9'd348;
        x_ground22 = 10'd56;y_ground22 = 9'd348;
        x_ground23 = 10'd84;y_ground23 = 9'd348;
        x_ground24 = 10'd112;y_ground24 = 9'd348;
        x_ground25 = 10'd140;y_ground25 = 9'd348;
        x_ground26 = 10'd168;y_ground26 = 9'd348;
        x_ground27 = 10'd196;y_ground27 = 9'd348;
        x_ground28 = 10'd224;y_ground28 = 9'd348;
        x_ground29 = 10'd252;y_ground29 = 9'd348;
        x_ground30 = 10'd280;y_ground30 = 9'd348;
        x_ground31 = 10'd308;y_ground31 = 9'd348;
        x_ground32 = 10'd336;y_ground32 = 9'd348;
        x_ground33 = 10'd364;y_ground33 = 9'd348;
        x_ground34 = 10'd392;y_ground34 = 9'd348;
        x_ground35 = 10'd420;y_ground35 = 9'd348;
        x_ground36 = 10'd448;y_ground36 = 9'd348;
        x_ground37 = 10'd476;y_ground37 = 9'd348;
        x_ground38 = 10'd504;y_ground38 = 9'd348;
        x_ground39 = 10'd0;y_ground39 = 9'd322;
        x_ground40 = 10'd28;y_ground40 = 9'd322;
        x_ground41 = 10'd56;y_ground41 = 9'd322;
        x_ground42 = 10'd84;y_ground42 = 9'd322;
    end

    ///逻辑模块↓↓↓↓↓↓↓↓↓↓
    //第一行是触发信号，逻辑模块实现对触发信号的赋值
    //1.方块变冰
    wire [49:0]bk_touched;//冰冻进行时信号
    // reg [49:0]bk_tc_finish;//冰冻完成信号
    // initial begin
    //     bk_tc_finish<=50'd0;
    // end
    dt_block_fz dt_block_fz1(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground1),.y_ground(y_ground1),.touched(bk_touched[0]));
    dt_block_fz dt_block_fz2(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground2),.y_ground(y_ground2),.touched(bk_touched[1]));
    dt_block_fz dt_block_fz3(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground3),.y_ground(y_ground3),.touched(bk_touched[2]));
    dt_block_fz dt_block_fz4(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground4),.y_ground(y_ground4),.touched(bk_touched[3]));
    dt_block_fz dt_block_fz5(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground5),.y_ground(y_ground5),.touched(bk_touched[4]));
    dt_block_fz dt_block_fz6(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground6),.y_ground(y_ground6),.touched(bk_touched[5]));
    dt_block_fz dt_block_fz7(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground7),.y_ground(y_ground7),.touched(bk_touched[6]));
    dt_block_fz dt_block_fz8(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground8),.y_ground(y_ground8),.touched(bk_touched[7]));
    dt_block_fz dt_block_fz9(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground9),.y_ground(y_ground9),.touched(bk_touched[8]));
    dt_block_fz dt_block_fz10(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground10),.y_ground(y_ground10),.touched(bk_touched[9]));
    dt_block_fz dt_block_fz11(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground11),.y_ground(y_ground11),.touched(bk_touched[10]));
    dt_block_fz dt_block_fz12(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground12),.y_ground(y_ground12),.touched(bk_touched[11]));
    dt_block_fz dt_block_fz13(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground13),.y_ground(y_ground13),.touched(bk_touched[12]));
    dt_block_fz dt_block_fz14(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground14),.y_ground(y_ground14),.touched(bk_touched[13]));
    dt_block_fz dt_block_fz15(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground15),.y_ground(y_ground15),.touched(bk_touched[14]));
    dt_block_fz dt_block_fz16(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground16),.y_ground(y_ground16),.touched(bk_touched[15]));
    dt_block_fz dt_block_fz17(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground17),.y_ground(y_ground17),.touched(bk_touched[16]));
    dt_block_fz dt_block_fz18(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground18),.y_ground(y_ground18),.touched(bk_touched[17]));
    dt_block_fz dt_block_fz19(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground19),.y_ground(y_ground19),.touched(bk_touched[18]));
    dt_block_fz dt_block_fz20(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground20),.y_ground(y_ground20),.touched(bk_touched[19]));
    dt_block_fz dt_block_fz21(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground21),.y_ground(y_ground21),.touched(bk_touched[20]));
    dt_block_fz dt_block_fz22(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground22),.y_ground(y_ground22),.touched(bk_touched[21]));
    dt_block_fz dt_block_fz23(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground23),.y_ground(y_ground23),.touched(bk_touched[22]));
    dt_block_fz dt_block_fz24(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground24),.y_ground(y_ground24),.touched(bk_touched[23]));
    dt_block_fz dt_block_fz25(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground25),.y_ground(y_ground25),.touched(bk_touched[24]));
    dt_block_fz dt_block_fz26(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground26),.y_ground(y_ground26),.touched(bk_touched[25]));
    dt_block_fz dt_block_fz27(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground27),.y_ground(y_ground27),.touched(bk_touched[26]));
    dt_block_fz dt_block_fz28(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground28),.y_ground(y_ground28),.touched(bk_touched[27]));
    dt_block_fz dt_block_fz29(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground29),.y_ground(y_ground29),.touched(bk_touched[28]));
    dt_block_fz dt_block_fz30(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground30),.y_ground(y_ground30),.touched(bk_touched[29]));
    dt_block_fz dt_block_fz31(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground31),.y_ground(y_ground31),.touched(bk_touched[30]));
    dt_block_fz dt_block_fz32(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground32),.y_ground(y_ground32),.touched(bk_touched[31]));
    dt_block_fz dt_block_fz33(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground33),.y_ground(y_ground33),.touched(bk_touched[32]));
    dt_block_fz dt_block_fz34(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground34),.y_ground(y_ground34),.touched(bk_touched[33]));
    dt_block_fz dt_block_fz35(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground35),.y_ground(y_ground35),.touched(bk_touched[34]));
    dt_block_fz dt_block_fz36(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground36),.y_ground(y_ground36),.touched(bk_touched[35]));
    dt_block_fz dt_block_fz37(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground37),.y_ground(y_ground37),.touched(bk_touched[36]));
    dt_block_fz dt_block_fz38(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground38),.y_ground(y_ground38),.touched(bk_touched[37]));
    dt_block_fz dt_block_fz39(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground39),.y_ground(y_ground39),.touched(bk_touched[38]));
    dt_block_fz dt_block_fz40(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground40),.y_ground(y_ground40),.touched(bk_touched[39]));
    dt_block_fz dt_block_fz41(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground41),.y_ground(y_ground41),.touched(bk_touched[40]));
    dt_block_fz dt_block_fz42(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground42),.y_ground(y_ground42),.touched(bk_touched[41]));
    dt_block_fz dt_block_fz43(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground43),.y_ground(y_ground43),.touched(bk_touched[42]));
    dt_block_fz dt_block_fz44(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground44),.y_ground(y_ground44),.touched(bk_touched[43]));
    dt_block_fz dt_block_fz45(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground45),.y_ground(y_ground45),.touched(bk_touched[44]));
    dt_block_fz dt_block_fz46(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground46),.y_ground(y_ground46),.touched(bk_touched[45]));
    dt_block_fz dt_block_fz47(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground47),.y_ground(y_ground47),.touched(bk_touched[46]));
    dt_block_fz dt_block_fz48(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground48),.y_ground(y_ground48),.touched(bk_touched[47]));
    dt_block_fz dt_block_fz49(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground49),.y_ground(y_ground49),.touched(bk_touched[48]));
    dt_block_fz dt_block_fz50(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground50),.y_ground(y_ground50),.touched(bk_touched[49]));
    //2.小蓝冻结slim
    wire fz_slim1,fz_slim2;
    // reg fz_sm1_fini,fz_sm2_fini;
    // initial begin
    //     fz_sm1_fini<=0;
    //     fz_sm2_fini<=0;
    // end
    dt_slim_fz dt_slim_fz1(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_slim(x_slim1),.y_slim(y_slim1),.frozen(fz_slim1));
    dt_slim_fz dt_slim_fz2(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_slim(x_slim2),.y_slim(y_slim2),.frozen(fz_slim2));
    //3.小蓝触碰slim会受伤
    //假定9个slim,寄存器>0==主角受伤,暂无研发受伤后无敌时间(有个小想法：我让wudi的寄存器最高位判断是不是在无敌状态)
    wire [9:0]bk_slim;
    reg wudi;
    dt_slim_bk dt_slim_bk1(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_slim(x_slim1),.y_slim(y_slim1),.isfrozen(fz_slim1),.broken(bk_slim[0]));
    dt_slim_bk dt_slim_bk2(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_slim(x_slim2),.y_slim(y_slim2),.isfrozen(fz_slim2),.broken(bk_slim[1]));
    always@(posedge clk)begin
        if(bk_slim&&!wudi)begin
            health<=health-4'd1;
            wudi<=1'b1;
            #3000;
            wudi<=1'b0;
        end
    end
    ///逻辑模块↑↑↑↑↑↑↑↑↑↑

    //地址赋值+各自vga输出
    //单张图片用wire，连续的要寄存器
    //背景1的地址寄存器和vga输出
    reg [18:0] bg;
    wire [11:0] vga_bg; 
    //蓝色小人静态图片的地址寄存器和vga输出
    reg [13:0]blue_st;
    reg [11:0]vga_blue_st;
    //蓝色小人向右奔跑的图片的地址寄存器和vga输出
    reg [13:0]blue_rwk;
    reg [11:0]vga_blue_rwk;
    //怪物1静止图片的地址寄存器和vga输出
    reg [11:0]vga_slim1_st;
    reg [13:0]slim1_st;
    //怪物2静止图片的地址寄存器和vga输出
    reg [11:0]vga_slim2_st;
    reg [13:0]slim2_st;
    //怪物1被冰冻的图片的地址寄存器和vga输出
    reg [11:0]vga_slim1_fz;
    reg [13:0]slim1_fz;
    //怪物2被冰冻的图片的地址寄存器和vga输出
    reg [11:0]vga_slim2_fz;
    reg [13:0]slim2_fz;
    //雪花的地址寄存器和vga输出
    wire [11:0]vga_snowf1,vga_snowf1,vga_snowf2,vga_snowf3,vga_snowf4,vga_snowf5,vga_snowf6,vga_snowf7,vga_snowf8,vga_snowf9,vga_snowf10,vga_snowf11,vga_snowf12,vga_snowf13,vga_snowf14,vga_snowf15;
    reg [10:0]snowf1,snowf2,snowf3,snowf4,snowf5,snowf6,snowf7,snowf8,snowf9,snowf10,snowf11,snowf12,snowf13,snowf14,snowf15;
    //地面方块的地址寄存器和vga输出（wire）
    reg [11:0]ground1,ground2,ground3,ground4,ground5,ground6,ground7,ground8,ground9,ground10,ground11,ground12,ground13,ground14,ground15,ground16,ground17,ground18,ground19,ground20,ground21,ground22,ground23,ground24,ground25,ground26,ground27,ground28,ground29,ground30,ground31,ground32,ground33,ground34,ground35,ground36,ground37,ground38,ground39,ground40,ground41,ground42,ground43,ground44,ground45,ground46,ground47,ground48,ground49,ground50;
    wire [11:0]vga_ground1,vga_ground2,vga_ground3,vga_ground4,vga_ground5,vga_ground6,vga_ground7,vga_ground8,vga_ground9,vga_ground10,vga_ground11,vga_ground12,vga_ground13,vga_ground14,vga_ground15,vga_ground16,vga_ground17,vga_ground18,vga_ground19,vga_ground20,vga_ground21,vga_ground22,vga_ground23,vga_ground24,vga_ground25,vga_ground26,vga_ground27,vga_ground28,vga_ground29,vga_ground30,vga_ground31,vga_ground32,vga_ground33,vga_ground34,vga_ground35,vga_ground36,vga_ground37,vga_ground38,vga_ground39,vga_ground40,vga_ground41,vga_ground42,vga_ground43,vga_ground44,vga_ground45,vga_ground46,vga_ground47,vga_ground48,vga_ground49,vga_ground50;

    //给照片地址赋值(判断框里面是即将显示的范围，尺寸是551*401，就填550+400，？后面的值是coe文件的像素点的地址0-size-1)
    always @(posedge clk)begin
        //背景551*401
        bg<= (col_addr_x>=0&&col_addr_x<=550&&row_addr_y>=0&&row_addr_y<=400)?(row_addr_y)*551+col_addr_x:0;
        //蓝色小人静态图片47*41（x_blue,y_blue）图片自带428的背景色
        blue_st<= (col_addr_x>=x_blue&&col_addr_x<=x_blue+46&&row_addr_y>=y_blue&&row_addr_y<=y_blue+40)?(row_addr_y-y_blue)*47+col_addr_x-x_blue:0;
        // //蓝色小人向右奔跑的图片47*43（x_blue,y_blue）图片自带028的背景色
        // blue_rwk<= (col_addr_x>=x_blue&&col_addr_x<=x_blue+46&&row_addr_y>=y_blue&&row_addr_y<=y_blue+42)?(row_addr_y-y_blue)*47+col_addr_x-x_blue:0;
        //怪物1静止62*36（x_slim1,y_slim1）图片自带028的背景色
        slim1_st<= (col_addr_x>=x_slim1&&col_addr_x<=x_slim1+61&&row_addr_y>=y_slim1&&row_addr_y<=y_slim1+35)?(row_addr_y-y_slim1)*62+col_addr_x-x_slim1:0;
        //怪物2静止62*36（x_slim2,y_slim2）图片自带028的背景色
        slim2_st<= (col_addr_x>=x_slim2&&col_addr_x<=x_slim2+61&&row_addr_y>=y_slim2&&row_addr_y<=y_slim2+35)?(row_addr_y-y_slim2)*62+col_addr_x-x_slim2:0;
        //怪物1冰冻50*51（x_slim1,y_slim1）图片自带028的背景色
        slim1_fz<= (col_addr_x>=x_slim1&&col_addr_x<=x_slim1+49&&row_addr_y>=y_slim1&&row_addr_y<=y_slim1+50)?(row_addr_y-y_slim1)*50+col_addr_x-x_slim1:0;
        //怪物2冰冻50*51（x_slim2,y_slim2）图片自带028的背景色
        slim2_fz<= (col_addr_x>=x_slim2&&col_addr_x<=x_slim2+49&&row_addr_y>=y_slim2&&row_addr_y<=y_slim2+50)?(row_addr_y-y_slim2)*50+col_addr_x-x_slim2:0;
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
        //地面方块28*42（x_ground1,y_ground1）图片自带028的背景色
        ground1<= (col_addr_x>=x_ground1&&col_addr_x<=x_ground1+27&&row_addr_y>=y_ground1&&row_addr_y<=y_ground1+41)?(row_addr_y-y_ground1)*28+col_addr_x-x_ground1:0;
        ground2<= (col_addr_x>=x_ground2&&col_addr_x<=x_ground2+27&&row_addr_y>=y_ground2&&row_addr_y<=y_ground2+41)?(row_addr_y-y_ground2)*28+col_addr_x-x_ground2:0;
        ground3<= (col_addr_x>=x_ground3&&col_addr_x<=x_ground3+27&&row_addr_y>=y_ground3&&row_addr_y<=y_ground3+41)?(row_addr_y-y_ground3)*28+col_addr_x-x_ground3:0;
        ground4<= (col_addr_x>=x_ground4&&col_addr_x<=x_ground4+27&&row_addr_y>=y_ground4&&row_addr_y<=y_ground4+41)?(row_addr_y-y_ground4)*28+col_addr_x-x_ground4:0;
        ground5<= (col_addr_x>=x_ground5&&col_addr_x<=x_ground5+27&&row_addr_y>=y_ground5&&row_addr_y<=y_ground5+41)?(row_addr_y-y_ground5)*28+col_addr_x-x_ground5:0;
        ground6<= (col_addr_x>=x_ground6&&col_addr_x<=x_ground6+27&&row_addr_y>=y_ground6&&row_addr_y<=y_ground6+41)?(row_addr_y-y_ground6)*28+col_addr_x-x_ground6:0;
        ground7<= (col_addr_x>=x_ground7&&col_addr_x<=x_ground7+27&&row_addr_y>=y_ground7&&row_addr_y<=y_ground7+41)?(row_addr_y-y_ground7)*28+col_addr_x-x_ground7:0;
        ground8<= (col_addr_x>=x_ground8&&col_addr_x<=x_ground8+27&&row_addr_y>=y_ground8&&row_addr_y<=y_ground8+41)?(row_addr_y-y_ground8)*28+col_addr_x-x_ground8:0;
        ground9<= (col_addr_x>=x_ground9&&col_addr_x<=x_ground9+27&&row_addr_y>=y_ground9&&row_addr_y<=y_ground9+41)?(row_addr_y-y_ground9)*28+col_addr_x-x_ground9:0;
        ground10<= (col_addr_x>=x_ground10&&col_addr_x<=x_ground10+27&&row_addr_y>=y_ground10&&row_addr_y<=y_ground10+41)?(row_addr_y-y_ground10)*28+col_addr_x-x_ground10:0;
        ground11<= (col_addr_x>=x_ground11&&col_addr_x<=x_ground11+27&&row_addr_y>=y_ground11&&row_addr_y<=y_ground11+41)?(row_addr_y-y_ground11)*28+col_addr_x-x_ground11:0;
        ground12<= (col_addr_x>=x_ground12&&col_addr_x<=x_ground12+27&&row_addr_y>=y_ground12&&row_addr_y<=y_ground12+41)?(row_addr_y-y_ground12)*28+col_addr_x-x_ground12:0;
        ground13<= (col_addr_x>=x_ground13&&col_addr_x<=x_ground13+27&&row_addr_y>=y_ground13&&row_addr_y<=y_ground13+41)?(row_addr_y-y_ground13)*28+col_addr_x-x_ground13:0;
        ground14<= (col_addr_x>=x_ground14&&col_addr_x<=x_ground14+27&&row_addr_y>=y_ground14&&row_addr_y<=y_ground14+41)?(row_addr_y-y_ground14)*28+col_addr_x-x_ground14:0;
        ground15<= (col_addr_x>=x_ground15&&col_addr_x<=x_ground15+27&&row_addr_y>=y_ground15&&row_addr_y<=y_ground15+41)?(row_addr_y-y_ground15)*28+col_addr_x-x_ground15:0;
        ground16<= (col_addr_x>=x_ground16&&col_addr_x<=x_ground16+27&&row_addr_y>=y_ground16&&row_addr_y<=y_ground16+41)?(row_addr_y-y_ground16)*28+col_addr_x-x_ground16:0;
        ground17<= (col_addr_x>=x_ground17&&col_addr_x<=x_ground17+27&&row_addr_y>=y_ground17&&row_addr_y<=y_ground17+41)?(row_addr_y-y_ground17)*28+col_addr_x-x_ground17:0;
        ground18<= (col_addr_x>=x_ground18&&col_addr_x<=x_ground18+27&&row_addr_y>=y_ground18&&row_addr_y<=y_ground18+41)?(row_addr_y-y_ground18)*28+col_addr_x-x_ground18:0;
        ground19<= (col_addr_x>=x_ground19&&col_addr_x<=x_ground19+27&&row_addr_y>=y_ground19&&row_addr_y<=y_ground19+41)?(row_addr_y-y_ground19)*28+col_addr_x-x_ground19:0;
        ground20<= (col_addr_x>=x_ground20&&col_addr_x<=x_ground20+27&&row_addr_y>=y_ground20&&row_addr_y<=y_ground20+41)?(row_addr_y-y_ground20)*28+col_addr_x-x_ground20:0;
        ground21<= (col_addr_x>=x_ground21&&col_addr_x<=x_ground21+27&&row_addr_y>=y_ground21&&row_addr_y<=y_ground21+41)?(row_addr_y-y_ground21)*28+col_addr_x-x_ground21:0;
        ground22<= (col_addr_x>=x_ground22&&col_addr_x<=x_ground22+27&&row_addr_y>=y_ground22&&row_addr_y<=y_ground22+41)?(row_addr_y-y_ground22)*28+col_addr_x-x_ground22:0;
        ground23<= (col_addr_x>=x_ground23&&col_addr_x<=x_ground23+27&&row_addr_y>=y_ground23&&row_addr_y<=y_ground23+41)?(row_addr_y-y_ground23)*28+col_addr_x-x_ground23:0;
        ground24<= (col_addr_x>=x_ground24&&col_addr_x<=x_ground24+27&&row_addr_y>=y_ground24&&row_addr_y<=y_ground24+41)?(row_addr_y-y_ground24)*28+col_addr_x-x_ground24:0;
        ground25<= (col_addr_x>=x_ground25&&col_addr_x<=x_ground25+27&&row_addr_y>=y_ground25&&row_addr_y<=y_ground25+41)?(row_addr_y-y_ground25)*28+col_addr_x-x_ground25:0;
        ground26<= (col_addr_x>=x_ground26&&col_addr_x<=x_ground26+27&&row_addr_y>=y_ground26&&row_addr_y<=y_ground26+41)?(row_addr_y-y_ground26)*28+col_addr_x-x_ground26:0;
        ground27<= (col_addr_x>=x_ground27&&col_addr_x<=x_ground27+27&&row_addr_y>=y_ground27&&row_addr_y<=y_ground27+41)?(row_addr_y-y_ground27)*28+col_addr_x-x_ground27:0;
        ground28<= (col_addr_x>=x_ground28&&col_addr_x<=x_ground28+27&&row_addr_y>=y_ground28&&row_addr_y<=y_ground28+41)?(row_addr_y-y_ground28)*28+col_addr_x-x_ground28:0;
        ground29<= (col_addr_x>=x_ground29&&col_addr_x<=x_ground29+27&&row_addr_y>=y_ground29&&row_addr_y<=y_ground29+41)?(row_addr_y-y_ground29)*28+col_addr_x-x_ground29:0;
        ground30<= (col_addr_x>=x_ground30&&col_addr_x<=x_ground30+27&&row_addr_y>=y_ground30&&row_addr_y<=y_ground30+41)?(row_addr_y-y_ground30)*28+col_addr_x-x_ground30:0;
        ground31<= (col_addr_x>=x_ground31&&col_addr_x<=x_ground31+27&&row_addr_y>=y_ground31&&row_addr_y<=y_ground31+41)?(row_addr_y-y_ground31)*28+col_addr_x-x_ground31:0;
        ground32<= (col_addr_x>=x_ground32&&col_addr_x<=x_ground32+27&&row_addr_y>=y_ground32&&row_addr_y<=y_ground32+41)?(row_addr_y-y_ground32)*28+col_addr_x-x_ground32:0;
        ground33<= (col_addr_x>=x_ground33&&col_addr_x<=x_ground33+27&&row_addr_y>=y_ground33&&row_addr_y<=y_ground33+41)?(row_addr_y-y_ground33)*28+col_addr_x-x_ground33:0;
        ground34<= (col_addr_x>=x_ground34&&col_addr_x<=x_ground34+27&&row_addr_y>=y_ground34&&row_addr_y<=y_ground34+41)?(row_addr_y-y_ground34)*28+col_addr_x-x_ground34:0;
        ground35<= (col_addr_x>=x_ground35&&col_addr_x<=x_ground35+27&&row_addr_y>=y_ground35&&row_addr_y<=y_ground35+41)?(row_addr_y-y_ground35)*28+col_addr_x-x_ground35:0;
        ground36<= (col_addr_x>=x_ground36&&col_addr_x<=x_ground36+27&&row_addr_y>=y_ground36&&row_addr_y<=y_ground36+41)?(row_addr_y-y_ground36)*28+col_addr_x-x_ground36:0;
        ground37<= (col_addr_x>=x_ground37&&col_addr_x<=x_ground37+27&&row_addr_y>=y_ground37&&row_addr_y<=y_ground37+41)?(row_addr_y-y_ground37)*28+col_addr_x-x_ground37:0;
        ground38<= (col_addr_x>=x_ground38&&col_addr_x<=x_ground38+27&&row_addr_y>=y_ground38&&row_addr_y<=y_ground38+41)?(row_addr_y-y_ground38)*28+col_addr_x-x_ground38:0;
        ground39<= (col_addr_x>=x_ground39&&col_addr_x<=x_ground39+27&&row_addr_y>=y_ground39&&row_addr_y<=y_ground39+41)?(row_addr_y-y_ground39)*28+col_addr_x-x_ground39:0;
        ground40<= (col_addr_x>=x_ground40&&col_addr_x<=x_ground40+27&&row_addr_y>=y_ground40&&row_addr_y<=y_ground40+41)?(row_addr_y-y_ground40)*28+col_addr_x-x_ground40:0;
        ground41<= (col_addr_x>=x_ground41&&col_addr_x<=x_ground41+27&&row_addr_y>=y_ground41&&row_addr_y<=y_ground41+41)?(row_addr_y-y_ground41)*28+col_addr_x-x_ground41:0;
        ground42<= (col_addr_x>=x_ground42&&col_addr_x<=x_ground42+27&&row_addr_y>=y_ground42&&row_addr_y<=y_ground42+41)?(row_addr_y-y_ground42)*28+col_addr_x-x_ground42:0;
        ground43<= (col_addr_x>=x_ground43&&col_addr_x<=x_ground43+27&&row_addr_y>=y_ground43&&row_addr_y<=y_ground43+41)?(row_addr_y-y_ground43)*28+col_addr_x-x_ground43:0;
        ground44<= (col_addr_x>=x_ground44&&col_addr_x<=x_ground44+27&&row_addr_y>=y_ground44&&row_addr_y<=y_ground44+41)?(row_addr_y-y_ground44)*28+col_addr_x-x_ground44:0;
        ground45<= (col_addr_x>=x_ground45&&col_addr_x<=x_ground45+27&&row_addr_y>=y_ground45&&row_addr_y<=y_ground45+41)?(row_addr_y-y_ground45)*28+col_addr_x-x_ground45:0;
        ground46<= (col_addr_x>=x_ground46&&col_addr_x<=x_ground46+27&&row_addr_y>=y_ground46&&row_addr_y<=y_ground46+41)?(row_addr_y-y_ground46)*28+col_addr_x-x_ground46:0;
        ground47<= (col_addr_x>=x_ground47&&col_addr_x<=x_ground47+27&&row_addr_y>=y_ground47&&row_addr_y<=y_ground47+41)?(row_addr_y-y_ground47)*28+col_addr_x-x_ground47:0;
        ground48<= (col_addr_x>=x_ground48&&col_addr_x<=x_ground48+27&&row_addr_y>=y_ground48&&row_addr_y<=y_ground48+41)?(row_addr_y-y_ground48)*28+col_addr_x-x_ground48:0;
        ground49<= (col_addr_x>=x_ground49&&col_addr_x<=x_ground49+27&&row_addr_y>=y_ground49&&row_addr_y<=y_ground49+41)?(row_addr_y-y_ground49)*28+col_addr_x-x_ground49:0;
        ground50<= (col_addr_x>=x_ground50&&col_addr_x<=x_ground50+27&&row_addr_y>=y_ground50&&row_addr_y<=y_ground50+41)?(row_addr_y-y_ground50)*28+col_addr_x-x_ground50:0;
    end

    //调用ip核输出背景像素值
    background bg2(.clka(clk),.addra(bg),.douta(vga_bg));



    //粘液怪物1静止像素值
    wire [11:0]vga_slim1_st_1,vga_slim1_st_11,vga_slim1_st_13,vga_slim1_st_18,vga_slim1_st_20,vga_slim1_st_22,vga_slim1_st_24,vga_slim1_st_26,vga_slim1_st_28,vga_slim1_st_30,vga_slim1_st_32,vga_slim1_st_34,vga_slim1_st_36,vga_slim1_st_38;
    slim_static_1 slim1_st_1f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_1));
    slim_static_11 slim1_st_11f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_11));
    slim_static_13 slim1_st_13f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_13));
    slim_static_18 slim1_st_18f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_18));
    slim_static_20 slim1_st_20f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_20));
    slim_static_22 slim1_st_22f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_22));
    slim_static_24 slim1_st_24f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_24));
    slim_static_26 slim1_st_26f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_26));
    slim_static_28 slim1_st_28f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_28));
    slim_static_30 slim1_st_30f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_30));
    slim_static_32 slim1_st_32f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_32));
    slim_static_34 slim1_st_34f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_34));
    slim_static_36 slim1_st_36f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_36));
    slim_static_38 slim1_st_38f(.clka(clk),.addra(slim1_st),.douta(vga_slim1_st_38));
    //粘液怪物2静止像素值
    wire [11:0]vga_slim2_st_1,vga_slim2_st_11,vga_slim2_st_13,vga_slim2_st_18,vga_slim2_st_20,vga_slim2_st_22,vga_slim2_st_24,vga_slim2_st_26,vga_slim2_st_28,vga_slim2_st_30,vga_slim2_st_32,vga_slim2_st_34,vga_slim2_st_36,vga_slim2_st_38;
    slim_static_1 slim2_st_1f(.clka(clk),.addra(slim2_st),.douta(vga_slim2_st_1));
    slim_static_11 slim2_st_11f(.clka(clk),.addra(slim2_st),.douta(vga_slim2_st_11));
    slim_static_13 slim2_st_13f(.clka(clk),.addra(slim2_st),.douta(vga_slim2_st_13));
    slim_static_18 slim2_st_18f(.clka(clk),.addra(slim2_st),.douta(vga_slim2_st_18));
    slim_static_20 slim2_st_20f(.clka(clk),.addra(slim2_st),.douta(vga_slim2_st_20));
    slim_static_22 slim2_st_22f(.clka(clk),.addra(slim2_st),.douta(vga_slim2_st_22));
    slim_static_24 slim2_st_24f(.clka(clk),.addra(slim2_st),.douta(vga_slim2_st_24));
    slim_static_26 slim2_st_26f(.clka(clk),.addra(slim2_st),.douta(vga_slim2_st_26));
    slim_static_28 slim2_st_28f(.clka(clk),.addra(slim2_st),.douta(vga_slim2_st_28));
    slim_static_30 slim2_st_30f(.clka(clk),.addra(slim2_st),.douta(vga_slim2_st_30));
    slim_static_32 slim2_st_32f(.clka(clk),.addra(slim2_st),.douta(vga_slim2_st_32));
    slim_static_34 slim2_st_34f(.clka(clk),.addra(slim2_st),.douta(vga_slim2_st_34));
    slim_static_36 slim2_st_36f(.clka(clk),.addra(slim2_st),.douta(vga_slim2_st_36));
    slim_static_38 slim2_st_38f(.clka(clk),.addra(slim2_st),.douta(vga_slim2_st_38));
    //粘液怪物1冰冻像素值
    wire [11:0]vga_slim1_fz_1,vga_slim1_fz_3,vga_slim1_fz_5,vga_slim1_fz_7,vga_slim1_fz_9;
    slim_frozen_1 slim1_fzf1(.clka(clk),.addra(slim1_fz),.douta(vga_slim1_fz_1));
    slim_frozen_3 slim1_fzf3(.clka(clk),.addra(slim1_fz),.douta(vga_slim1_fz_3));
    slim_frozen_5 slim1_fzf5(.clka(clk),.addra(slim1_fz),.douta(vga_slim1_fz_5));
    slim_frozen_7 slim1_fzf7(.clka(clk),.addra(slim1_fz),.douta(vga_slim1_fz_7));
    slim_frozen_9 slim1_fzf9(.clka(clk),.addra(slim1_fz),.douta(vga_slim1_fz_9));
    //粘液怪物2冰冻像素值
    wire [11:0]vga_slim2_fz_1,vga_slim2_fz_3,vga_slim2_fz_5,vga_slim2_fz_7,vga_slim2_fz_9;
    slim_frozen_1 slim2_fzf1(.clka(clk),.addra(slim2_fz),.douta(vga_slim2_fz_1));
    slim_frozen_3 slim2_fzf3(.clka(clk),.addra(slim2_fz),.douta(vga_slim2_fz_3));
    slim_frozen_5 slim2_fzf5(.clka(clk),.addra(slim2_fz),.douta(vga_slim2_fz_5));
    slim_frozen_7 slim2_fzf7(.clka(clk),.addra(slim2_fz),.douta(vga_slim2_fz_7));
    slim_frozen_9 slim2_fzf9(.clka(clk),.addra(slim2_fz),.douta(vga_slim2_fz_9));


    //雪花1像素值

    //方块像素值
    //方块被冰冻gif
    //我尝试直接加到显示模块


    //图片刷新
    reg [31:0]ipcnt;
    reg [4:0]ip_blue_st;
    reg [4:0]ip_blue_rwk;
    reg [7:0]ip_slim1_st;
    reg [7:0]ip_slim2_st;
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
    ///还没补完，待补！！！
        ///
        case(ip_blue_st)
            0: vga_blue_st <= vga_blue_st_1[11:0];
            1: vga_blue_st <= vga_blue_st_1[11:0];
            2: vga_blue_st <= vga_blue_st_1[11:0];
            3: vga_blue_st <= vga_blue_st_1[11:0];
            4: vga_blue_st <= vga_blue_st_2[11:0];
            5: vga_blue_st <= vga_blue_st_2[11:0];
            6: vga_blue_st <= vga_blue_st_2[11:0];
            7: vga_blue_st <= vga_blue_st_2[11:0];
            8: vga_blue_st <= vga_blue_st_3[11:0];
            9: vga_blue_st <= vga_blue_st_3[11:0];
            10: vga_blue_st <= vga_blue_st_3[11:0];
            11: vga_blue_st <= vga_blue_st_3[11:0];
            12: vga_blue_st <= vga_blue_st_4[11:0];
            13: vga_blue_st <= vga_blue_st_4[11:0];
            14: vga_blue_st <= vga_blue_st_4[11:0];
            15: vga_blue_st <= vga_blue_st_4[11:0];
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
//先试三个
ground_show ground1_show(.clk(clk),.ipcnt(ipcnt),.ground(ground1),.bk_touched(bk_touched[0]),.vga_ground(vga_ground1));
ground_show ground2_show(.clk(clk),.ipcnt(ipcnt),.ground(ground2),.bk_touched(bk_touched[1]),.vga_ground(vga_ground2));
ground_show ground3_show(.clk(clk),.ipcnt(ipcnt),.ground(ground3),.bk_touched(bk_touched[2]),.vga_ground(vga_ground3));
ground_show ground4_show(.clk(clk),.ipcnt(ipcnt),.ground(ground4),.bk_touched(bk_touched[3]),.vga_ground(vga_ground4));
ground_show ground5_show(.clk(clk),.ipcnt(ipcnt),.ground(ground5),.bk_touched(bk_touched[4]),.vga_ground(vga_ground5));
ground_show ground6_show(.clk(clk),.ipcnt(ipcnt),.ground(ground6),.bk_touched(bk_touched[5]),.vga_ground(vga_ground6));
ground_show ground7_show(.clk(clk),.ipcnt(ipcnt),.ground(ground7),.bk_touched(bk_touched[6]),.vga_ground(vga_ground7));
ground_show ground8_show(.clk(clk),.ipcnt(ipcnt),.ground(ground8),.bk_touched(bk_touched[7]),.vga_ground(vga_ground8));
ground_show ground9_show(.clk(clk),.ipcnt(ipcnt),.ground(ground9),.bk_touched(bk_touched[8]),.vga_ground(vga_ground9));
ground_show ground10_show(.clk(clk),.ipcnt(ipcnt),.ground(ground10),.bk_touched(bk_touched[9]),.vga_ground(vga_ground10));
snow_show snow_f1(.clk(clk),.ipcnt(ipcnt),.snow(snowf1),.vga_snow(vga_snowf1));
snow_show snow_f2(.clk(clk),.ipcnt(ipcnt),.snow(snowf2),.vga_snow(vga_snowf2));
snow_show snow_f3(.clk(clk),.ipcnt(ipcnt),.snow(snowf3),.vga_snow(vga_snowf3));
snow_show snow_f4(.clk(clk),.ipcnt(ipcnt),.snow(snowf4),.vga_snow(vga_snowf4));
snow_show snow_f5(.clk(clk),.ipcnt(ipcnt),.snow(snowf5),.vga_snow(vga_snowf5));



    //显示图片（循环播放）
    always@(posedge clk)begin
        //采用层刷的覆盖流
        //1.背景
        if(col_addr_x>=0&&col_addr_x<=639&&row_addr_y>=0&&row_addr_y<=600)begin
            vga_data<=vga_bg[11:0];   
        end
        //2.方块
        if(col_addr_x>=x_ground1&&col_addr_x<=x_ground1+27&&row_addr_y>=y_ground1&&row_addr_y<=y_ground1+41)begin
            if(vga_ground1[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground1[11:0];   
            end 
        end
        if(col_addr_x>=x_ground2&&col_addr_x<=x_ground2+27&&row_addr_y>=y_ground2&&row_addr_y<=y_ground2+41)begin
            if(vga_ground2[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground2[11:0];   
            end
        end
        if(col_addr_x>=x_ground3&&col_addr_x<=x_ground3+27&&row_addr_y>=y_ground3&&row_addr_y<=y_ground3+41)begin
            if(vga_ground3[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground3[11:0];   
            end
        end
        if(col_addr_x>=x_ground4&&col_addr_x<=x_ground4+27&&row_addr_y>=y_ground4&&row_addr_y<=y_ground4+41)begin
            if(vga_ground4[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground4[11:0];   
            end
        end
        if(col_addr_x>=x_ground5&&col_addr_x<=x_ground5+27&&row_addr_y>=y_ground5&&row_addr_y<=y_ground5+41)begin
            if(vga_ground5[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground5[11:0];   
            end
        end
        if(col_addr_x>=x_ground6&&col_addr_x<=x_ground6+27&&row_addr_y>=y_ground6&&row_addr_y<=y_ground6+41)begin
            if(vga_ground6[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground6[11:0];   
            end
        end
        if(col_addr_x>=x_ground7&&col_addr_x<=x_ground7+27&&row_addr_y>=y_ground7&&row_addr_y<=y_ground7+41)begin
            if(vga_ground7[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground7[11:0];   
            end
        end
        if(col_addr_x>=x_ground8&&col_addr_x<=x_ground8+27&&row_addr_y>=y_ground8&&row_addr_y<=y_ground8+41)begin
            if(vga_ground8[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground8[11:0];   
            end
        end
        if(col_addr_x>=x_ground9&&col_addr_x<=x_ground9+27&&row_addr_y>=y_ground9&&row_addr_y<=y_ground9+41)begin
            if(vga_ground9[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground9[11:0];   
            end
        end
        if(col_addr_x>=x_ground10&&col_addr_x<=x_ground10+27&&row_addr_y>=y_ground10&&row_addr_y<=y_ground10+41)begin
            if(vga_ground10[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground10[11:0];   
            end
        end
        // if(col_addr_x>=x_ground11&&col_addr_x<=x_ground11+27&&row_addr_y>=y_ground11&&row_addr_y<=y_ground11+41)begin
        //     if(vga_ground11[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground11[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground12&&col_addr_x<=x_ground12+27&&row_addr_y>=y_ground12&&row_addr_y<=y_ground12+41)begin
        //     if(vga_ground12[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground12[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground13&&col_addr_x<=x_ground13+27&&row_addr_y>=y_ground13&&row_addr_y<=y_ground13+41)begin
        //     if(vga_ground13[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground13[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground14&&col_addr_x<=x_ground14+27&&row_addr_y>=y_ground14&&row_addr_y<=y_ground14+41)begin
        //     if(vga_ground14[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground14[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground15&&col_addr_x<=x_ground15+27&&row_addr_y>=y_ground15&&row_addr_y<=y_ground15+41)begin
        //     if(vga_ground15[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground15[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground16&&col_addr_x<=x_ground16+27&&row_addr_y>=y_ground16&&row_addr_y<=y_ground16+41)begin
        //     if(vga_ground16[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground16[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground17&&col_addr_x<=x_ground17+27&&row_addr_y>=y_ground17&&row_addr_y<=y_ground17+41)begin
        //     if(vga_ground17[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground17[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground18&&col_addr_x<=x_ground18+27&&row_addr_y>=y_ground18&&row_addr_y<=y_ground18+41)begin
        //     if(vga_ground18[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground18[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground19&&col_addr_x<=x_ground19+27&&row_addr_y>=y_ground19&&row_addr_y<=y_ground19+41)begin
        //     if(vga_ground19[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground19[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground20&&col_addr_x<=x_ground20+27&&row_addr_y>=y_ground20&&row_addr_y<=y_ground20+41)begin
        //     if(vga_ground20[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground20[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground21&&col_addr_x<=x_ground21+27&&row_addr_y>=y_ground21&&row_addr_y<=y_ground21+41)begin
        //     if(vga_ground21[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground21[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground22&&col_addr_x<=x_ground22+27&&row_addr_y>=y_ground22&&row_addr_y<=y_ground22+41)begin
        //     if(vga_ground22[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground22[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground23&&col_addr_x<=x_ground23+27&&row_addr_y>=y_ground23&&row_addr_y<=y_ground23+41)begin
        //     if(vga_ground23[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground23[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground24&&col_addr_x<=x_ground24+27&&row_addr_y>=y_ground24&&row_addr_y<=y_ground24+41)begin
        //     if(vga_ground24[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground24[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground25&&col_addr_x<=x_ground25+27&&row_addr_y>=y_ground25&&row_addr_y<=y_ground25+41)begin
        //     if(vga_ground25[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground25[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground26&&col_addr_x<=x_ground26+27&&row_addr_y>=y_ground26&&row_addr_y<=y_ground26+41)begin
        //     if(vga_ground26[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground26[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground27&&col_addr_x<=x_ground27+27&&row_addr_y>=y_ground27&&row_addr_y<=y_ground27+41)begin
        //     if(vga_ground27[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground27[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground28&&col_addr_x<=x_ground28+27&&row_addr_y>=y_ground28&&row_addr_y<=y_ground28+41)begin
        //     if(vga_ground28[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground28[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground29&&col_addr_x<=x_ground29+27&&row_addr_y>=y_ground29&&row_addr_y<=y_ground29+41)begin
        //     if(vga_ground29[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground29[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground30&&col_addr_x<=x_ground30+27&&row_addr_y>=y_ground30&&row_addr_y<=y_ground30+41)begin
        //     if(vga_ground30[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground30[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground31&&col_addr_x<=x_ground31+27&&row_addr_y>=y_ground31&&row_addr_y<=y_ground31+41)begin
        //     if(vga_ground31[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground31[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground32&&col_addr_x<=x_ground32+27&&row_addr_y>=y_ground32&&row_addr_y<=y_ground32+41)begin
        //     if(vga_ground32[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground32[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground33&&col_addr_x<=x_ground33+27&&row_addr_y>=y_ground33&&row_addr_y<=y_ground33+41)begin
        //     if(vga_ground33[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground33[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground34&&col_addr_x<=x_ground34+27&&row_addr_y>=y_ground34&&row_addr_y<=y_ground34+41)begin
        //     if(vga_ground34[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground34[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground35&&col_addr_x<=x_ground35+27&&row_addr_y>=y_ground35&&row_addr_y<=y_ground35+41)begin
        //     if(vga_ground35[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground35[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground36&&col_addr_x<=x_ground36+27&&row_addr_y>=y_ground36&&row_addr_y<=y_ground36+41)begin
        //     if(vga_ground36[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground36[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground37&&col_addr_x<=x_ground37+27&&row_addr_y>=y_ground37&&row_addr_y<=y_ground37+41)begin
        //     if(vga_ground37[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground37[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground38&&col_addr_x<=x_ground38+27&&row_addr_y>=y_ground38&&row_addr_y<=y_ground38+41)begin
        //     if(vga_ground38[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground38[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground39&&col_addr_x<=x_ground39+27&&row_addr_y>=y_ground39&&row_addr_y<=y_ground39+41)begin
        //     if(vga_ground39[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground39[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground40&&col_addr_x<=x_ground40+27&&row_addr_y>=y_ground40&&row_addr_y<=y_ground40+41)begin
        //     if(vga_ground40[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground40[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground41&&col_addr_x<=x_ground41+27&&row_addr_y>=y_ground41&&row_addr_y<=y_ground41+41)begin
        //     if(vga_ground41[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground41[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground42&&col_addr_x<=x_ground42+27&&row_addr_y>=y_ground42&&row_addr_y<=y_ground42+41)begin
        //     if(vga_ground42[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground42[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground43&&col_addr_x<=x_ground43+27&&row_addr_y>=y_ground43&&row_addr_y<=y_ground43+41)begin
        //     if(vga_ground43[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground43[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground44&&col_addr_x<=x_ground44+27&&row_addr_y>=y_ground44&&row_addr_y<=y_ground44+41)begin
        //     if(vga_ground44[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground44[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground45&&col_addr_x<=x_ground45+27&&row_addr_y>=y_ground45&&row_addr_y<=y_ground45+41)begin
        //     if(vga_ground45[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground45[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground46&&col_addr_x<=x_ground46+27&&row_addr_y>=y_ground46&&row_addr_y<=y_ground46+41)begin
        //     if(vga_ground46[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground46[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground47&&col_addr_x<=x_ground47+27&&row_addr_y>=y_ground47&&row_addr_y<=y_ground47+41)begin
        //     if(vga_ground47[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground47[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground48&&col_addr_x<=x_ground48+27&&row_addr_y>=y_ground48&&row_addr_y<=y_ground48+41)begin
        //     if(vga_ground48[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground48[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground49&&col_addr_x<=x_ground49+27&&row_addr_y>=y_ground49&&row_addr_y<=y_ground49+41)begin
        //     if(vga_ground49[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground49[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_ground50&&col_addr_x<=x_ground50+27&&row_addr_y>=y_ground50&&row_addr_y<=y_ground50+41)begin
        //     if(vga_ground50[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_ground50[11:0];   
        //     end
        // end
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
        // if(col_addr_x>=x_snowf6&&col_addr_x<=x_snowf6+23&&row_addr_y>=y_snowf6&&row_addr_y<=y_snowf6+25)begin
        //     if(vga_snowf6[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_snowf6[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_snowf7&&col_addr_x<=x_snowf7+23&&row_addr_y>=y_snowf7&&row_addr_y<=y_snowf7+25)begin
        //     if(vga_snowf7[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_snowf7[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_snowf8&&col_addr_x<=x_snowf8+23&&row_addr_y>=y_snowf8&&row_addr_y<=y_snowf8+25)begin
        //     if(vga_snowf8[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_snowf8[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_snowf9&&col_addr_x<=x_snowf9+23&&row_addr_y>=y_snowf9&&row_addr_y<=y_snowf9+25)begin
        //     if(vga_snowf9[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_snowf9[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_snowf10&&col_addr_x<=x_snowf10+23&&row_addr_y>=y_snowf10&&row_addr_y<=y_snowf10+25)begin
        //     if(vga_snowf10[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_snowf10[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_snowf11&&col_addr_x<=x_snowf11+23&&row_addr_y>=y_snowf11&&row_addr_y<=y_snowf11+25)begin
        //     if(vga_snowf11[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_snowf11[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_snowf12&&col_addr_x<=x_snowf12+23&&row_addr_y>=y_snowf12&&row_addr_y<=y_snowf12+25)begin
        //     if(vga_snowf12[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_snowf12[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_snowf13&&col_addr_x<=x_snowf13+23&&row_addr_y>=y_snowf13&&row_addr_y<=y_snowf13+25)begin
        //     if(vga_snowf13[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_snowf13[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_snowf14&&col_addr_x<=x_snowf14+23&&row_addr_y>=y_snowf14&&row_addr_y<=y_snowf14+25)begin
        //     if(vga_snowf14[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_snowf14[11:0];   
        //     end
        // end
        // if(col_addr_x>=x_snowf15&&col_addr_x<=x_snowf15+23&&row_addr_y>=y_snowf15&&row_addr_y<=y_snowf15+25)begin
        //     if(vga_snowf15[11:0]!=0*256+2*16+8)begin
        //         vga_data<=vga_snowf15[11:0];   
        //     end
        // end

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


    endmodule