    `timescale 1ms / 10ns
    module top(
        input clk,
        input rstn,
        input ps2_clk,ps2_data,
        output segled_clk,
        output SEGLED_CLR,
        output SEGLED_DO,
        output SEGLED_PEN,
        output [3:0] r,g,b,
        output hs,vs
    );
////////////////Global Variables and Initialize//////////////////////////////
    wire clk_total;
    wire [3:0]score;
    wire [3:0]health;
    reg reset;
    initial begin
        reset = 1'b0;
    end
    reg [31:0] clkdiv;
    always@(posedge clk)begin
        clkdiv <= clkdiv+1'b1;
    end
    //photo's size 551*401
    reg [11:0]vga_data;
    wire [9:0]col_addr_x;
    wire [8:0]row_addr_y;
    vgac v1(.vga_clk(clkdiv[1]),.clrn(1'b1),.d_in(vga_data),.row_addr(row_addr_y),.col_addr(col_addr_x),.hs(hs),.vs(vs),.r(r),.g(g),.b(b));
    Sseg_Dev m7(.clk(clk),.rst(1'b0),.Start(clkdiv[20]),.flash(1),.Hexs({score,24'b0,health}),.point({8'b01000001}),.LES(8'b00000000),.seg_clk(segled_clk),.seg_clrn(SEGLED_CLR),.seg_sout(SEGLED_DO),.SEG_PEN(SEGLED_PEN));
////////////////Global Variables and Initialize//////////////////////////////

////////////////////////////////Initialize the coordinates of various objects//////////////////////////////
    //蓝色小人坐标
    reg [9:0]x_blue;
    reg [8:0]y_blue;
    //record the state of Jack
    //first bit: 0:left 1:right
    //second bit: 0: on the ground 1: in the air
    //third bit: 0:stand 1:move
    reg [2:0]blue_state;
    initial begin
        x_blue=10'd0;
        y_blue=9'd367;
    end
   
    //Initialize the coordinate of the monsters with loop
    parameter monster_num = 2;
    wire [9:0]x_slim1,x_slim2;
    wire [8:0]y_slim1,y_slim2;

            
    //Initialize snowflake's coordinate with loop
    parameter snowflake_num = 15;
    reg [9:0]x_snowf[0:snowflake_num-1];
    reg [8:0]y_snowf[0:snowflake_num-1];
    initial begin
        for (integer i=0;i<5;i=i+1)begin
            x_snowf[i]<=10'd28*i+10'd50;
            y_snowf[i]<=9'd370;
        end
        for (integer i=5;i<10;i=i+1)begin
            x_snowf[i]<=10'd28*(i-5)+10'd350;
            y_snowf[i]<=9'd370;
        end
        for (integer i=10;i<15;i=i+1)begin
            x_snowf[i]<=10'd28*(i-10);
            y_snowf[i]<=9'd105;
        end
    end

    //Initialize the coordinate of the ground with loop
    //The map is constructed by blocks
    parameter ground_num = 50;
    reg [9:0]x_ground[0:ground_num-1];
    reg [8:0]y_ground[0:ground_num-1];
    initial begin
        for (integer i=0;i<22;i=i+1)begin
            x_ground[i]<=10'd25*i;
            y_ground[i]<=9'd400;
        end
        for(integer i=22;i<27;i=i+1)begin
            x_ground[i]<=10'd25*(i-22);
            y_ground[i]<=310;
        end
        for (integer i=27;i<32;i=i+1)begin
            x_ground[i]<=425+10'd25*(i-27);
            y_ground[i]<=9'd310;
        end
        for (integer i=32;i<43;i=i+1)begin
            x_ground[i]<=150+10'd25*(i-32);
            y_ground[i]<=9'd225;
        end
        for (integer i=43;i<50;i=i+1)begin
            x_ground[i]<=10'd25*(i-43);
            y_ground[i]<=9'd135;
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
            dt_block_fz dt_block_fz_i(.reset(reset),.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground[dt_block_fz_i]),.y_ground(y_ground[dt_block_fz_i]),.touched(bk_touched[dt_block_fz_i]));
        end
    endgenerate
        wire [1:0]game;
    //game   00->begin 01->ing   11->win  10->lose
    game_state game_f(.clk(clk),.health(health),.bk_touched(bk_touched),.reset(reset),.game_state(game));

    //2. icing the monsters
    wire [monster_num-1:0]slim_frozen;
    //update the signal with loop
    dt_slim_fz dt_slim_fz1(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_slim(x_slim1),.y_slim(y_slim1),.frozen(slim_frozen[0]));
    dt_slim_fz dt_slim_fz2(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_slim(x_slim2),.y_slim(y_slim2),.frozen(slim_frozen[1]));

    //3. damaged by the monsters
    wire [monster_num-1:0]slim_damage;
    //update the signal with loop
    dt_slim_bk dt_slim_bk1(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_slim(x_slim1),.y_slim(y_slim1),.isfrozen(slim_frozen[0]),.broken(slim_damage[0]));
    dt_slim_bk dt_slim_bk2(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_slim(x_slim2),.y_slim(y_slim2),.isfrozen(slim_frozen[1]),.broken(slim_damage[1]));
    health_count health_f(.reset(reset),.clk(clk),.slim_damage(slim_damage),.health(health));
  
    //4. get the snowflakes
    wire [snowflake_num-1:0]snowf_get;    
    //update the signal with loop
    genvar dt_snowf_get_i;
    generate
        for (dt_snowf_get_i=0;dt_snowf_get_i<snowflake_num;dt_snowf_get_i=dt_snowf_get_i+1)begin:dt_snowf_get
            dt_snowf_get dt_snowf_get_i(.reset(reset),.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_snowf(x_snowf[dt_snowf_get_i]),.y_snowf(y_snowf[dt_snowf_get_i]),.snowf_get(snowf_get[dt_snowf_get_i]));
        end
    endgenerate
    score_count score_f(.clk(clk),.snowf_get(snowf_get),.score(score));
////////////////////////////////Implement the detection logic of the game//////////////////////////////

////////////////////////////////Implement the moves of the game//////////////////////////////
    // Instantiate the 1ms clock module
    clk_10000 clk_10000_1(.clk(clk),.clk_10000(clk_total));
    parameter W_KEY = 8'h1D;
    parameter S_KEY = 8'h1B;
    parameter A_KEY = 8'h1C;
    parameter D_KEY = 8'h23;
    parameter R_KEY = 8'h2D;
    // Instantiate the PS2 Keyboard module
    wire [9:0] instruction;
    wire ready;
    reg [3:0] wasd_down;//0:W 1:A 2:S 3:D

    ps2_ver2 ps2_ver21(.clk(clk),.rst(1'b0),.ps2_clk(ps2_clk),.ps2_data(ps2_data),.data_out(instruction),.ready(ready));

    always@(posedge clk)begin
        if(ready)begin
            if(instruction[7:0] == W_KEY && instruction[8] == 1'b0)begin
                wasd_down[0] <= 1'b1;
            end else if(instruction[8] == 1'b1)begin
                wasd_down[0] <= 1'b0;
            end
            if(instruction == S_KEY && instruction[8] == 1'b0)begin
                wasd_down[2] <= 1'b1;
            end else if(instruction[8] == 1'b1)begin
                wasd_down[2] <= 1'b0;
            end
            if(instruction[7:0] == D_KEY && instruction[8] == 1'b0)begin
                wasd_down[3] <= 1'b1;
            end else if(instruction[8] == 1'b1)begin
                wasd_down[3] <= 1'b0;
            end
            if(instruction[7:0] == A_KEY && instruction[8] == 1'b0)begin
                wasd_down[1] <= 1'b1;
            end else if(instruction[8] == 1'b1)begin
                wasd_down[1] <= 1'b0;
            end
             if(instruction[7:0] == R_KEY && instruction[8] == 1'b0)begin
                reset = ~reset;
            end
        end
    end

    reg [3:0] collision_state;//0 down 1 up 2 right 3 left
    wire [3:0] collision_state_single[0:ground_num-1];
    genvar is_Collision_i;
    generate
        for (is_Collision_i=0;is_Collision_i<ground_num;is_Collision_i=is_Collision_i+1)begin:is_Collision
            collision is_Collision_i(.clk(clk),.x_blue(x_blue),.y_blue(y_blue),.x_ground(x_ground[is_Collision_i]),.y_ground(y_ground[is_Collision_i]),.is_Collision(collision_state_single[is_Collision_i]));
        end
    endgenerate
    //combine the collision state of the ground
    always@(posedge clk)begin
            collision_state[0] <=  collision_state_single[0][0]|collision_state_single[1][0]|collision_state_single[2][0]|collision_state_single[3][0]|collision_state_single[4][0]|collision_state_single[5][0]|collision_state_single[6][0]|collision_state_single[7][0]|collision_state_single[8][0]|collision_state_single[9][0]|collision_state_single[10][0]|collision_state_single[11][0]|collision_state_single[12][0]|collision_state_single[13][0]|collision_state_single[14][0]|collision_state_single[15][0]|collision_state_single[16][0]|collision_state_single[17][0]|collision_state_single[18][0]|collision_state_single[19][0]|collision_state_single[20][0]|collision_state_single[21][0]|collision_state_single[22][0]|collision_state_single[23][0]|collision_state_single[24][0]|collision_state_single[25][0]|collision_state_single[26][0]|collision_state_single[27][0]|collision_state_single[28][0]|collision_state_single[29][0]|collision_state_single[30][0]|collision_state_single[31][0]|collision_state_single[32][0]|collision_state_single[33][0]|collision_state_single[34][0]|collision_state_single[35][0]|collision_state_single[36][0]|collision_state_single[37][0]|collision_state_single[38][0]|collision_state_single[39][0]|collision_state_single[40][0]|collision_state_single[41][0]|collision_state_single[42][0]|collision_state_single[43][0]|collision_state_single[44][0]|collision_state_single[45][0]|collision_state_single[46][0]|collision_state_single[47][0]|collision_state_single[48][0]|collision_state_single[49][0];
            collision_state[1] <=  collision_state_single[0][1]|collision_state_single[1][1]|collision_state_single[2][1]|collision_state_single[3][1]|collision_state_single[4][1]|collision_state_single[5][1]|collision_state_single[6][1]|collision_state_single[7][1]|collision_state_single[8][1]|collision_state_single[9][1]|collision_state_single[10][1]|collision_state_single[11][1]|collision_state_single[12][1]|collision_state_single[13][1]|collision_state_single[14][1]|collision_state_single[15][1]|collision_state_single[16][1]|collision_state_single[17][1]|collision_state_single[18][1]|collision_state_single[19][1]|collision_state_single[20][1]|collision_state_single[21][1]|collision_state_single[22][1]|collision_state_single[23][1]|collision_state_single[24][1]|collision_state_single[25][1]|collision_state_single[26][1]|collision_state_single[27][1]|collision_state_single[28][1]|collision_state_single[29][1]|collision_state_single[30][1]|collision_state_single[31][1]|collision_state_single[32][1]|collision_state_single[33][1]|collision_state_single[34][1]|collision_state_single[35][1]|collision_state_single[36][1]|collision_state_single[37][1]|collision_state_single[38][1]|collision_state_single[39][1]|collision_state_single[40][1]|collision_state_single[41][1]|collision_state_single[42][1]|collision_state_single[43][1]|collision_state_single[44][1]|collision_state_single[45][1]|collision_state_single[46][1]|collision_state_single[47][1]|collision_state_single[48][1]|collision_state_single[49][1];
            collision_state[2] <= collision_state_single[0][2]|collision_state_single[1][2]|collision_state_single[2][2]|collision_state_single[3][2]|collision_state_single[4][2]|collision_state_single[5][2]|collision_state_single[6][2]|collision_state_single[7][2]|collision_state_single[8][2]|collision_state_single[9][2]|collision_state_single[10][2]|collision_state_single[11][2]|collision_state_single[12][2]|collision_state_single[13][2]|collision_state_single[14][2]|collision_state_single[15][2]|collision_state_single[16][2]|collision_state_single[17][2]|collision_state_single[18][2]|collision_state_single[19][2]|collision_state_single[20][2]|collision_state_single[21][2]|collision_state_single[22][2]|collision_state_single[23][2]|collision_state_single[24][2]|collision_state_single[25][2]|collision_state_single[26][2]|collision_state_single[27][2]|collision_state_single[28][2]|collision_state_single[29][2]|collision_state_single[30][2]|collision_state_single[31][2]|collision_state_single[32][2]|collision_state_single[33][2]|collision_state_single[34][2]|collision_state_single[35][2]|collision_state_single[36][2]|collision_state_single[37][2]|collision_state_single[38][2]|collision_state_single[39][2]|collision_state_single[40][2]|collision_state_single[41][2]|collision_state_single[42][2]|collision_state_single[43][2]|collision_state_single[44][2]|collision_state_single[45][2]|collision_state_single[46][2]|collision_state_single[47][2]|collision_state_single[48][2]|collision_state_single[49][2];
            collision_state[3] <= collision_state_single[0][3]|collision_state_single[1][3]|collision_state_single[2][3]|collision_state_single[3][3]|collision_state_single[4][3]|collision_state_single[5][3]|collision_state_single[6][3]|collision_state_single[7][3]|collision_state_single[8][3]|collision_state_single[9][3]|collision_state_single[10][3]|collision_state_single[11][3]|collision_state_single[12][3]|collision_state_single[13][3]|collision_state_single[14][3]|collision_state_single[15][3]|collision_state_single[16][3]|collision_state_single[17][3]|collision_state_single[18][3]|collision_state_single[19][3]|collision_state_single[20][3]|collision_state_single[21][3]|collision_state_single[22][3]|collision_state_single[23][3]|collision_state_single[24][3]|collision_state_single[25][3]|collision_state_single[26][3]|collision_state_single[27][3]|collision_state_single[28][3]|collision_state_single[29][3]|collision_state_single[30][3]|collision_state_single[31][3]|collision_state_single[32][3]|collision_state_single[33][3]|collision_state_single[34][3]|collision_state_single[35][3]|collision_state_single[36][3]|collision_state_single[37][3]|collision_state_single[38][3]|collision_state_single[39][3]|collision_state_single[40][3]|collision_state_single[41][3]|collision_state_single[42][3]|collision_state_single[43][3]|collision_state_single[44][3]|collision_state_single[45][3]|collision_state_single[46][3]|collision_state_single[47][3]|collision_state_single[48][3]|collision_state_single[49][3];
    end

    ////first bit: 0:left 1:right
    //second bit: 0: on the ground 1: in the air
    //third bit: 0:stand 1:move
    //coll    0人物下   1 上  2 右  3 左
    //wasd    0w  1a  2s  3d
        reg [9:0] left_cnt, right_cnt, up_cnt, down_cnt;
        reg isJump;
        reg [9:0] JumpTimer, FallTimer, JumpTimerUpdate, FallTimerUpdate;
        initial begin
            left_cnt <= 0;
            right_cnt <= 0;
            up_cnt <= 0;
            down_cnt <= 0;
            isJump <= 1'b0;
            JumpTimer <= 9'd25;
            FallTimer <= 9'd50;
            JumpTimerUpdate <= 0;
            FallTimerUpdate <= 0;
        end
        always @ (posedge clk_total) begin
            if(instruction[7:0] == R_KEY && instruction[8] == 1'b0)begin
                x_blue <= 10'd0;
                y_blue <= 9'd357;
            end
            else begin
                //update x_blue
                    if (wasd_down[1] == 1'b1 && wasd_down[3] == 1'b0 && collision_state[3] == 1'b0) begin//left
                        blue_state[0] <= 1'b0;
                        blue_state[2] <= 1'b1;
                        if(left_cnt < 75)begin
                            left_cnt <= left_cnt + 1;
                        end else begin
                            left_cnt <= 0;
                            x_blue <= x_blue - 10'd1;
                        end
                    end 
                    else if (wasd_down[3] == 1'b1 && collision_state[2] == 1'b0) begin
                        blue_state[0] <= 1'b1;
                        blue_state[2] <= 1'b1;
                        if(right_cnt < 75)begin
                            right_cnt <= right_cnt + 1;
                        end else begin
                            right_cnt <= 0;
                            x_blue <= x_blue + 10'd1;
                        end
                    end 
                    else begin
                        blue_state[2] <= 1'b0;
                    end
                //update y_blue
                //update the isJump
                    if(collision_state[1] == 1'b1 || JumpTimer >= 9'd50) begin//touch the ceiling
                        isJump = 1'b0;
                    end
                    else if(wasd_down[0] == 1'b1 && collision_state[0] == 1'b1) begin //jump from the ground
                        isJump = 1'b1;
                    end
                //implement the jump and fall
                    if(isJump == 1'b0)begin
                        JumpTimer <= 9'd25;
                        JumpTimerUpdate <= 0;
                        if(collision_state[0] == 1'b0) begin //fall from the air with increasing speed
                            if(FallTimerUpdate == 24) begin// decrease the timer to control the speed of the fall
                                if(FallTimer > 9'd20)
                                    FallTimer <= FallTimer - 9'd5;
                                else//the max speed of the fall
                                    FallTimer <= 9'd20;
                                FallTimerUpdate <= 0;
                            end else if(down_cnt < FallTimer)begin
                                down_cnt <= down_cnt + 1;
                            end else begin
                                down_cnt <= 0;
                                y_blue <= y_blue + 9'd1;
                                FallTimerUpdate <= FallTimerUpdate + 1;
                            end
                        end else begin
                            FallTimer <= 9'd50;
                            FallTimerUpdate <= 0;
                        end
                    end else begin//jump in the air with decreasing speed
                        FallTimer <= 9'd50;
                        FallTimerUpdate <= 0;
                        if(JumpTimerUpdate == 24) begin// increase the timer to control the speed of the jump
                            JumpTimer <= JumpTimer + 9'd5;
                            JumpTimerUpdate <= 0;
                        end else if(up_cnt < JumpTimer)begin
                            up_cnt <= up_cnt + 1;
                        end else begin
                            up_cnt <= 0;
                            y_blue <= y_blue - 9'd1;
                            JumpTimerUpdate <= JumpTimerUpdate + 1;
                        end
                    end
                //update the state of Jack
                    if (collision_state[0] == 1'b0) begin 
                        blue_state[1] <= 1'b1; //in the air
                    end else begin
                        blue_state[1] <= 1'b0; //on the ground
                    end
            end
        end
////////////////////////////////Implement the moves of the game//////////////////////////////
   

////////////////////////////////Assign the address of the photo to the address register//////////////////////////////
    //The address of the photo and the output of vga
    //背景1的地址寄存器和vga输出
    wire [11:0] vga_bg; 
    wire [11:0] vga_win;
    wire [11:0] vga_lose;
     // wire [11:0] vga_bg1;
    reg [18:0] bg;
    reg [18:0] win_lose;
    
    //蓝色小人静态图片的地址寄存器和vga输出
    wire [11:0]vga_blue;
    reg [13:0]blue;

    //The address of the monsters and the output of vga
    wire [11:0] vga_slim1;
    wire [11:0] vga_slim2;
    reg [13:0] slim1;
    reg [13:0] slim2;

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
        win_lose <=(col_addr_x>=180&&col_addr_x<=370&&row_addr_y>=134&&row_addr_y<=266)?(row_addr_y)*191+col_addr_x:0;
        //蓝色小人静态图片47*41（x_blue,y_blue）图片自带428的背景色
        blue<= (col_addr_x>=x_blue&&col_addr_x<=x_blue+46&&row_addr_y>=y_blue&&row_addr_y<=y_blue+40)?(row_addr_y-y_blue)*47+col_addr_x-x_blue:0;

        // //怪物1静止34*33（x_slim1,y_slim1）图片自带428的背景色
        slim1<= (col_addr_x>=x_slim1&&col_addr_x<=x_slim1+33&&row_addr_y>=y_slim1&&row_addr_y<=y_slim1+32)?(row_addr_y-y_slim1)*34+col_addr_x-x_slim1:0;
        slim2<= (col_addr_x>=x_slim2&&col_addr_x<=x_slim2+33&&row_addr_y>=y_slim2&&row_addr_y<=y_slim2+32)?(row_addr_y-y_slim2)*34+col_addr_x-x_slim2:0;

        //雪花1图片24*26（x_snowf1,y_snowf1）图片自带428的背景色
        for (integer i=0;i<snowflake_num;i=i+1)begin
            snowf[i]<= (col_addr_x>=x_snowf[i]&&col_addr_x<=x_snowf[i]+23&&row_addr_y>=y_snowf[i]&&row_addr_y<=y_snowf[i]+25)?(row_addr_y-y_snowf[i])*24+col_addr_x-x_snowf[i]:0;
        end

        //地面方块28*42（x_ground1,y_ground1）图片自带428的背景色
        for (integer i=0;i<ground_num;i=i+1)begin
            ground[i]<= (col_addr_x>=x_ground[i]&&col_addr_x<=x_ground[i]+27&&row_addr_y>=y_ground[i]&&row_addr_y<=y_ground[i]+41)?(row_addr_y-y_ground[i])*28+col_addr_x-x_ground[i]:0;
        end
    end

    //renew the image
    reg [31:0]ipcnt;
    //这里便能控制单次刷新后保持不变
    always @(posedge clk) begin
        if(ipcnt == 6_000_000) begin  // 40ms*100M=4M，由于计数器只有3位，所以这里实例只能计数到500k，所以选用了40ms/5=8ms，即2.5*100k
            ipcnt <= 0;
        end
        else begin
            ipcnt <= ipcnt + 1;
        end
    end
    //assign the address to the vga
    // begin_bg bg1(.clka(clk),.addra(bg),.douta(vga_bg1));
    background bg2(.clka(clk),.addra(bg),.douta(vga_bg));
    win winf(.clka(clk),.addra(win_lose),.douta(vga_win));
    lose losef(.clka(clk),.addra(win_lose),.douta(vga_lose));
    blue_show blue_show1(.clk(clk),.ipcnt(ipcnt),.blue(blue),.blue_state(blue_state),.vga_blue(vga_blue));
    slim_show slim_show_1(.col_addr_x(col_addr_x),.row_addr_y(row_addr_y),.clk(clk),.ipcnt(ipcnt),.slim_frozen(slim_frozen[0]),.vga_slim(vga_slim1),.x_slim(x_slim1),.y_slim(y_slim1));
    slim_show1 slim_show_2(.col_addr_x(col_addr_x),.row_addr_y(row_addr_y),.clk(clk),.ipcnt(ipcnt),.slim_frozen(slim_frozen[1]),.vga_slim(vga_slim2),.x_slim(x_slim2),.y_slim(y_slim2));
    genvar ground_show_i;
    generate
        for (ground_show_i=0;ground_show_i<ground_num;ground_show_i=ground_show_i+1)begin:ground_show
            ground_show ground_show_i(.clk(clk),.ipcnt(ipcnt),.ground(ground[ground_show_i]),.bk_touched(bk_touched[ground_show_i]),.vga_ground(vga_ground[ground_show_i]));
        end
    endgenerate

    genvar snow_show_i;
    generate
        for (snow_show_i=0;snow_show_i<snowflake_num;snow_show_i=snow_show_i+1)begin:snow_show
            snow_show snow_show_i(.clk(clk),.ipcnt(ipcnt),.snow(snowf[snow_show_i]),.snowf_get(snowf_get[snow_show_i]),.vga_snow(vga_snowf[snow_show_i]));
        end
    endgenerate
////////////////////////////////Assign the address of the photo to the address register//////////////////////////////

////////////////////////////////Image processing//////////////////////////////
    always@(posedge clk)begin
        //The rendering order is as follows:
        //1.背景
        if(col_addr_x>=0&&col_addr_x<=550&&row_addr_y>=0&&row_addr_y<=400)begin
            vga_data<=vga_bg[11:0];   
        end
        if(col_addr_x>550||row_addr_y>400)begin
            vga_data<=12'h000;
        end
        //2.方块
        for(integer i=0;i<ground_num;i=i+1)begin
            if(col_addr_x>=x_ground[i]&&col_addr_x<=x_ground[i]+27&&row_addr_y>=y_ground[i]&&row_addr_y<=y_ground[i]+41)begin
                if(vga_ground[i][11:0]!=4*256+2*16+8)begin
                    vga_data<=vga_ground[i][11:0];   
                end
            end
        end
        //5. snowflakes
        for(integer i=0;i<snowflake_num;i=i+1)begin
            if(col_addr_x>=x_snowf[i]&&col_addr_x<=x_snowf[i]+23&&row_addr_y>=y_snowf[i]&&row_addr_y<=y_snowf[i]+25)begin
                if(vga_snowf[i][11:0]!=4*256+2*16+8)begin
                    vga_data<=vga_snowf[i][11:0];   
                end
            end
        end

        //6.怪物34*33 428
        if(col_addr_x>=x_slim1&&col_addr_x<=x_slim1+33&&row_addr_y>=y_slim1&&row_addr_y<=y_slim1+32)begin
            if(vga_slim1!=4*256+2*16+8)begin
                vga_data<=vga_slim1;   
            end
        end

        if(col_addr_x>=x_slim2&&col_addr_x<=x_slim2+33&&row_addr_y>=y_slim2&&row_addr_y<=y_slim2+32)begin
            if(vga_slim2!=4*256+2*16+8)begin
                vga_data<=vga_slim2;   
            end
        end

        //7.蓝色小人 47*41 428
        if(col_addr_x>=x_blue&&col_addr_x<=x_blue+46&&row_addr_y>=y_blue&&row_addr_y<=y_blue+40)begin
            if(vga_blue[11:0]!=4*256+2*16+8)begin
                vga_data<=vga_blue[11:0];   
            end
        end
        //win or lose 
        if(game==2'b11&&col_addr_x>=180&&col_addr_x<=370&&row_addr_y>=134&&row_addr_y<=266)begin
            vga_data<=vga_win;   
        end
        if(game==2'b10&&col_addr_x>=180&&col_addr_x<=370&&row_addr_y>=134&&row_addr_y<=266)begin
            vga_data<=vga_lose;   
        end
    end
////////////////////////////////Image processing//////////////////////////////

endmodule
