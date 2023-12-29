    `timescale 1ms / 10ns
    module top(
        input clk,
        input rstn,
        input ps2_clk,ps2_data,
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
    //first bit: 0:left 1:right
    //second bit: 0: on the ground 1: in the air
    //third bit: 0:stand 1:move
    reg [2:0]blue_state;

    initial begin
        x_blue=10'd0;
        y_blue=9'd0;
        blue_state=3'b001;
    end
   
    //Initialize the coordinate of the monsters with loop
    parameter monster_num = 2;
    reg [9:0]x_slim[0:monster_num-1];
    reg [8:0]y_slim[0:monster_num-1];
    initial begin
        for (integer i=0;i<monster_num;i=i+1)begin
            x_slim[i]=10'd48*(i+1);
            y_slim[i]=9'd0;
        end
    end
    //Initialize snowflake's coordinate with loop
    parameter snowflake_num = 15;
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
    parameter ground_num = 50;
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

////////////////////////////////Implement the moves of the game//////////////////////////////
    // Instantiate the PS2 Keyboard module
    wire [7:0] instruction;
    wire ready, overflow, rdn;
    initial begin
        rdn = 1'b0;
    end
    ps2_keyboard keyboard (.clk(clk), .clrn(1'b1), .ps2_clk(ps2_clk), .ps2_data(ps2_data), .rdn(rdn), .data(instruction), .ready(ready), .overflow(overflow));
    reg [1:0] direction;

    // Mapping WASD keys to specific scan codes
    parameter W_KEY = 8'h1d; // Scan code for 'W' key
    parameter A_KEY = 8'h1c; // Scan code for 'A' key
    parameter S_KEY = 8'h1b; // Scan code for 'S' key
    parameter D_KEY = 8'h23; // Scan code for 'D' key

    always @(posedge clk) 
    begin
        if (ready) 
        begin
            blue_state[2]=1'b1;
            // W key is pressed
            if(instruction == W_KEY) 
            begin
                y_blue = y_blue - 1; 
                direction = 2'b00;
                blue_state[1] = 1'b1;
            end
            // S key is pressed
            else if(instruction == S_KEY) 
            begin
                y_blue = y_blue + 1;
                direction = 2'b01;
            end
            // A key is pressed
            else if(instruction == A_KEY) 
            begin 
                x_blue = x_blue - 1;
                direction = 2'b10;
                blue_state[0]=1'b0;
            end
            // D key is pressed
            else if(instruction == D_KEY) 
            begin
                x_blue = x_blue + 1;
                direction = 2'b11;
                blue_state[0]=1'b1;
            end
        end
        else
        begin
            blue_state[2]=1'b0;
        end
    end
////////////////////////////////Implement the moves of the game//////////////////////////////
   

////////////////////////////////Assign the address of the photo to the address register//////////////////////////////
    //The address of the photo and the output of vga
    //背景1的地址寄存器和vga输出
    reg [18:0] bg;
    wire [11:0] vga_bg; 
    //蓝色小人静态图片的地址寄存器和vga输出
    reg [13:0]blue_st;
    reg [11:0]vga_blue_st;
    
    //The address of the monsters and the output of vga
    reg [11:0] vga_slim_st[0:monster_num-1];
    reg [13:0] slim_st[0:monster_num-1];

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

    //update the signal with loop
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
        for(integer i=0;i<ground_num;i=i+1)begin
            if(col_addr_x>=x_ground[i]&&col_addr_x<=x_ground[i]+27&&row_addr_y>=y_ground[i]&&row_addr_y<=y_ground[i]+41)begin
                if(vga_ground[i][11:0]!=0*256+2*16+8)begin
                    vga_data<=vga_ground[i][11:0];   
                end
            end
        end
        //3.树
        //4.小石块
        //5. snowflakes
        for(integer i=0;i<snowflake_num;i=i+1)begin
            if(col_addr_x>=x_snowf[i]&&col_addr_x<=x_snowf[i]+23&&row_addr_y>=y_snowf[i]&&row_addr_y<=y_snowf[i]+25)begin
                if(vga_snowf[i][11:0]!=0*256+2*16+8)begin
                    vga_data<=vga_snowf[i][11:0];   
                end
            end
        end

        //6.怪物62*36 028
        if(col_addr_x>=x_slim[0]&&col_addr_x<=x_slim[0]+61&&row_addr_y>=y_slim[0]&&row_addr_y<=y_slim[0]+35)begin
            if(vga_slim_st[0]!=0*256+2*16+8)begin
                vga_data<=vga_slim_st[0];   
            end
        end
        if(col_addr_x>=x_slim[1]&&col_addr_x<=x_slim[1]+61&&row_addr_y>=y_slim[1]&&row_addr_y<=y_slim[1]+35)begin
            if(vga_slim_st[1]!=0*256+2*16+8)begin
                vga_data<=vga_slim_st[0];   
            end
        end

        //7.蓝色小人 47*41 428
        if(col_addr_x>=x_blue&&col_addr_x<=x_blue+46&&row_addr_y>=y_blue&&row_addr_y<=y_blue+40)begin
            if(vga_blue_st[11:0]!=4*256+2*16+8)begin
                vga_data<=vga_blue_st[11:0];   
            end
        end
    end
////////////////////////////////Image processing//////////////////////////////

endmodule
