`timescale 1ms / 10ns
module slim_show1(
    input clk,
    input [31:0]ipcnt,
    input slim_frozen,
    input [9:0]col_addr_x,
    input [8:0]row_addr_y,
    output reg [11:0]vga_slim,
    output reg [9:0]x_slim,
    output reg [8:0]y_slim
    );
//3帧  1  3   7    1
//34*33
initial begin
    x_slim <= 10'd240;
    y_slim <= 9'd192;
end
reg [13:0]slim;
reg [13:0]slim_r;
always@(posedge clk)begin
slim = (col_addr_x>=x_slim&&col_addr_x<=x_slim+33&&row_addr_y>=y_slim&&row_addr_y<=y_slim+32)?(row_addr_y-y_slim)*34+col_addr_x-x_slim:0;
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
//slim 左冰冻1 3 9  
wire [11:0]vga_smf_l1;
wire [11:0]vga_smf_l2;
wire [11:0]vga_smf_l3;
slim_frozen_1 smf_l1f(.clka(clk),.addra(slim),.douta(vga_smf_l1));
slim_frozen_3 smf_l2f(.clka(clk),.addra(slim),.douta(vga_smf_l2));
slim_frozen_9 smf_l3f(.clka(clk),.addra(slim),.douta(vga_smf_l3));
//slim 右冰冻1 3 9  
wire [11:0]vga_smf_r1;
wire [11:0]vga_smf_r2;
wire [11:0]vga_smf_r3;
slim_frozen_1 smf_r1f(.clka(clk),.addra(slim_r),.douta(vga_smf_r1));
slim_frozen_3 smf_r2f(.clka(clk),.addra(slim_r),.douta(vga_smf_r2));
slim_frozen_9 smf_r3f(.clka(clk),.addra(slim_r),.douta(vga_smf_r3));

reg [6:0]ip_slim;//127
reg [6:0]ip_slim_fz;
reg slim_state;
//0: left  1:right
always @(posedge clk )begin
    if(ipcnt == 6000000&&!slim_frozen)begin
        ip_slim_fz <=0;
        ip_slim <=(ip_slim+1)%127;
        if(slim_state==0)begin
            x_slim <= x_slim-10'd1;
        end
        else begin
            x_slim <= x_slim+10'd1;
        end        
        if(ip_slim==63)begin
            slim_state <= ~slim_state;
        end
    end
    if(ipcnt == 6000000&&slim_frozen)begin
        ip_slim_fz <=ip_slim_fz+1;
    end
    if(slim_frozen)begin
        if(slim_state==0)begin
        case(ip_slim_fz)
        0:vga_slim <= vga_smf_l1;
        1:vga_slim <= vga_smf_l1;
        2:vga_slim <= vga_smf_l2;
        3:vga_slim <= vga_smf_l2;
        4:vga_slim <= vga_smf_l2;
        5:vga_slim <= vga_smf_l2;
        6:vga_slim <= vga_smf_l2;
        7:vga_slim <= vga_smf_l2;
        127:begin
            vga_slim <=vga_smf_l1 ;
            ip_slim_fz <= 0;
        end
        default:vga_slim <= vga_smf_l3;
        endcase
        end
        else begin
        case(ip_slim_fz)
        0:vga_slim <= vga_smf_r1;
        1:vga_slim <= vga_smf_r1;
        2:vga_slim <= vga_smf_r2;
        3:vga_slim <= vga_smf_r2;
        4:vga_slim <= vga_smf_r2;
        5:vga_slim <= vga_smf_r2;
        6:vga_slim <= vga_smf_r2;
        7:vga_slim <= vga_smf_r2;
        127:begin
            vga_slim <=vga_smf_r1 ;
            ip_slim_fz <= 0;
        end
        default:vga_slim <= vga_smf_r3;
        endcase
        end
    end
    else begin 
        if(slim_state==0)begin
        case(ip_slim%9)
        0:vga_slim <= vga_smw_l1;
        1:vga_slim <= vga_smw_l1;
        2:vga_slim <= vga_smw_l2;
        3:vga_slim <= vga_smw_l2;
        4:vga_slim <= vga_smw_l2;
        5:vga_slim <= vga_smw_l2;
        6:vga_slim <= vga_smw_l3;
        7:vga_slim <= vga_smw_l3;
        8:vga_slim <= vga_smw_l3;
        endcase
        end
        else begin  
        case(ip_slim%9)
        0:vga_slim <= vga_smw_r1;
        1:vga_slim <= vga_smw_r1;
        2:vga_slim <= vga_smw_r2;
        3:vga_slim <= vga_smw_r2;
        4:vga_slim <= vga_smw_r2;
        5:vga_slim <= vga_smw_r2;
        6:vga_slim <= vga_smw_r3;
        7:vga_slim <= vga_smw_r3;
        8:vga_slim <= vga_smw_r3;
        endcase
        end
    end
end
endmodule
