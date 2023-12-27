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
    reg [1:0]blue_state;
    //0->static    ,  1->walk,    2->jump, 
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
        x_slim1=10'd96;
        y_slim1=9'd0;
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
    reg [49:0]bk_tc_finish;//冰冻完成信号
    initial begin
        bk_tc_finish<=50'd0;
    end
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
    reg fz_sm1_fini,fz_sm2_fini;
    initial begin
        fz_sm1_fini<=0;
        fz_sm2_fini<=0;
    end
    dt_slim_fz dt_slim_fz1(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_slim(x_slim1),.y_slim(y_slim1),.frozen(fz_slim1));
    dt_slim_fz dt_slim_fz2(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_slim(x_slim2),.y_slim(y_slim2),.frozen(fz_slim2));
    //3.小蓝触碰slim会受伤
    //假定9个slim,寄存器>0==主角受伤,暂无研发受伤后无敌时间(有个小想法：我让10位的寄存器最高位判断是不是在无敌状态)
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
    reg [11:0]vga_snowf1,vga_snowf1,vga_snowf2,vga_snowf3,vga_snowf4,vga_snowf5,vga_snowf6,vga_snowf7,vga_snowf8,vga_snowf9,vga_snowf10,vga_snowf11,vga_snowf12,vga_snowf13,vga_snowf14,vga_snowf15;
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
        //蓝色小人向右奔跑的图片47*43（x_blue,y_blue）图片自带028的背景色
        blue_rwk<= (col_addr_x>=x_blue&&col_addr_x<=x_blue+46&&row_addr_y>=y_blue&&row_addr_y<=y_blue+42)?(row_addr_y-y_blue)*47+col_addr_x-x_blue:0;
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

    //调用ip核输出蓝色小人静态图片像素值
    wire [11:0]vga_blue_st_1,vga_blue_st_2,vga_blue_st_3,vga_blue_st_4;
    blue_static_1 blue_st_1f(.clka(clk),.addra(blue_st),.douta(vga_blue_st_1));
    blue_static_5 blue_st_2f(.clka(clk),.addra(blue_st),.douta(vga_blue_st_2));
    blue_static_9 blue_st_3f(.clka(clk),.addra(blue_st),.douta(vga_blue_st_3));
    blue_static_13 blue_st_4f(.clka(clk),.addra(blue_st),.douta(vga_blue_st_4));
    //蓝色小人向右奔跑的图片像素值

    wire [11:0]vga_blue_rwk_1,vga_blue_rwk_3,vga_blue_rwk_5,vga_blue_rwk_7,vga_blue_rwk_9,vga_blue_rwk_11,vga_blue_rwk_13,vga_blue_rwk_15;
    blue_r_walk_1 blue_rwk_1f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_1));
    blue_r_walk_3 blue_rwk_3f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_3));
    blue_r_walk_5 blue_rwk_5f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_5));
    blue_r_walk_7 blue_rwk_7f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_7));
    blue_r_walk_9 blue_rwk_9f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_9));
    blue_r_walk_11 blue_rwk_11f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_11));
    blue_r_walk_13 blue_rwk_13f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_13));
    blue_r_walk_15 blue_rwk_15f(.clka(clk),.addra(blue_rwk),.douta(vga_blue_rwk_15));


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
    reg [4:0]ip_snowf;
    //这里便能控制单次刷新后保持不变
    reg [4:0]ip_ground1,ip_ground2,ip_ground3,ip_ground4,ip_ground5,ip_ground6,ip_ground7,ip_ground8,ip_ground9,ip_ground10,ip_ground11,ip_ground12,ip_ground13,ip_ground14,ip_ground15,ip_ground16,ip_ground17,ip_ground18,ip_ground19,ip_ground20,ip_ground21,ip_ground22,ip_ground23,ip_ground24,ip_ground25,ip_ground26,ip_ground27,ip_ground28,ip_ground29,ip_ground30,ip_ground31,ip_ground32,ip_ground33,ip_ground34,ip_ground35,ip_ground36,ip_ground37,ip_ground38,ip_ground39,ip_ground40,ip_ground41,ip_ground42,ip_ground43,ip_ground44,ip_ground45,ip_ground46,ip_ground47,ip_ground48,ip_ground49,ip_ground50;
    always @(posedge clk) begin
        if(ipcnt == 6_000_000) begin  // 40ms*100M=4M，由于计数器只有3位，所以这里实例只能计数到500k，所以选用了40ms/5=8ms，即2.5*100k
            ipcnt <= 0;
            ip_blue_st <= ip_blue_st + 1;
            ip_slim1_st <= ip_slim1_st + 1;
            ip_slim2_st <= ip_slim2_st + 1;
            ip_blue_rwk <= ip_blue_rwk + 1;
            ip_snowf <= ip_snowf + 1;
            //方块冰冻显示
            if(bk_touched[0]&&!bk_tc_finish[0])begin
                ip_ground1 <= ip_ground1 + 1;
            end
            if(bk_touched[1]&&!bk_tc_finish[1])begin
                ip_ground2 <= ip_ground2 + 1;
            end


            ///上面是方块冰冻显示
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
            if(ip_snowf == 15) begin
            ip_snowf <= 0;  // 8个ip核循环16帧
            end
            else begin
                ipcnt <= ipcnt + 1;
            end
        end


        ///
        case(ip_ground1)
            0:begin 
            ground_1 ground1_1f(.clka(clk),.addra(ground1),.douta(vga_ground1));
            end
            3:begin
            ground_2 ground1_2f(.clka(clk),.addra(ground1),.douta(vga_ground1));
            end
            6:begin
            ground_3 ground1_3f(.clka(clk),.addra(ground1),.douta(vga_ground1));
            end
            9:begin
            ground_4 ground1_4f(.clka(clk),.addra(ground1),.douta(vga_ground1));
            end
            12:begin    
            ground_5 ground1_5f(.clka(clk),.addra(ground1),.douta(vga_ground1));
            end
            15:begin
            ground_6 ground1_6f(.clka(clk),.addra(ground1),.douta(vga_ground1));
            bk_tc_finish[0] <= 1;
            end
        endcase
        case(ip_ground2)
            0:begin 
            ground_1 ground2_1f(.clka(clk),.addra(ground2),.douta(vga_ground2));
            end
            3:begin
            ground_2 ground2_2f(.clka(clk),.addra(ground2),.douta(vga_ground2));
            end
            6:begin
            ground_3 ground2_3f(.clka(clk),.addra(ground2),.douta(vga_ground2));
            end
            9:begin
            ground_4 ground2_4f(.clka(clk),.addra(ground2),.douta(vga_ground2));
            end
            12:begin    
            ground_5 ground2_5f(.clka(clk),.addra(ground2),.douta(vga_ground2));
            end
            15:begin
            ground_6 ground2_6f(.clka(clk),.addra(ground2),.douta(vga_ground2));
            bk_tc_finish[1] <= 1;
            end
        endcase
        case(ip_ground3)
            0:begin 
            ground_1 ground3_1f(.clka(clk),.addra(ground3),.douta(vga_ground3));
            end
            3:begin
            ground_2 ground3_2f(.clka(clk),.addra(ground3),.douta(vga_ground3));
            end
            6:begin
            ground_3 ground3_3f(.clka(clk),.addra(ground3),.douta(vga_ground3));
            end
            9:begin
            ground_4 ground3_4f(.clka(clk),.addra(ground3),.douta(vga_ground3));
            end
            12:begin    
            ground_5 ground3_5f(.clka(clk),.addra(ground3),.douta(vga_ground3));
            end
            15:begin
            ground_6 ground3_6f(.clka(clk),.addra(ground3),.douta(vga_ground3));
            end
        endcase
        case(ip_ground4)
            0:begin 
            ground_1 ground4_1f(.clka(clk),.addra(ground4),.douta(vga_ground4));
            end
            3:begin
            ground_2 ground4_2f(.clka(clk),.addra(ground4),.douta(vga_ground4));
            end
            6:begin
            ground_3 ground4_3f(.clka(clk),.addra(ground4),.douta(vga_ground4));
            end
            9:begin
            ground_4 ground4_4f(.clka(clk),.addra(ground4),.douta(vga_ground4));
            end
            12:begin    
            ground_5 ground4_5f(.clka(clk),.addra(ground4),.douta(vga_ground4));
            end
            15:begin
            ground_6 ground4_6f(.clka(clk),.addra(ground4),.douta(vga_ground4));
            end
        endcase
        case(ip_ground5)
            0:begin 
            ground_1 ground5_1f(.clka(clk),.addra(ground5),.douta(vga_ground5));
            end
            3:begin
            ground_2 ground5_2f(.clka(clk),.addra(ground5),.douta(vga_ground5));
            end
            6:begin
            ground_3 ground5_3f(.clka(clk),.addra(ground5),.douta(vga_ground5));
            end
            9:begin
            ground_4 ground5_4f(.clka(clk),.addra(ground5),.douta(vga_ground5));
            end
            12:begin    
            ground_5 ground5_5f(.clka(clk),.addra(ground5),.douta(vga_ground5));
            end
            15:begin
            ground_6 ground5_6f(.clka(clk),.addra(ground5),.douta(vga_ground5));
            end
        endcase
        case(ip_ground6)
            0:begin 
            ground_1 ground6_1f(.clka(clk),.addra(ground6),.douta(vga_ground6));
            end
            3:begin
            ground_2 ground6_2f(.clka(clk),.addra(ground6),.douta(vga_ground6));
            end
            6:begin
            ground_3 ground6_3f(.clka(clk),.addra(ground6),.douta(vga_ground6));
            end
            9:begin
            ground_4 ground6_4f(.clka(clk),.addra(ground6),.douta(vga_ground6));
            end
            12:begin    
            ground_5 ground6_5f(.clka(clk),.addra(ground6),.douta(vga_ground6));
            end
            15:begin
            ground_6 ground6_6f(.clka(clk),.addra(ground6),.douta(vga_ground6));
            end
        endcase
        case(ip_ground7)
            0:begin 
            ground_1 ground7_1f(.clka(clk),.addra(ground7),.douta(vga_ground7));
            end
            3:begin
            ground_2 ground7_2f(.clka(clk),.addra(ground7),.douta(vga_ground7));
            end
            6:begin
            ground_3 ground7_3f(.clka(clk),.addra(ground7),.douta(vga_ground7));
            end
            9:begin
            ground_4 ground7_4f(.clka(clk),.addra(ground7),.douta(vga_ground7));
            end
            12:begin    
            ground_5 ground7_5f(.clka(clk),.addra(ground7),.douta(vga_ground7));
            end
            15:begin
            ground_6 ground7_6f(.clka(clk),.addra(ground7),.douta(vga_ground7));
            end
        endcase
        case(ip_ground8)
            0:begin 
            ground_1 ground8_1f(.clka(clk),.addra(ground8),.douta(vga_ground8));
            end
            3:begin
            ground_2 ground8_2f(.clka(clk),.addra(ground8),.douta(vga_ground8));
            end
            6:begin
            ground_3 ground8_3f(.clka(clk),.addra(ground8),.douta(vga_ground8));
            end
            9:begin
            ground_4 ground8_4f(.clka(clk),.addra(ground8),.douta(vga_ground8));
            end
            12:begin    
            ground_5 ground8_5f(.clka(clk),.addra(ground8),.douta(vga_ground8));
            end
            15:begin
            ground_6 ground8_6f(.clka(clk),.addra(ground8),.douta(vga_ground8));
            end
        endcase
        case(ip_ground9)
            0:begin 
            ground_1 ground9_1f(.clka(clk),.addra(ground9),.douta(vga_ground9));
            end
            3:begin
            ground_2 ground9_2f(.clka(clk),.addra(ground9),.douta(vga_ground9));
            end
            6:begin
            ground_3 ground9_3f(.clka(clk),.addra(ground9),.douta(vga_ground9));
            end
            9:begin
            ground_4 ground9_4f(.clka(clk),.addra(ground9),.douta(vga_ground9));
            end
            12:begin    
            ground_5 ground9_5f(.clka(clk),.addra(ground9),.douta(vga_ground9));
            end
            15:begin
            ground_6 ground9_6f(.clka(clk),.addra(ground9),.douta(vga_ground9));
            end
        endcase
        case(ip_ground10)
            0:begin 
            ground_1 ground10_1f(.clka(clk),.addra(ground10),.douta(vga_ground10));
            end
            3:begin
            ground_2 ground10_2f(.clka(clk),.addra(ground10),.douta(vga_ground10));
            end
            6:begin
            ground_3 ground10_3f(.clka(clk),.addra(ground10),.douta(vga_ground10));
            end
            9:begin
            ground_4 ground10_4f(.clka(clk),.addra(ground10),.douta(vga_ground10));
            end
            12:begin    
            ground_5 ground10_5f(.clka(clk),.addra(ground10),.douta(vga_ground10));
            end
            15:begin
            ground_6 ground10_6f(.clka(clk),.addra(ground10),.douta(vga_ground10));
            end
        endcase
        case(ip_ground11)
            0:begin 
            ground_1 ground11_1f(.clka(clk),.addra(ground11),.douta(vga_ground11));
            end
            3:begin
            ground_2 ground11_2f(.clka(clk),.addra(ground11),.douta(vga_ground11));
            end
            6:begin
            ground_3 ground11_3f(.clka(clk),.addra(ground11),.douta(vga_ground11));
            end
            9:begin
            ground_4 ground11_4f(.clka(clk),.addra(ground11),.douta(vga_ground11));
            end
            12:begin    
            ground_5 ground11_5f(.clka(clk),.addra(ground11),.douta(vga_ground11));
            end
            15:begin
            ground_6 ground11_6f(.clka(clk),.addra(ground11),.douta(vga_ground11));
            end
        endcase
        case(ip_ground12)
            0:begin 
            ground_1 ground12_1f(.clka(clk),.addra(ground12),.douta(vga_ground12));
            end
            3:begin
            ground_2 ground12_2f(.clka(clk),.addra(ground12),.douta(vga_ground12));
            end
            6:begin
            ground_3 ground12_3f(.clka(clk),.addra(ground12),.douta(vga_ground12));
            end
            9:begin
            ground_4 ground12_4f(.clka(clk),.addra(ground12),.douta(vga_ground12));
            end
            12:begin    
            ground_5 ground12_5f(.clka(clk),.addra(ground12),.douta(vga_ground12));
            end
            15:begin
            ground_6 ground12_6f(.clka(clk),.addra(ground12),.douta(vga_ground12));
            end
        endcase
        case(ip_ground13)
            0:begin 
            ground_1 ground13_1f(.clka(clk),.addra(ground13),.douta(vga_ground13));
            end
            3:begin
            ground_2 ground13_2f(.clka(clk),.addra(ground13),.douta(vga_ground13));
            end
            6:begin
            ground_3 ground13_3f(.clka(clk),.addra(ground13),.douta(vga_ground13));
            end
            9:begin
            ground_4 ground13_4f(.clka(clk),.addra(ground13),.douta(vga_ground13));
            end
            12:begin    
            ground_5 ground13_5f(.clka(clk),.addra(ground13),.douta(vga_ground13));
            end
            15:begin
            ground_6 ground13_6f(.clka(clk),.addra(ground13),.douta(vga_ground13));
            end
        endcase
        case(ip_ground14)
            0:begin 
            ground_1 ground14_1f(.clka(clk),.addra(ground14),.douta(vga_ground14));
            end
            3:begin
            ground_2 ground14_2f(.clka(clk),.addra(ground14),.douta(vga_ground14));
            end
            6:begin
            ground_3 ground14_3f(.clka(clk),.addra(ground14),.douta(vga_ground14));
            end
            9:begin
            ground_4 ground14_4f(.clka(clk),.addra(ground14),.douta(vga_ground14));
            end
            12:begin    
            ground_5 ground14_5f(.clka(clk),.addra(ground14),.douta(vga_ground14));
            end
            15:begin
            ground_6 ground14_6f(.clka(clk),.addra(ground14),.douta(vga_ground14));
            end
        endcase
        case(ip_ground15)
            0:begin 
            ground_1 ground15_1f(.clka(clk),.addra(ground15),.douta(vga_ground15));
            end
            3:begin
            ground_2 ground15_2f(.clka(clk),.addra(ground15),.douta(vga_ground15));
            end
            6:begin
            ground_3 ground15_3f(.clka(clk),.addra(ground15),.douta(vga_ground15));
            end
            9:begin
            ground_4 ground15_4f(.clka(clk),.addra(ground15),.douta(vga_ground15));
            end
            12:begin    
            ground_5 ground15_5f(.clka(clk),.addra(ground15),.douta(vga_ground15));
            end
            15:begin
            ground_6 ground15_6f(.clka(clk),.addra(ground15),.douta(vga_ground15));
            end
        endcase
        case(ip_ground16)
            0:begin 
            ground_1 ground16_1f(.clka(clk),.addra(ground16),.douta(vga_ground16));
            end
            3:begin
            ground_2 ground16_2f(.clka(clk),.addra(ground16),.douta(vga_ground16));
            end
            6:begin
            ground_3 ground16_3f(.clka(clk),.addra(ground16),.douta(vga_ground16));
            end
            9:begin
            ground_4 ground16_4f(.clka(clk),.addra(ground16),.douta(vga_ground16));
            end
            12:begin    
            ground_5 ground16_5f(.clka(clk),.addra(ground16),.douta(vga_ground16));
            end
            15:begin
            ground_6 ground16_6f(.clka(clk),.addra(ground16),.douta(vga_ground16));
            end
        endcase
        case(ip_ground17)
            0:begin 
            ground_1 ground17_1f(.clka(clk),.addra(ground17),.douta(vga_ground17));
            end
            3:begin
            ground_2 ground17_2f(.clka(clk),.addra(ground17),.douta(vga_ground17));
            end
            6:begin
            ground_3 ground17_3f(.clka(clk),.addra(ground17),.douta(vga_ground17));
            end
            9:begin
            ground_4 ground17_4f(.clka(clk),.addra(ground17),.douta(vga_ground17));
            end
            12:begin    
            ground_5 ground17_5f(.clka(clk),.addra(ground17),.douta(vga_ground17));
            end
            15:begin
            ground_6 ground17_6f(.clka(clk),.addra(ground17),.douta(vga_ground17));
            end
        endcase
        case(ip_ground18)
            0:begin 
            ground_1 ground18_1f(.clka(clk),.addra(ground18),.douta(vga_ground18));
            end
            3:begin
            ground_2 ground18_2f(.clka(clk),.addra(ground18),.douta(vga_ground18));
            end
            6:begin
            ground_3 ground18_3f(.clka(clk),.addra(ground18),.douta(vga_ground18));
            end
            9:begin
            ground_4 ground18_4f(.clka(clk),.addra(ground18),.douta(vga_ground18));
            end
            12:begin    
            ground_5 ground18_5f(.clka(clk),.addra(ground18),.douta(vga_ground18));
            end
            15:begin
            ground_6 ground18_6f(.clka(clk),.addra(ground18),.douta(vga_ground18));
            end
        endcase
        case(ip_ground19)
            0:begin 
            ground_1 ground19_1f(.clka(clk),.addra(ground19),.douta(vga_ground19));
            end
            3:begin
            ground_2 ground19_2f(.clka(clk),.addra(ground19),.douta(vga_ground19));
            end
            6:begin
            ground_3 ground19_3f(.clka(clk),.addra(ground19),.douta(vga_ground19));
            end
            9:begin
            ground_4 ground19_4f(.clka(clk),.addra(ground19),.douta(vga_ground19));
            end
            12:begin    
            ground_5 ground19_5f(.clka(clk),.addra(ground19),.douta(vga_ground19));
            end
            15:begin
            ground_6 ground19_6f(.clka(clk),.addra(ground19),.douta(vga_ground19));
            end
        endcase
        case(ip_ground20)
            0:begin 
            ground_1 ground20_1f(.clka(clk),.addra(ground20),.douta(vga_ground20));
            end
            3:begin
            ground_2 ground20_2f(.clka(clk),.addra(ground20),.douta(vga_ground20));
            end
            6:begin
            ground_3 ground20_3f(.clka(clk),.addra(ground20),.douta(vga_ground20));
            end
            9:begin
            ground_4 ground20_4f(.clka(clk),.addra(ground20),.douta(vga_ground20));
            end
            12:begin    
            ground_5 ground20_5f(.clka(clk),.addra(ground20),.douta(vga_ground20));
            end
            15:begin
            ground_6 ground20_6f(.clka(clk),.addra(ground20),.douta(vga_ground20));
            end
        endcase
        case(ip_ground21)
            0:begin 
            ground_1 ground21_1f(.clka(clk),.addra(ground21),.douta(vga_ground21));
            end
            3:begin
            ground_2 ground21_2f(.clka(clk),.addra(ground21),.douta(vga_ground21));
            end
            6:begin
            ground_3 ground21_3f(.clka(clk),.addra(ground21),.douta(vga_ground21));
            end
            9:begin
            ground_4 ground21_4f(.clka(clk),.addra(ground21),.douta(vga_ground21));
            end
            12:begin    
            ground_5 ground21_5f(.clka(clk),.addra(ground21),.douta(vga_ground21));
            end
            15:begin
            ground_6 ground21_6f(.clka(clk),.addra(ground21),.douta(vga_ground21));
            end
        endcase
        case(ip_ground22)
            0:begin 
            ground_1 ground22_1f(.clka(clk),.addra(ground22),.douta(vga_ground22));
            end
            3:begin
            ground_2 ground22_2f(.clka(clk),.addra(ground22),.douta(vga_ground22));
            end
            6:begin
            ground_3 ground22_3f(.clka(clk),.addra(ground22),.douta(vga_ground22));
            end
            9:begin
            ground_4 ground22_4f(.clka(clk),.addra(ground22),.douta(vga_ground22));
            end
            12:begin    
            ground_5 ground22_5f(.clka(clk),.addra(ground22),.douta(vga_ground22));
            end
            15:begin
            ground_6 ground22_6f(.clka(clk),.addra(ground22),.douta(vga_ground22));
            end
        endcase
        case(ip_ground23)
            0:begin 
            ground_1 ground23_1f(.clka(clk),.addra(ground23),.douta(vga_ground23));
            end
            3:begin
            ground_2 ground23_2f(.clka(clk),.addra(ground23),.douta(vga_ground23));
            end
            6:begin
            ground_3 ground23_3f(.clka(clk),.addra(ground23),.douta(vga_ground23));
            end
            9:begin
            ground_4 ground23_4f(.clka(clk),.addra(ground23),.douta(vga_ground23));
            end
            12:begin    
            ground_5 ground23_5f(.clka(clk),.addra(ground23),.douta(vga_ground23));
            end
            15:begin
            ground_6 ground23_6f(.clka(clk),.addra(ground23),.douta(vga_ground23));
            end
        endcase
        case(ip_ground24)
            0:begin 
            ground_1 ground24_1f(.clka(clk),.addra(ground24),.douta(vga_ground24));
            end
            3:begin
            ground_2 ground24_2f(.clka(clk),.addra(ground24),.douta(vga_ground24));
            end
            6:begin
            ground_3 ground24_3f(.clka(clk),.addra(ground24),.douta(vga_ground24));
            end
            9:begin
            ground_4 ground24_4f(.clka(clk),.addra(ground24),.douta(vga_ground24));
            end
            12:begin    
            ground_5 ground24_5f(.clka(clk),.addra(ground24),.douta(vga_ground24));
            end
            15:begin
            ground_6 ground24_6f(.clka(clk),.addra(ground24),.douta(vga_ground24));
            end
        endcase
        case(ip_ground25)
            0:begin 
            ground_1 ground25_1f(.clka(clk),.addra(ground25),.douta(vga_ground25));
            end
            3:begin
            ground_2 ground25_2f(.clka(clk),.addra(ground25),.douta(vga_ground25));
            end
            6:begin
            ground_3 ground25_3f(.clka(clk),.addra(ground25),.douta(vga_ground25));
            end
            9:begin
            ground_4 ground25_4f(.clka(clk),.addra(ground25),.douta(vga_ground25));
            end
            12:begin    
            ground_5 ground25_5f(.clka(clk),.addra(ground25),.douta(vga_ground25));
            end
            15:begin
            ground_6 ground25_6f(.clka(clk),.addra(ground25),.douta(vga_ground25));
            end
        endcase
        case(ip_ground26)
            0:begin 
            ground_1 ground26_1f(.clka(clk),.addra(ground26),.douta(vga_ground26));
            end
            3:begin
            ground_2 ground26_2f(.clka(clk),.addra(ground26),.douta(vga_ground26));
            end
            6:begin
            ground_3 ground26_3f(.clka(clk),.addra(ground26),.douta(vga_ground26));
            end
            9:begin
            ground_4 ground26_4f(.clka(clk),.addra(ground26),.douta(vga_ground26));
            end
            12:begin    
            ground_5 ground26_5f(.clka(clk),.addra(ground26),.douta(vga_ground26));
            end
            15:begin
            ground_6 ground26_6f(.clka(clk),.addra(ground26),.douta(vga_ground26));
            end
        endcase
        case(ip_ground27)
            0:begin 
            ground_1 ground27_1f(.clka(clk),.addra(ground27),.douta(vga_ground27));
            end
            3:begin
            ground_2 ground27_2f(.clka(clk),.addra(ground27),.douta(vga_ground27));
            end
            6:begin
            ground_3 ground27_3f(.clka(clk),.addra(ground27),.douta(vga_ground27));
            end
            9:begin
            ground_4 ground27_4f(.clka(clk),.addra(ground27),.douta(vga_ground27));
            end
            12:begin    
            ground_5 ground27_5f(.clka(clk),.addra(ground27),.douta(vga_ground27));
            end
            15:begin
            ground_6 ground27_6f(.clka(clk),.addra(ground27),.douta(vga_ground27));
            end
        endcase
        case(ip_ground28)
            0:begin 
            ground_1 ground28_1f(.clka(clk),.addra(ground28),.douta(vga_ground28));
            end
            3:begin
            ground_2 ground28_2f(.clka(clk),.addra(ground28),.douta(vga_ground28));
            end
            6:begin
            ground_3 ground28_3f(.clka(clk),.addra(ground28),.douta(vga_ground28));
            end
            9:begin
            ground_4 ground28_4f(.clka(clk),.addra(ground28),.douta(vga_ground28));
            end
            12:begin    
            ground_5 ground28_5f(.clka(clk),.addra(ground28),.douta(vga_ground28));
            end
            15:begin
            ground_6 ground28_6f(.clka(clk),.addra(ground28),.douta(vga_ground28));
            end
        endcase
        case(ip_ground29)
            0:begin 
            ground_1 ground29_1f(.clka(clk),.addra(ground29),.douta(vga_ground29));
            end
            3:begin
            ground_2 ground29_2f(.clka(clk),.addra(ground29),.douta(vga_ground29));
            end
            6:begin
            ground_3 ground29_3f(.clka(clk),.addra(ground29),.douta(vga_ground29));
            end
            9:begin
            ground_4 ground29_4f(.clka(clk),.addra(ground29),.douta(vga_ground29));
            end
            12:begin    
            ground_5 ground29_5f(.clka(clk),.addra(ground29),.douta(vga_ground29));
            end
            15:begin
            ground_6 ground29_6f(.clka(clk),.addra(ground29),.douta(vga_ground29));
            end
        endcase
        case(ip_ground30)
            0:begin 
            ground_1 ground30_1f(.clka(clk),.addra(ground30),.douta(vga_ground30));
            end
            3:begin
            ground_2 ground30_2f(.clka(clk),.addra(ground30),.douta(vga_ground30));
            end
            6:begin
            ground_3 ground30_3f(.clka(clk),.addra(ground30),.douta(vga_ground30));
            end
            9:begin
            ground_4 ground30_4f(.clka(clk),.addra(ground30),.douta(vga_ground30));
            end
            12:begin    
            ground_5 ground30_5f(.clka(clk),.addra(ground30),.douta(vga_ground30));
            end
            15:begin
            ground_6 ground30_6f(.clka(clk),.addra(ground30),.douta(vga_ground30));
            end
        endcase
        case(ip_ground31)
            0:begin 
            ground_1 ground31_1f(.clka(clk),.addra(ground31),.douta(vga_ground31));
            end
            3:begin
            ground_2 ground31_2f(.clka(clk),.addra(ground31),.douta(vga_ground31));
            end
            6:begin
            ground_3 ground31_3f(.clka(clk),.addra(ground31),.douta(vga_ground31));
            end
            9:begin
            ground_4 ground31_4f(.clka(clk),.addra(ground31),.douta(vga_ground31));
            end
            12:begin    
            ground_5 ground31_5f(.clka(clk),.addra(ground31),.douta(vga_ground31));
            end
            15:begin
            ground_6 ground31_6f(.clka(clk),.addra(ground31),.douta(vga_ground31));
            end
        endcase
        case(ip_ground32)
            0:begin 
            ground_1 ground32_1f(.clka(clk),.addra(ground32),.douta(vga_ground32));
            end
            3:begin
            ground_2 ground32_2f(.clka(clk),.addra(ground32),.douta(vga_ground32));
            end
            6:begin
            ground_3 ground32_3f(.clka(clk),.addra(ground32),.douta(vga_ground32));
            end
            9:begin
            ground_4 ground32_4f(.clka(clk),.addra(ground32),.douta(vga_ground32));
            end
            12:begin    
            ground_5 ground32_5f(.clka(clk),.addra(ground32),.douta(vga_ground32));
            end
            15:begin
            ground_6 ground32_6f(.clka(clk),.addra(ground32),.douta(vga_ground32));
            end
        endcase
        case(ip_ground33)
            0:begin 
            ground_1 ground33_1f(.clka(clk),.addra(ground33),.douta(vga_ground33));
            end
            3:begin
            ground_2 ground33_2f(.clka(clk),.addra(ground33),.douta(vga_ground33));
            end
            6:begin
            ground_3 ground33_3f(.clka(clk),.addra(ground33),.douta(vga_ground33));
            end
            9:begin
            ground_4 ground33_4f(.clka(clk),.addra(ground33),.douta(vga_ground33));
            end
            12:begin    
            ground_5 ground33_5f(.clka(clk),.addra(ground33),.douta(vga_ground33));
            end
            15:begin
            ground_6 ground33_6f(.clka(clk),.addra(ground33),.douta(vga_ground33));
            end
        endcase
        case(ip_ground34)
            0:begin 
            ground_1 ground34_1f(.clka(clk),.addra(ground34),.douta(vga_ground34));
            end
            3:begin
            ground_2 ground34_2f(.clka(clk),.addra(ground34),.douta(vga_ground34));
            end
            6:begin
            ground_3 ground34_3f(.clka(clk),.addra(ground34),.douta(vga_ground34));
            end
            9:begin
            ground_4 ground34_4f(.clka(clk),.addra(ground34),.douta(vga_ground34));
            end
            12:begin    
            ground_5 ground34_5f(.clka(clk),.addra(ground34),.douta(vga_ground34));
            end
            15:begin
            ground_6 ground34_6f(.clka(clk),.addra(ground34),.douta(vga_ground34));
            end
        endcase
        case(ip_ground35)
            0:begin 
            ground_1 ground35_1f(.clka(clk),.addra(ground35),.douta(vga_ground35));
            end
            3:begin
            ground_2 ground35_2f(.clka(clk),.addra(ground35),.douta(vga_ground35));
            end
            6:begin
            ground_3 ground35_3f(.clka(clk),.addra(ground35),.douta(vga_ground35));
            end
            9:begin
            ground_4 ground35_4f(.clka(clk),.addra(ground35),.douta(vga_ground35));
            end
            12:begin    
            ground_5 ground35_5f(.clka(clk),.addra(ground35),.douta(vga_ground35));
            end
            15:begin
            ground_6 ground35_6f(.clka(clk),.addra(ground35),.douta(vga_ground35));
            end
        endcase
        case(ip_ground36)
            0:begin 
            ground_1 ground36_1f(.clka(clk),.addra(ground36),.douta(vga_ground36));
            end
            3:begin
            ground_2 ground36_2f(.clka(clk),.addra(ground36),.douta(vga_ground36));
            end
            6:begin
            ground_3 ground36_3f(.clka(clk),.addra(ground36),.douta(vga_ground36));
            end
            9:begin
            ground_4 ground36_4f(.clka(clk),.addra(ground36),.douta(vga_ground36));
            end
            12:begin    
            ground_5 ground36_5f(.clka(clk),.addra(ground36),.douta(vga_ground36));
            end
            15:begin
            ground_6 ground36_6f(.clka(clk),.addra(ground36),.douta(vga_ground36));
            end
        endcase
        case(ip_ground37)
            0:begin 
            ground_1 ground37_1f(.clka(clk),.addra(ground37),.douta(vga_ground37));
            end
            3:begin
            ground_2 ground37_2f(.clka(clk),.addra(ground37),.douta(vga_ground37));
            end
            6:begin
            ground_3 ground37_3f(.clka(clk),.addra(ground37),.douta(vga_ground37));
            end
            9:begin
            ground_4 ground37_4f(.clka(clk),.addra(ground37),.douta(vga_ground37));
            end
            12:begin    
            ground_5 ground37_5f(.clka(clk),.addra(ground37),.douta(vga_ground37));
            end
            15:begin
            ground_6 ground37_6f(.clka(clk),.addra(ground37),.douta(vga_ground37));
            end
        endcase
        case(ip_ground38)
            0:begin 
            ground_1 ground38_1f(.clka(clk),.addra(ground38),.douta(vga_ground38));
            end
            3:begin
            ground_2 ground38_2f(.clka(clk),.addra(ground38),.douta(vga_ground38));
            end
            6:begin
            ground_3 ground38_3f(.clka(clk),.addra(ground38),.douta(vga_ground38));
            end
            9:begin
            ground_4 ground38_4f(.clka(clk),.addra(ground38),.douta(vga_ground38));
            end
            12:begin    
            ground_5 ground38_5f(.clka(clk),.addra(ground38),.douta(vga_ground38));
            end
            15:begin
            ground_6 ground38_6f(.clka(clk),.addra(ground38),.douta(vga_ground38));
            end
        endcase
        case(ip_ground39)
            0:begin 
            ground_1 ground39_1f(.clka(clk),.addra(ground39),.douta(vga_ground39));
            end
            3:begin
            ground_2 ground39_2f(.clka(clk),.addra(ground39),.douta(vga_ground39));
            end
            6:begin
            ground_3 ground39_3f(.clka(clk),.addra(ground39),.douta(vga_ground39));
            end
            9:begin
            ground_4 ground39_4f(.clka(clk),.addra(ground39),.douta(vga_ground39));
            end
            12:begin    
            ground_5 ground39_5f(.clka(clk),.addra(ground39),.douta(vga_ground39));
            end
            15:begin
            ground_6 ground39_6f(.clka(clk),.addra(ground39),.douta(vga_ground39));
            end
        endcase
        case(ip_ground40)
            0:begin 
            ground_1 ground40_1f(.clka(clk),.addra(ground40),.douta(vga_ground40));
            end
            3:begin
            ground_2 ground40_2f(.clka(clk),.addra(ground40),.douta(vga_ground40));
            end
            6:begin
            ground_3 ground40_3f(.clka(clk),.addra(ground40),.douta(vga_ground40));
            end
            9:begin
            ground_4 ground40_4f(.clka(clk),.addra(ground40),.douta(vga_ground40));
            end
            12:begin    
            ground_5 ground40_5f(.clka(clk),.addra(ground40),.douta(vga_ground40));
            end
            15:begin
            ground_6 ground40_6f(.clka(clk),.addra(ground40),.douta(vga_ground40));
            end
        endcase
        case(ip_ground41)
            0:begin 
            ground_1 ground41_1f(.clka(clk),.addra(ground41),.douta(vga_ground41));
            end
            3:begin
            ground_2 ground41_2f(.clka(clk),.addra(ground41),.douta(vga_ground41));
            end
            6:begin
            ground_3 ground41_3f(.clka(clk),.addra(ground41),.douta(vga_ground41));
            end
            9:begin
            ground_4 ground41_4f(.clka(clk),.addra(ground41),.douta(vga_ground41));
            end
            12:begin    
            ground_5 ground41_5f(.clka(clk),.addra(ground41),.douta(vga_ground41));
            end
            15:begin
            ground_6 ground41_6f(.clka(clk),.addra(ground41),.douta(vga_ground41));
            end
        endcase
        case(ip_ground42)
            0:begin 
            ground_1 ground42_1f(.clka(clk),.addra(ground42),.douta(vga_ground42));
            end
            3:begin
            ground_2 ground42_2f(.clka(clk),.addra(ground42),.douta(vga_ground42));
            end
            6:begin
            ground_3 ground42_3f(.clka(clk),.addra(ground42),.douta(vga_ground42));
            end
            9:begin
            ground_4 ground42_4f(.clka(clk),.addra(ground42),.douta(vga_ground42));
            end
            12:begin    
            ground_5 ground42_5f(.clka(clk),.addra(ground42),.douta(vga_ground42));
            end
            15:begin
            ground_6 ground42_6f(.clka(clk),.addra(ground42),.douta(vga_ground42));
            end
        endcase
        case(ip_ground43)
            0:begin 
            ground_1 ground43_1f(.clka(clk),.addra(ground43),.douta(vga_ground43));
            end
            3:begin
            ground_2 ground43_2f(.clka(clk),.addra(ground43),.douta(vga_ground43));
            end
            6:begin
            ground_3 ground43_3f(.clka(clk),.addra(ground43),.douta(vga_ground43));
            end
            9:begin
            ground_4 ground43_4f(.clka(clk),.addra(ground43),.douta(vga_ground43));
            end
            12:begin    
            ground_5 ground43_5f(.clka(clk),.addra(ground43),.douta(vga_ground43));
            end
            15:begin
            ground_6 ground43_6f(.clka(clk),.addra(ground43),.douta(vga_ground43));
            end
        endcase
        case(ip_ground44)
            0:begin 
            ground_1 ground44_1f(.clka(clk),.addra(ground44),.douta(vga_ground44));
            end
            3:begin
            ground_2 ground44_2f(.clka(clk),.addra(ground44),.douta(vga_ground44));
            end
            6:begin
            ground_3 ground44_3f(.clka(clk),.addra(ground44),.douta(vga_ground44));
            end
            9:begin
            ground_4 ground44_4f(.clka(clk),.addra(ground44),.douta(vga_ground44));
            end
            12:begin    
            ground_5 ground44_5f(.clka(clk),.addra(ground44),.douta(vga_ground44));
            end
            15:begin
            ground_6 ground44_6f(.clka(clk),.addra(ground44),.douta(vga_ground44));
            end
        endcase
        case(ip_ground45)
            0:begin 
            ground_1 ground45_1f(.clka(clk),.addra(ground45),.douta(vga_ground45));
            end
            3:begin
            ground_2 ground45_2f(.clka(clk),.addra(ground45),.douta(vga_ground45));
            end
            6:begin
            ground_3 ground45_3f(.clka(clk),.addra(ground45),.douta(vga_ground45));
            end
            9:begin
            ground_4 ground45_4f(.clka(clk),.addra(ground45),.douta(vga_ground45));
            end
            12:begin    
            ground_5 ground45_5f(.clka(clk),.addra(ground45),.douta(vga_ground45));
            end
            15:begin
            ground_6 ground45_6f(.clka(clk),.addra(ground45),.douta(vga_ground45));
            end
        endcase
        case(ip_ground46)
            0:begin 
            ground_1 ground46_1f(.clka(clk),.addra(ground46),.douta(vga_ground46));
            end
            3:begin
            ground_2 ground46_2f(.clka(clk),.addra(ground46),.douta(vga_ground46));
            end
            6:begin
            ground_3 ground46_3f(.clka(clk),.addra(ground46),.douta(vga_ground46));
            end
            9:begin
            ground_4 ground46_4f(.clka(clk),.addra(ground46),.douta(vga_ground46));
            end
            12:begin    
            ground_5 ground46_5f(.clka(clk),.addra(ground46),.douta(vga_ground46));
            end
            15:begin
            ground_6 ground46_6f(.clka(clk),.addra(ground46),.douta(vga_ground46));
            end
        endcase
        case(ip_ground47)
            0:begin 
            ground_1 ground47_1f(.clka(clk),.addra(ground47),.douta(vga_ground47));
            end
            3:begin
            ground_2 ground47_2f(.clka(clk),.addra(ground47),.douta(vga_ground47));
            end
            6:begin
            ground_3 ground47_3f(.clka(clk),.addra(ground47),.douta(vga_ground47));
            end
            9:begin
            ground_4 ground47_4f(.clka(clk),.addra(ground47),.douta(vga_ground47));
            end
            12:begin    
            ground_5 ground47_5f(.clka(clk),.addra(ground47),.douta(vga_ground47));
            end
            15:begin
            ground_6 ground47_6f(.clka(clk),.addra(ground47),.douta(vga_ground47));
            end
        endcase
        case(ip_ground48)
            0:begin 
            ground_1 ground48_1f(.clka(clk),.addra(ground48),.douta(vga_ground48));
            end
            3:begin
            ground_2 ground48_2f(.clka(clk),.addra(ground48),.douta(vga_ground48));
            end
            6:begin
            ground_3 ground48_3f(.clka(clk),.addra(ground48),.douta(vga_ground48));
            end
            9:begin
            ground_4 ground48_4f(.clka(clk),.addra(ground48),.douta(vga_ground48));
            end
            12:begin    
            ground_5 ground48_5f(.clka(clk),.addra(ground48),.douta(vga_ground48));
            end
            15:begin
            ground_6 ground48_6f(.clka(clk),.addra(ground48),.douta(vga_ground48));
            end
        endcase
        case(ip_ground49)
            0:begin 
            ground_1 ground49_1f(.clka(clk),.addra(ground49),.douta(vga_ground49));
            end
            3:begin
            ground_2 ground49_2f(.clka(clk),.addra(ground49),.douta(vga_ground49));
            end
            6:begin
            ground_3 ground49_3f(.clka(clk),.addra(ground49),.douta(vga_ground49));
            end
            9:begin
            ground_4 ground49_4f(.clka(clk),.addra(ground49),.douta(vga_ground49));
            end
            12:begin    
            ground_5 ground49_5f(.clka(clk),.addra(ground49),.douta(vga_ground49));
            end
            15:begin
            ground_6 ground49_6f(.clka(clk),.addra(ground49),.douta(vga_ground49));
            end
        endcase 
        case(ip_ground50)
            0:begin 
            ground_1 ground50_1f(.clka(clk),.addra(ground50),.douta(vga_ground50));
            end
            3:begin
            ground_2 ground50_2f(.clka(clk),.addra(ground50),.douta(vga_ground50));
            end
            6:begin
            ground_3 ground50_3f(.clka(clk),.addra(ground50),.douta(vga_ground50));
            end
            9:begin
            ground_4 ground50_4f(.clka(clk),.addra(ground50),.douta(vga_ground50));
            end
            12:begin    
            ground_5 ground50_5f(.clka(clk),.addra(ground50),.douta(vga_ground50));
            end
            15:begin
            ground_6 ground50_6f(.clka(clk),.addra(ground50),.douta(vga_ground50));
            end
        endcase
    ///还没补完，待补！！！
        ///
        case(ip_blue_st)
            0: vga_blue_st <= vga_blue_st_1[11:0];
            4: vga_blue_st <= vga_blue_st_2[11:0];
            8: vga_blue_st <= vga_blue_st_3[11:0];
            12: vga_blue_st <= vga_blue_st_4[11:0];
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
        case(ip_snowf)
            0:begin 
            snowf_1 snowf1_1f(.clka(clk),.addra(snowf1),.douta(vga_snowf1));
            snowf_1 snowf2_1f(.clka(clk),.addra(snowf2),.douta(vga_snowf2));
            snowf_1 snowf3_1f(.clka(clk),.addra(snowf3),.douta(vga_snowf3));
            snowf_1 snowf4_1f(.clka(clk),.addra(snowf4),.douta(vga_snowf4));
            snowf_1 snowf5_1f(.clka(clk),.addra(snowf5),.douta(vga_snowf5));
            snowf_1 snowf6_1f(.clka(clk),.addra(snowf6),.douta(vga_snowf6));
            snowf_1 snowf7_1f(.clka(clk),.addra(snowf7),.douta(vga_snowf7));
            snowf_1 snowf8_1f(.clka(clk),.addra(snowf8),.douta(vga_snowf8));
            snowf_1 snowf9_1f(.clka(clk),.addra(snowf9),.douta(vga_snowf9));
            snowf_1 snowf10_1f(.clka(clk),.addra(snowf10),.douta(vga_snowf10));
            snowf_1 snowf11_1f(.clka(clk),.addra(snowf11),.douta(vga_snowf11));
            snowf_1 snowf12_1f(.clka(clk),.addra(snowf12),.douta(vga_snowf12));
            snowf_1 snowf13_1f(.clka(clk),.addra(snowf13),.douta(vga_snowf13));
            snowf_1 snowf14_1f(.clka(clk),.addra(snowf14),.douta(vga_snowf14));
            snowf_1 snowf15_1f(.clka(clk),.addra(snowf15),.douta(vga_snowf15));
            end
            2:begin
            snowf_3 snowf1_3f(.clka(clk),.addra(snowf1),.douta(vga_snowf1));
            snowf_3 snowf2_3f(.clka(clk),.addra(snowf2),.douta(vga_snowf2));
            snowf_3 snowf3_3f(.clka(clk),.addra(snowf3),.douta(vga_snowf3));
            snowf_3 snowf4_3f(.clka(clk),.addra(snowf4),.douta(vga_snowf4));
            snowf_3 snowf5_3f(.clka(clk),.addra(snowf5),.douta(vga_snowf5));
            snowf_3 snowf6_3f(.clka(clk),.addra(snowf6),.douta(vga_snowf6));
            snowf_3 snowf7_3f(.clka(clk),.addra(snowf7),.douta(vga_snowf7));
            snowf_3 snowf8_3f(.clka(clk),.addra(snowf8),.douta(vga_snowf8));
            snowf_3 snowf9_3f(.clka(clk),.addra(snowf9),.douta(vga_snowf9));
            snowf_3 snowf10_3f(.clka(clk),.addra(snowf10),.douta(vga_snowf10));
            snowf_3 snowf11_3f(.clka(clk),.addra(snowf11),.douta(vga_snowf11));
            snowf_3 snowf12_3f(.clka(clk),.addra(snowf12),.douta(vga_snowf12));
            snowf_3 snowf13_3f(.clka(clk),.addra(snowf13),.douta(vga_snowf13));
            snowf_3 snowf14_3f(.clka(clk),.addra(snowf14),.douta(vga_snowf14));
            snowf_3 snowf15_3f(.clka(clk),.addra(snowf15),.douta(vga_snowf15));
            end
            4:begin
            snowf_5 snowf1_5f(.clka(clk),.addra(snowf1),.douta(vga_snowf1));
            snowf_5 snowf2_5f(.clka(clk),.addra(snowf2),.douta(vga_snowf2));
            snowf_5 snowf3_5f(.clka(clk),.addra(snowf3),.douta(vga_snowf3));
            snowf_5 snowf4_5f(.clka(clk),.addra(snowf4),.douta(vga_snowf4));
            snowf_5 snowf5_5f(.clka(clk),.addra(snowf5),.douta(vga_snowf5));
            snowf_5 snowf6_5f(.clka(clk),.addra(snowf6),.douta(vga_snowf6));
            snowf_5 snowf7_5f(.clka(clk),.addra(snowf7),.douta(vga_snowf7));
            snowf_5 snowf8_5f(.clka(clk),.addra(snowf8),.douta(vga_snowf8));
            snowf_5 snowf9_5f(.clka(clk),.addra(snowf9),.douta(vga_snowf9));
            snowf_5 snowf10_5f(.clka(clk),.addra(snowf10),.douta(vga_snowf10));
            snowf_5 snowf11_5f(.clka(clk),.addra(snowf11),.douta(vga_snowf11));
            snowf_5 snowf12_5f(.clka(clk),.addra(snowf12),.douta(vga_snowf12));
            snowf_5 snowf13_5f(.clka(clk),.addra(snowf13),.douta(vga_snowf13));
            snowf_5 snowf14_5f(.clka(clk),.addra(snowf14),.douta(vga_snowf14));
            snowf_5 snowf15_5f(.clka(clk),.addra(snowf15),.douta(vga_snowf15));
            end
            6:begin
            snowf_7 snowf1_7f(.clka(clk),.addra(snowf1),.douta(vga_snowf1));
            snowf_7 snowf2_7f(.clka(clk),.addra(snowf2),.douta(vga_snowf2));
            snowf_7 snowf3_7f(.clka(clk),.addra(snowf3),.douta(vga_snowf3));
            snowf_7 snowf4_7f(.clka(clk),.addra(snowf4),.douta(vga_snowf4));
            snowf_7 snowf5_7f(.clka(clk),.addra(snowf5),.douta(vga_snowf5));
            snowf_7 snowf6_7f(.clka(clk),.addra(snowf6),.douta(vga_snowf6));
            snowf_7 snowf7_7f(.clka(clk),.addra(snowf7),.douta(vga_snowf7));
            snowf_7 snowf8_7f(.clka(clk),.addra(snowf8),.douta(vga_snowf8));
            snowf_7 snowf9_7f(.clka(clk),.addra(snowf9),.douta(vga_snowf9));
            snowf_7 snowf10_7f(.clka(clk),.addra(snowf10),.douta(vga_snowf10));
            snowf_7 snowf11_7f(.clka(clk),.addra(snowf11),.douta(vga_snowf11));
            snowf_7 snowf12_7f(.clka(clk),.addra(snowf12),.douta(vga_snowf12));
            snowf_7 snowf13_7f(.clka(clk),.addra(snowf13),.douta(vga_snowf13));
            snowf_7 snowf14_7f(.clka(clk),.addra(snowf14),.douta(vga_snowf14));
            snowf_7 snowf15_7f(.clka(clk),.addra(snowf15),.douta(vga_snowf15));
            end    
            8:begin
            snowf_9 snowf1_9f(.clka(clk),.addra(snowf1),.douta(vga_snowf1));
            snowf_9 snowf2_9f(.clka(clk),.addra(snowf2),.douta(vga_snowf2));
            snowf_9 snowf3_9f(.clka(clk),.addra(snowf3),.douta(vga_snowf3));
            snowf_9 snowf4_9f(.clka(clk),.addra(snowf4),.douta(vga_snowf4));
            snowf_9 snowf5_9f(.clka(clk),.addra(snowf5),.douta(vga_snowf5));
            snowf_9 snowf6_9f(.clka(clk),.addra(snowf6),.douta(vga_snowf6));
            snowf_9 snowf7_9f(.clka(clk),.addra(snowf7),.douta(vga_snowf7));
            snowf_9 snowf8_9f(.clka(clk),.addra(snowf8),.douta(vga_snowf8));
            snowf_9 snowf9_9f(.clka(clk),.addra(snowf9),.douta(vga_snowf9));
            snowf_9 snowf10_9f(.clka(clk),.addra(snowf10),.douta(vga_snowf10));
            snowf_9 snowf11_9f(.clka(clk),.addra(snowf11),.douta(vga_snowf11));
            snowf_9 snowf12_9f(.clka(clk),.addra(snowf12),.douta(vga_snowf12));
            snowf_9 snowf13_9f(.clka(clk),.addra(snowf13),.douta(vga_snowf13));
            snowf_9 snowf14_9f(.clka(clk),.addra(snowf14),.douta(vga_snowf14));
            snowf_9 snowf15_9f(.clka(clk),.addra(snowf15),.douta(vga_snowf15));
            end
            10:begin
            snowf_11 snowf1_11f(.clka(clk),.addra(snowf1),.douta(vga_snowf1));
            snowf_11 snowf2_11f(.clka(clk),.addra(snowf2),.douta(vga_snowf2));
            snowf_11 snowf3_11f(.clka(clk),.addra(snowf3),.douta(vga_snowf3));
            snowf_11 snowf4_11f(.clka(clk),.addra(snowf4),.douta(vga_snowf4));
            snowf_11 snowf5_11f(.clka(clk),.addra(snowf5),.douta(vga_snowf5));
            snowf_11 snowf6_11f(.clka(clk),.addra(snowf6),.douta(vga_snowf6));
            snowf_11 snowf7_11f(.clka(clk),.addra(snowf7),.douta(vga_snowf7));
            snowf_11 snowf8_11f(.clka(clk),.addra(snowf8),.douta(vga_snowf8));
            snowf_11 snowf9_11f(.clka(clk),.addra(snowf9),.douta(vga_snowf9));
            snowf_11 snowf10_11f(.clka(clk),.addra(snowf10),.douta(vga_snowf10));
            snowf_11 snowf11_11f(.clka(clk),.addra(snowf11),.douta(vga_snowf11));
            snowf_11 snowf12_11f(.clka(clk),.addra(snowf12),.douta(vga_snowf12));
            snowf_11 snowf13_11f(.clka(clk),.addra(snowf13),.douta(vga_snowf13));
            snowf_11 snowf14_11f(.clka(clk),.addra(snowf14),.douta(vga_snowf14));
            snowf_11 snowf15_11f(.clka(clk),.addra(snowf15),.douta(vga_snowf15));
            end 
            12:begin
            snowf_13 snowf1_13f(.clka(clk),.addra(snowf1),.douta(vga_snowf1));
            snowf_13 snowf2_13f(.clka(clk),.addra(snowf2),.douta(vga_snowf2));
            snowf_13 snowf3_13f(.clka(clk),.addra(snowf3),.douta(vga_snowf3));
            snowf_13 snowf4_13f(.clka(clk),.addra(snowf4),.douta(vga_snowf4));
            snowf_13 snowf5_13f(.clka(clk),.addra(snowf5),.douta(vga_snowf5));
            snowf_13 snowf6_13f(.clka(clk),.addra(snowf6),.douta(vga_snowf6));
            snowf_13 snowf7_13f(.clka(clk),.addra(snowf7),.douta(vga_snowf7));
            snowf_13 snowf8_13f(.clka(clk),.addra(snowf8),.douta(vga_snowf8));
            snowf_13 snowf9_13f(.clka(clk),.addra(snowf9),.douta(vga_snowf9));
            snowf_13 snowf10_13f(.clka(clk),.addra(snowf10),.douta(vga_snowf10));
            snowf_13 snowf11_13f(.clka(clk),.addra(snowf11),.douta(vga_snowf11));
            snowf_13 snowf12_13f(.clka(clk),.addra(snowf12),.douta(vga_snowf12));
            snowf_13 snowf13_13f(.clka(clk),.addra(snowf13),.douta(vga_snowf13));
            snowf_13 snowf14_13f(.clka(clk),.addra(snowf14),.douta(vga_snowf14));
            snowf_13 snowf15_13f(.clka(clk),.addra(snowf15),.douta(vga_snowf15));
            end
            14:begin
            snowf_15 snowf1_15f(.clka(clk),.addra(snowf1),.douta(vga_snowf1));
            snowf_15 snowf2_15f(.clka(clk),.addra(snowf2),.douta(vga_snowf2));
            snowf_15 snowf3_15f(.clka(clk),.addra(snowf3),.douta(vga_snowf3));
            snowf_15 snowf4_15f(.clka(clk),.addra(snowf4),.douta(vga_snowf4));
            snowf_15 snowf5_15f(.clka(clk),.addra(snowf5),.douta(vga_snowf5));
            snowf_15 snowf6_15f(.clka(clk),.addra(snowf6),.douta(vga_snowf6));
            snowf_15 snowf7_15f(.clka(clk),.addra(snowf7),.douta(vga_snowf7));
            snowf_15 snowf8_15f(.clka(clk),.addra(snowf8),.douta(vga_snowf8));
            snowf_15 snowf9_15f(.clka(clk),.addra(snowf9),.douta(vga_snowf9));
            snowf_15 snowf10_15f(.clka(clk),.addra(snowf10),.douta(vga_snowf10));
            snowf_15 snowf11_15f(.clka(clk),.addra(snowf11),.douta(vga_snowf11));
            snowf_15 snowf12_15f(.clka(clk),.addra(snowf12),.douta(vga_snowf12));
            snowf_15 snowf13_15f(.clka(clk),.addra(snowf13),.douta(vga_snowf13));
            snowf_15 snowf14_15f(.clka(clk),.addra(snowf14),.douta(vga_snowf14));
            snowf_15 snowf15_15f(.clka(clk),.addra(snowf15),.douta(vga_snowf15));
            end
        endcase
    end




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
        if(col_addr_x>=x_ground11&&col_addr_x<=x_ground11+27&&row_addr_y>=y_ground11&&row_addr_y<=y_ground11+41)begin
            if(vga_ground11[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground11[11:0];   
            end
        end
        if(col_addr_x>=x_ground12&&col_addr_x<=x_ground12+27&&row_addr_y>=y_ground12&&row_addr_y<=y_ground12+41)begin
            if(vga_ground12[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground12[11:0];   
            end
        end
        if(col_addr_x>=x_ground13&&col_addr_x<=x_ground13+27&&row_addr_y>=y_ground13&&row_addr_y<=y_ground13+41)begin
            if(vga_ground13[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground13[11:0];   
            end
        end
        if(col_addr_x>=x_ground14&&col_addr_x<=x_ground14+27&&row_addr_y>=y_ground14&&row_addr_y<=y_ground14+41)begin
            if(vga_ground14[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground14[11:0];   
            end
        end
        if(col_addr_x>=x_ground15&&col_addr_x<=x_ground15+27&&row_addr_y>=y_ground15&&row_addr_y<=y_ground15+41)begin
            if(vga_ground15[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground15[11:0];   
            end
        end
        if(col_addr_x>=x_ground16&&col_addr_x<=x_ground16+27&&row_addr_y>=y_ground16&&row_addr_y<=y_ground16+41)begin
            if(vga_ground16[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground16[11:0];   
            end
        end
        if(col_addr_x>=x_ground17&&col_addr_x<=x_ground17+27&&row_addr_y>=y_ground17&&row_addr_y<=y_ground17+41)begin
            if(vga_ground17[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground17[11:0];   
            end
        end
        if(col_addr_x>=x_ground18&&col_addr_x<=x_ground18+27&&row_addr_y>=y_ground18&&row_addr_y<=y_ground18+41)begin
            if(vga_ground18[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground18[11:0];   
            end
        end
        if(col_addr_x>=x_ground19&&col_addr_x<=x_ground19+27&&row_addr_y>=y_ground19&&row_addr_y<=y_ground19+41)begin
            if(vga_ground19[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground19[11:0];   
            end
        end
        if(col_addr_x>=x_ground20&&col_addr_x<=x_ground20+27&&row_addr_y>=y_ground20&&row_addr_y<=y_ground20+41)begin
            if(vga_ground20[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground20[11:0];   
            end
        end
        if(col_addr_x>=x_ground21&&col_addr_x<=x_ground21+27&&row_addr_y>=y_ground21&&row_addr_y<=y_ground21+41)begin
            if(vga_ground21[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground21[11:0];   
            end
        end
        if(col_addr_x>=x_ground22&&col_addr_x<=x_ground22+27&&row_addr_y>=y_ground22&&row_addr_y<=y_ground22+41)begin
            if(vga_ground22[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground22[11:0];   
            end
        end
        if(col_addr_x>=x_ground23&&col_addr_x<=x_ground23+27&&row_addr_y>=y_ground23&&row_addr_y<=y_ground23+41)begin
            if(vga_ground23[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground23[11:0];   
            end
        end
        if(col_addr_x>=x_ground24&&col_addr_x<=x_ground24+27&&row_addr_y>=y_ground24&&row_addr_y<=y_ground24+41)begin
            if(vga_ground24[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground24[11:0];   
            end
        end
        if(col_addr_x>=x_ground25&&col_addr_x<=x_ground25+27&&row_addr_y>=y_ground25&&row_addr_y<=y_ground25+41)begin
            if(vga_ground25[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground25[11:0];   
            end
        end
        if(col_addr_x>=x_ground26&&col_addr_x<=x_ground26+27&&row_addr_y>=y_ground26&&row_addr_y<=y_ground26+41)begin
            if(vga_ground26[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground26[11:0];   
            end
        end
        if(col_addr_x>=x_ground27&&col_addr_x<=x_ground27+27&&row_addr_y>=y_ground27&&row_addr_y<=y_ground27+41)begin
            if(vga_ground27[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground27[11:0];   
            end
        end
        if(col_addr_x>=x_ground28&&col_addr_x<=x_ground28+27&&row_addr_y>=y_ground28&&row_addr_y<=y_ground28+41)begin
            if(vga_ground28[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground28[11:0];   
            end
        end
        if(col_addr_x>=x_ground29&&col_addr_x<=x_ground29+27&&row_addr_y>=y_ground29&&row_addr_y<=y_ground29+41)begin
            if(vga_ground29[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground29[11:0];   
            end
        end
        if(col_addr_x>=x_ground30&&col_addr_x<=x_ground30+27&&row_addr_y>=y_ground30&&row_addr_y<=y_ground30+41)begin
            if(vga_ground30[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground30[11:0];   
            end
        end
        if(col_addr_x>=x_ground31&&col_addr_x<=x_ground31+27&&row_addr_y>=y_ground31&&row_addr_y<=y_ground31+41)begin
            if(vga_ground31[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground31[11:0];   
            end
        end
        if(col_addr_x>=x_ground32&&col_addr_x<=x_ground32+27&&row_addr_y>=y_ground32&&row_addr_y<=y_ground32+41)begin
            if(vga_ground32[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground32[11:0];   
            end
        end
        if(col_addr_x>=x_ground33&&col_addr_x<=x_ground33+27&&row_addr_y>=y_ground33&&row_addr_y<=y_ground33+41)begin
            if(vga_ground33[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground33[11:0];   
            end
        end
        if(col_addr_x>=x_ground34&&col_addr_x<=x_ground34+27&&row_addr_y>=y_ground34&&row_addr_y<=y_ground34+41)begin
            if(vga_ground34[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground34[11:0];   
            end
        end
        if(col_addr_x>=x_ground35&&col_addr_x<=x_ground35+27&&row_addr_y>=y_ground35&&row_addr_y<=y_ground35+41)begin
            if(vga_ground35[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground35[11:0];   
            end
        end
        if(col_addr_x>=x_ground36&&col_addr_x<=x_ground36+27&&row_addr_y>=y_ground36&&row_addr_y<=y_ground36+41)begin
            if(vga_ground36[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground36[11:0];   
            end
        end
        if(col_addr_x>=x_ground37&&col_addr_x<=x_ground37+27&&row_addr_y>=y_ground37&&row_addr_y<=y_ground37+41)begin
            if(vga_ground37[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground37[11:0];   
            end
        end
        if(col_addr_x>=x_ground38&&col_addr_x<=x_ground38+27&&row_addr_y>=y_ground38&&row_addr_y<=y_ground38+41)begin
            if(vga_ground38[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground38[11:0];   
            end
        end
        if(col_addr_x>=x_ground39&&col_addr_x<=x_ground39+27&&row_addr_y>=y_ground39&&row_addr_y<=y_ground39+41)begin
            if(vga_ground39[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground39[11:0];   
            end
        end
        if(col_addr_x>=x_ground40&&col_addr_x<=x_ground40+27&&row_addr_y>=y_ground40&&row_addr_y<=y_ground40+41)begin
            if(vga_ground40[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground40[11:0];   
            end
        end
        if(col_addr_x>=x_ground41&&col_addr_x<=x_ground41+27&&row_addr_y>=y_ground41&&row_addr_y<=y_ground41+41)begin
            if(vga_ground41[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground41[11:0];   
            end
        end
        if(col_addr_x>=x_ground42&&col_addr_x<=x_ground42+27&&row_addr_y>=y_ground42&&row_addr_y<=y_ground42+41)begin
            if(vga_ground42[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground42[11:0];   
            end
        end
        if(col_addr_x>=x_ground43&&col_addr_x<=x_ground43+27&&row_addr_y>=y_ground43&&row_addr_y<=y_ground43+41)begin
            if(vga_ground43[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground43[11:0];   
            end
        end
        if(col_addr_x>=x_ground44&&col_addr_x<=x_ground44+27&&row_addr_y>=y_ground44&&row_addr_y<=y_ground44+41)begin
            if(vga_ground44[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground44[11:0];   
            end
        end
        if(col_addr_x>=x_ground45&&col_addr_x<=x_ground45+27&&row_addr_y>=y_ground45&&row_addr_y<=y_ground45+41)begin
            if(vga_ground45[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground45[11:0];   
            end
        end
        if(col_addr_x>=x_ground46&&col_addr_x<=x_ground46+27&&row_addr_y>=y_ground46&&row_addr_y<=y_ground46+41)begin
            if(vga_ground46[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground46[11:0];   
            end
        end
        if(col_addr_x>=x_ground47&&col_addr_x<=x_ground47+27&&row_addr_y>=y_ground47&&row_addr_y<=y_ground47+41)begin
            if(vga_ground47[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground47[11:0];   
            end
        end
        if(col_addr_x>=x_ground48&&col_addr_x<=x_ground48+27&&row_addr_y>=y_ground48&&row_addr_y<=y_ground48+41)begin
            if(vga_ground48[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground48[11:0];   
            end
        end
        if(col_addr_x>=x_ground49&&col_addr_x<=x_ground49+27&&row_addr_y>=y_ground49&&row_addr_y<=y_ground49+41)begin
            if(vga_ground49[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground49[11:0];   
            end
        end
        if(col_addr_x>=x_ground50&&col_addr_x<=x_ground50+27&&row_addr_y>=y_ground50&&row_addr_y<=y_ground50+41)begin
            if(vga_ground50[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_ground50[11:0];   
            end
        end
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
        if(blue_state==2'd0&&col_addr_x>=x_blue&&col_addr_x<=x_blue+46&&row_addr_y>=y_blue&&row_addr_y<=y_blue+40)begin
            if(vga_blue_st[11:0]!=4*256+2*16+8)begin
                vga_data<=vga_blue_st[11:0];   
            end
        end

        //8.蓝色小人（筛选奔跑及删除背景色）47*43 028
        if(blue_state==2'd1&&col_addr_x>=x_blue&&col_addr_x<=x_blue+46&&row_addr_y>=y_blue&&row_addr_y<=y_blue+42)begin
            if(vga_blue_rwk[11:0]!=0*256+2*16+8)begin
                vga_data<=vga_blue_rwk[11:0];   
            end
        end
    end


    endmodule