`timescale 1ms / 10ns
module blue_show(
    input clk,
    input [31:0]ipcnt,
    input [11:0]blue,
    input [2:0]blue_state,
    output reg [11:0]vga_blue
);
//blue state 000->right static 001->right_walk ,  010->right_jump, 100->left static 101->left_walk ,  110->left_jump
reg blue_r;
assign blue_r = (46-blue % 47)+blue/47;
//蓝色小人向右静止的图片像素值  1 5 9 13
wire [11:0]vga_blue_st_1,vga_blue_st_5,vga_blue_st_9,vga_blue_st_13;
blue_static_1 blue_st_1f(.clka(clk),.addra(blue),.douta(vga_blue_st_1));
blue_static_5 blue_st_5f(.clka(clk),.addra(blue),.douta(vga_blue_st_2));
blue_static_9 blue_st_9f(.clka(clk),.addra(blue),.douta(vga_blue_st_3));
blue_static_13 blue_st_13f(.clka(clk),.addra(blue),.douta(vga_blue_st_4));
//蓝色小人向左静止的图片像素值  1 5 9 13
//0-1926   0<->46  1<->45

wire [11:0]vga_bl_st_l1,vga_bl_st_l5,vga_bl_st_l9,vga_bl_st_l13;
blue_static_1 blue_st_1f(.clka(clk),.addra(blue),.douta(vga_blue_st_1));

//蓝色小人向右奔跑的图片像素值  1 5 9 13
wire [11:0]vga_blue_rwk_1,vga_blue_rwk_5,vga_blue_rwk_9,vga_blue_rwk_13;
blue_r_walk_1 blue_rwk_1f(.clka(clk),.addra(blue),.douta(vga_blue_rwk_1));
blue_r_walk_5 blue_rwk_5f(.clka(clk),.addra(blue),.douta(vga_blue_rwk_5));
blue_r_walk_9 blue_rwk_9f(.clka(clk),.addra(blue),.douta(vga_blue_rwk_9));
blue_r_walk_13 blue_rwk_13f(.clka(clk),.addra(blue),.douta(vga_blue_rwk_13));
//蓝色小人跳跃
wire vga_blue_jump;
blue_jump blue_jumpf(.clka(clk),.addra(blue),.douta(vga_blue_jump));
always @(posedge clk )begin
    if(blue_state[2]==1)
end







// reg [4:0]ip_blue;
// always @(posedge clk )begin
//     if(ipcnt == 6000000)begin
//         ip_blue <=ip_blue+1;
//     end
//     case(ip_blue)
//         0:vga_blue <= vga_blue_1;
//         13:vga_blue <= vga_blue_2;
//         31:begin
//             vga_blue <= vga_blue_3;
//              bk_tc_finish <= 1;
//         end
//     endcase
// end
endmodule

