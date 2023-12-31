`timescale 1ns / 1ps

module ps2_ver2(
input clk,//clock
input rst,//reset
input ps2_clk,//ps2_clk
input ps2_data,
output [9:0] data_out,//data output
output ready
);
    reg ps2_clk_flag0, ps2_clk_flag1, ps2_clk_flag2;
    //ps2_clk_flag0 is the current ps2_clk, ps2_clk_flag1 is the last ps2_clk, ps2_clk_flag2 is the last last ps2_clk
    wire negedge_ps2_clk;
    always@(posedge clk or posedge rst)begin
        if(rst)begin
            ps2_clk_flag0<=1'b0;
            ps2_clk_flag1<=1'b0;
            ps2_clk_flag2<=1'b0;
        end
        else begin
            ps2_clk_flag0<=ps2_clk;
            ps2_clk_flag1<=ps2_clk_flag0;
            ps2_clk_flag2<=ps2_clk_flag1;
        end
    end
    assign negedge_ps2_clk=!ps2_clk_flag1&ps2_clk_flag2;//get the negedge of ps2_clk
    //num is used to count the number of negedge of ps2_clk
    reg[3:0]num;
    always@(posedge clk or posedge rst)begin
        if(rst)
            num<=4'd0;
        else if (num==4'd11)//if num==11, num is reset to 0
            num<=4'd0;
        else if (negedge_ps2_clk)//if ps2_clk is negedge, num++
            num<=num+1'b1;
    end
    reg negedge_ps2_clk_shift;
    always@(posedge clk)begin
        negedge_ps2_clk_shift<=negedge_ps2_clk;
    end
    reg[7:0]temp_data;
    always@(posedge clk or posedge rst)begin
        if(rst)
            temp_data<=8'd0;
        else if (negedge_ps2_clk_shift)begin//when negedge occurs, read in one bit data
            case(num)
            4'd2 : temp_data[0]<=ps2_data;
            4'd3 : temp_data[1]<=ps2_data;
            4'd4 : temp_data[2]<=ps2_data;
            4'd5 : temp_data[3]<=ps2_data;
            4'd6 : temp_data[4]<=ps2_data;
            4'd7 : temp_data[5]<=ps2_data;
            4'd8 : temp_data[6]<=ps2_data;
            4'd9 : temp_data[7]<=ps2_data;
            default: temp_data<=temp_data;
            endcase
        end
        else temp_data<=temp_data;
    end
    reg [9:0] data;
    reg data_break, data_ready, data_expand;
    always@(posedge clk or posedge rst)begin
        if(rst)begin
            data_break<=1'b0;
            data<=10'd0;
            data_ready<=1'b0;
            data_expand<=1'b0;
        end
        else if(num==4'd11)begin
            if(temp_data==8'hE0)begin
                data_expand<=1'b1;
            end
            else if(temp_data==8'hF0)begin
                data_break<=1'b1;
            end
            else begin
                data<={data_expand,data_break,temp_data};
                data_ready<=1'b1;
                data_expand<=1'b0;
                data_break<=1'b0;
            end
        end
        else begin
            data<=data;
            data_ready<=1'b0;
            data_expand<=data_expand;
            data_break<=data_break;
        end
    end
    assign data_out=data;
    assign ready=data_ready;
endmodule