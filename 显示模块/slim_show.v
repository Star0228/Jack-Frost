`timescale 1ms / 10ns
module slim_show(
    input clk,
    input [31:0]ipcnt,
    input [13:0]slim,
    output reg [11:0]vga_slim
    );
//3帧  1  3   7    1
//34*33
//slim state

reg [13:0]slim_r;
always@(posedge clk)begin
slim_r[13:0]<=(14'd33-slim[13:0] % 14'd34)+(slim[13:0]/14'd34)*14'd34;
end
//slim 向左移动
wire [11:0]vga_smw_l1;
wire [11:0]vga_smw_l2;
wire [11:0]vga_smw_l3;
slim_l_walk_1 smw_l1f(.clka(clk),.addra(slim),.douta(vga_smw_l1));
slim_l_walk_3 smw_l2f(.clka(clk),.addra(slim),.douta(vga_smw_l2));
slim_l_walk_7 smw_l3f(.clka(clk),.addra(slim),.douta(vga_smw_l3));
//slim 向右移动
wire [11:0]vga_smw_r1;
wire [11:0]vga_smw_r2;
wire [11:0]vga_smw_r3;
slim_l_walk_1 smw_r1f(.clka(clk),.addra(slim_r),.douta(vga_smw_r1));
slim_l_walk_3 smw_r2f(.clka(clk),.addra(slim_r),.douta(vga_smw_r2));
slim_l_walk_7 smw_r3f(.clka(clk),.addra(slim_r),.douta(vga_smw_r3));
//slim 左冰冻1 3 9   冰冻的大小还没改变
wire [11:0]vga_smf_l1;
wire [11:0]vga_smf_l2;
wire [11:0]vga_smf_l3;
slim_frozen_1 smf_l1f(.clka(clk),.addra(slim),.douta(vga_smf_l1));
slim_frozen_3 smf_l2f(.clka(clk),.addra(slim),.douta(vga_smf_l2));
slim_frozen_9 smf_l3f(.clka(clk),.addra(slim),.douta(vga_smf_l3));
//slim 右冰冻1 3 9  冰冻的大小还没改变
wire [11:0]vga_smf_r1;
wire [11:0]vga_smf_r2;
wire [11:0]vga_smf_r3;
slim_frozen_1 smf_r1f(.clka(clk),.addra(slim_r),.douta(vga_smf_r1));
slim_frozen_3 smf_r2f(.clka(clk),.addra(slim_r),.douta(vga_smf_r2));
slim_frozen_9 smf_r3f(.clka(clk),.addra(slim_r),.douta(vga_smf_r3));

reg [3:0]ip_slim;
always @(posedge clk )begin
    if(ipcnt == 6000000)begin
        ip_slim <=ip_slim+1;
    end
    case(ip_slim)
        0:vga_slim <= vga_smw_l1;
        1:vga_slim <= vga_smw_l1;
        2:vga_slim <= vga_smw_l2;
        3:vga_slim <= vga_smw_l2;
        4:vga_slim <= vga_smw_l2;
        5:vga_slim <= vga_smw_l2;
        6:vga_slim <= vga_smw_l3;
        7:vga_slim <= vga_smw_l3;
        8:vga_slim <= vga_smw_l3;
        9:vga_slim <= vga_smw_l3;
        10:vga_slim <= vga_smw_l3;
        11:vga_slim <= vga_smw_l3;
        12:vga_slim <= vga_smw_l3;
        13:vga_slim <= vga_smw_l3;
        14:vga_slim <= vga_smw_l3;
        15:begin
            vga_slim <=vga_smw_l1 ;
            ip_slim <= 0;
        end
    endcase
end
endmodule
//使用的时候直接调用slim_show模块，输入
//slim_show slim_f1(.clk(clk),.ipcnt(ipcnt),.slim(slim[13:0]),.vga_slim(vga_slimf1));