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