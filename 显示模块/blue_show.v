`timescale 1ms / 10ns
module blue_show(
    input clk,
    input [31:0]ipcnt,
    input [13:0]blue,
    input [2:0]blue_state,
    output reg [11:0]vga_blue
);
//record the state of Jack
//first bit: 0:left 1:right
//second bit: 0: on the ground 1: in the air
//third bit: 0:stand 1:move
reg [13:0]blue_l;
always@(posedge clk)begin
blue_l[13:0]<=(14'd46-blue[13:0] % 14'd47)+(blue[13:0]/14'd47)*14'd47;
end

//蓝色小人向右静止的图片像素值  1 5 9 13
wire [11:0]vga_blue_st_1,vga_blue_st_5,vga_blue_st_9,vga_blue_st_13;
blue_static_1 blue_st_1f(.clka(clk),.addra(blue),.douta(vga_blue_st_1));
blue_static_5 blue_st_5f(.clka(clk),.addra(blue),.douta(vga_blue_st_5));
blue_static_9 blue_st_9f(.clka(clk),.addra(blue),.douta(vga_blue_st_9));
blue_static_13 blue_st_13f(.clka(clk),.addra(blue),.douta(vga_blue_st_13));
//蓝色小人向左静止的图片像素值  1 5 9 13
wire [11:0]vga_bl_st_l1,vga_bl_st_l5,vga_bl_st_l9,vga_bl_st_l13;
blue_static_1 blue_st_1lf(.clka(clk),.addra(blue_l),.douta(vga_bl_st_l1));
blue_static_5 blue_st_5lf(.clka(clk),.addra(blue_l),.douta(vga_bl_st_l5));
blue_static_9 blue_st_9lf(.clka(clk),.addra(blue_l),.douta(vga_bl_st_l9));
blue_static_13 blue_st_13lf(.clka(clk),.addra(blue_l),.douta(vga_bl_st_l13));
//蓝色小人向右奔跑的图片像素值  1 5 9 13
wire [11:0]vga_blue_rwk_1,vga_blue_rwk_5,vga_blue_rwk_9,vga_blue_rwk_13;
blue_r_walk_1 blue_rwk_1f(.clka(clk),.addra(blue),.douta(vga_blue_rwk_1));
blue_r_walk_5 blue_rwk_5f(.clka(clk),.addra(blue),.douta(vga_blue_rwk_5));
blue_r_walk_9 blue_rwk_9f(.clka(clk),.addra(blue),.douta(vga_blue_rwk_9));
blue_r_walk_13 blue_rwk_13f(.clka(clk),.addra(blue),.douta(vga_blue_rwk_13));
//蓝色小人向左奔跑的图片像素值  1 5 9 13
wire [11:0]vga_bl_lwk_1,vga_bl_lwk_5,vga_bl_lwk_9,vga_bl_lwk_13;
blue_r_walk_1 blue_lwk_1f(.clka(clk),.addra(blue_l),.douta(vga_bl_lwk_1));
blue_r_walk_5 blue_lwk_5f(.clka(clk),.addra(blue_l),.douta(vga_bl_lwk_5));
blue_r_walk_9 blue_lwk_9f(.clka(clk),.addra(blue_l),.douta(vga_bl_lwk_9));
blue_r_walk_13 blue_lwk_13f(.clka(clk),.addra(blue_l),.douta(vga_bl_lwk_13));
//蓝色小人向右跳跃的图片像素值  1 5 9 13
wire [11:0]vga_blue_jump;
blue_jump blue_jumpf(.clka(clk),.addra(blue),.douta(vga_blue_jump));
//蓝色小人向左跳跃的图片像素值  1 5 9 13
wire [11:0]vga_bl_ljump;
blue_jump blue_ljumpf(.clka(clk),.addra(blue_l),.douta(vga_bl_ljump));
//ip帧率ip_blue
reg [3:0]ip_blue;
always @(posedge clk )begin
    if(ipcnt == 6000000)begin
        ip_blue <=ip_blue+1;
    end
//record the state of Jack
//first bit: 0:left 1:right
//second bit: 0: on the ground 1: in the air
//third bit: 0:stand 1:move
    if(blue_state[1]==1)begin
        if(blue_state[0]==1)begin
        case(ip_blue)
                0:vga_blue <= vga_blue_jump;
                1:vga_blue <= vga_blue_jump;
                2:vga_blue <= vga_blue_jump;
                3:vga_blue <= vga_blue_jump;
                4:vga_blue <= vga_blue_jump;
                5:vga_blue <= vga_blue_jump;
                6:vga_blue <= vga_blue_jump;
                7:vga_blue <= vga_blue_jump;
                8:vga_blue <= vga_blue_jump;
                9:vga_blue <= vga_blue_jump;
                10:vga_blue <= vga_blue_jump;
                11:vga_blue <= vga_blue_jump;
                12:vga_blue <= vga_blue_jump;
                13:vga_blue <= vga_blue_jump;
                14:vga_blue <= vga_blue_jump;
                15:begin
                    vga_blue <= vga_blue_jump;
                    ip_blue <= 0;
                end
        endcase
        end
        if(blue_state[1]==0)begin
            case(ip_blue)
                 0:vga_blue <= vga_blue_jump;
                1:vga_blue <= vga_blue_jump;
                2:vga_blue <= vga_blue_jump;
                3:vga_blue <= vga_blue_jump;
                4:vga_blue <= vga_blue_jump;
                5:vga_blue <= vga_blue_jump;
                6:vga_blue <= vga_blue_jump;
                7:vga_blue <= vga_blue_jump;
                8:vga_blue <= vga_blue_jump;
                9:vga_blue <= vga_blue_jump;
                10:vga_blue <= vga_blue_jump;
                11:vga_blue <= vga_blue_jump;
                12:vga_blue <= vga_blue_jump;
                13:vga_blue <= vga_blue_jump;
                14:vga_blue <= vga_blue_jump;
                15:begin
                    vga_blue <= vga_blue_jump;
                    ip_blue <= 0;
                end
        endcase
        end
    end
    else if(blue_state[1]==0)begin
        if(blue_state[0]==0&&blue_state[2]==0)begin
            case(ip_blue)
            0:vga_blue <= vga_bl_st_l1;
            1:vga_blue <= vga_bl_st_l1;
            2:vga_blue <= vga_bl_st_l1;
            3:vga_blue <= vga_bl_st_l1;
            4:vga_blue <= vga_bl_st_l5;
            5:vga_blue <= vga_bl_st_l5;
            6:vga_blue <= vga_bl_st_l5;
            7:vga_blue <= vga_bl_st_l5;
            8:vga_blue <= vga_bl_st_l9;
            9:vga_blue <= vga_bl_st_l9;
            10:vga_blue <= vga_bl_st_l9;
            11:vga_blue <= vga_bl_st_l9;
            12:vga_blue <= vga_bl_st_l13;
            13:vga_blue <= vga_bl_st_l13;
            14:vga_blue <= vga_bl_st_l13;
            15:begin
                vga_blue <= vga_bl_st_l1;
                ip_blue <= 0;
            end
        endcase
        end
        if(blue_state[0]==0&&blue_state[2]==1)begin
            case(ip_blue)
            0:vga_blue <= vga_bl_lwk_1;
            1:vga_blue <= vga_bl_lwk_1;
            2:vga_blue <= vga_bl_lwk_1;
            3:vga_blue <= vga_bl_lwk_1;
            4:vga_blue <= vga_bl_lwk_5;
            5:vga_blue <= vga_bl_lwk_5;
            6:vga_blue <= vga_bl_lwk_5;
            7:vga_blue <= vga_bl_lwk_5;
            8:vga_blue <= vga_bl_lwk_9;
            9:vga_blue <= vga_bl_lwk_9;
            10:vga_blue <= vga_bl_lwk_9;
            11:vga_blue <= vga_bl_lwk_9;
            12:vga_blue <= vga_bl_lwk_13;
            13:vga_blue <= vga_bl_lwk_13;
            14:vga_blue <= vga_bl_lwk_13;
            15:begin
                vga_blue <= vga_bl_lwk_1;
                ip_blue <= 0;
            end
            endcase
        end
        if(blue_state[0]==1&&blue_state[2]==0)begin
            case(ip_blue)
            0:vga_blue <= vga_blue_st_1;
            1:vga_blue <= vga_blue_st_1;
            2:vga_blue <= vga_blue_st_1;
            3:vga_blue <= vga_blue_st_1;
            4:vga_blue <= vga_blue_st_5;
            5:vga_blue <= vga_blue_st_5;
            6:vga_blue <= vga_blue_st_5;
            7:vga_blue <= vga_blue_st_5;
            8:vga_blue <= vga_blue_st_9;
            9:vga_blue <= vga_blue_st_9;
            10:vga_blue <= vga_blue_st_9;
            11:vga_blue <= vga_blue_st_9;
            12:vga_blue <= vga_blue_st_13;
            13:vga_blue <= vga_blue_st_13;
            14:vga_blue <= vga_blue_st_13;
            15:begin
                vga_blue <= vga_blue_st_1;
                ip_blue <= 0;
            end
            endcase
        end
        if(blue_state[0]==1&&blue_state[2]==1)begin
            case(ip_blue)
                0:vga_blue <= vga_blue_rwk_1;
            1:vga_blue <= vga_blue_rwk_1;
            2:vga_blue <= vga_blue_rwk_1;
            3:vga_blue <= vga_blue_rwk_1;
            4:vga_blue <= vga_blue_rwk_5;
            5:vga_blue <= vga_blue_rwk_5;
            6:vga_blue <= vga_blue_rwk_5;
            7:vga_blue <= vga_blue_rwk_5;
            8:vga_blue <= vga_blue_rwk_9;
            9:vga_blue <= vga_blue_rwk_9;
            10:vga_blue <= vga_blue_rwk_9;
            11:vga_blue <= vga_blue_rwk_9;
            12:vga_blue <= vga_blue_rwk_13;
            13:vga_blue <= vga_blue_rwk_13;
            14:vga_blue <= vga_blue_rwk_13;
            15:begin
                vga_blue <= vga_blue_rwk_1;
                ip_blue <= 0;
            end
        endcase
        end
       end
        
    
end
endmodule

