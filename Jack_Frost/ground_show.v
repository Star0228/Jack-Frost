`timescale 1ms / 10ns
module ground_show(
    input clk,
    input [31:0]ipcnt,
    input [11:0]ground,
    input bk_touched,
    output reg [11:0]vga_ground
    );
//只放三帧
wire [11:0]vga_ground_1;
wire [11:0]vga_ground_2;
wire [11:0]vga_ground_3;
wire [11:0]vga_ground_4;
ground_1 ground_f1(.clka(clk),.addra(ground),.douta(vga_ground_1));//ip核
ground_4 ground_f2(.clka(clk),.addra(ground),.douta(vga_ground_2));
ground_5 ground_f3(.clka(clk),.addra(ground),.douta(vga_ground_3));
ground_6 ground_f4(.clka(clk),.addra(ground),.douta(vga_ground_4));
reg bk_tc_finish;
reg [4:0]ip_ground;
always @(posedge clk )begin
    if(ipcnt == 6000000&&bk_touched&& !bk_tc_finish)begin
        ip_ground <=ip_ground+1;
    end
    case(ip_ground)
        0:vga_ground <= vga_ground_1;
        1:vga_ground <= vga_ground_1;
        2:vga_ground <= vga_ground_1;
        3:vga_ground <= vga_ground_1;
        4:vga_ground <= vga_ground_1;
        5:vga_ground <= vga_ground_1;
        6:vga_ground <= vga_ground_1;
        7:vga_ground <= vga_ground_1;
        8:vga_ground <= vga_ground_1;
        9:vga_ground <= vga_ground_1;
        10:vga_ground <= vga_ground_1;
        11:vga_ground <= vga_ground_1;
        12:vga_ground <= vga_ground_1;
        13:vga_ground <= vga_ground_1;
        14:vga_ground <= vga_ground_1;
        15:vga_ground <= vga_ground_2;
        16:vga_ground <= vga_ground_2;
        17:vga_ground <= vga_ground_2;
        18:vga_ground <= vga_ground_3;
        19:vga_ground <= vga_ground_3;
        20:vga_ground <= vga_ground_3;
        21:vga_ground <= vga_ground_3;
        22:begin
            vga_ground <= vga_ground_4;
             bk_tc_finish <= 1;
        end
    endcase
    if(bk_tc_finish&&bk_touched)begin
        vga_ground <= vga_ground_4;
    end
end
endmodule
///使用的时候直接调用ground_show模块，输入
//ground_show ground1_show(.clk(clk),.ipcnt(ipcnt),.ground(ground[11:0]),.bk_touched(bk_touched[0]),.vga_ground(vga_ground1));
//ground_show ground2_show(.clk(clk),.ipcnt(ipcnt),.ground(ground[11:0]),.bk_touched(bk_touched[1]),.vga_ground(vga_ground2));
//ground_show ground3_show(.clk(clk),.ipcnt(ipcnt),.ground(ground[11:0]),.bk_touched(bk_touched[2]),.vga_ground(vga_ground3));



