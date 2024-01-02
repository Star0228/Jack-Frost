`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2017 10:48:43 PM
// Design Name: 
// Module Name: ps2_keyboard
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ps2_keyboard (
  input clk, clrn, ps2_clk, ps2_data, rdn, 
  output [7:0] data, 
  output ready, overflow,
  output [3:0] wsad_down // WASD按键状态
);
  reg overflow;     // fifo overflow
  reg [3:0] count;     // count ps2_data bits, internal signal, for test
  reg [9:0] buffer;     // ps2_data bits
  reg [7:0] fifo[7:0];   // data fifo
  reg [2:0] w_ptr, r_ptr;  // fifo write and read pointers
  reg [2:0] ps2_clk_sync;
  reg [3:0] wsad_keys_released; // WASD键释放标记变量

  always @ (posedge clk) begin
    ps2_clk_sync <= {ps2_clk_sync[1:0],ps2_clk};
  end
  wire sampling = ps2_clk_sync[2] & ~ps2_clk_sync[1];
  always @ (posedge clk) begin
    if (clrn == 0) begin
        count <= 0;
        w_ptr <= 0;
        r_ptr <= 0;
        overflow <= 0;
        wsad_keys_released <= 4'b1111; // 所有键默认为释放状态
    end else if (sampling) begin
        if (count == 4'd10) begin
            if ((buffer[0] == 0) &&   // start bit
               (ps2_data) &&     // stop bit
               (~buffer[9:1])) begin   // 
                   fifo[w_ptr] <= buffer[8:1];   // kbd scan code
                   w_ptr <= w_ptr + 3'b1;
                   overflow <= overflow |  (r_ptr == (w_ptr + 3'b1));
                   // 在此处增加 WASD键检测
                   case (buffer[8:1])
                       8'h1D: wsad_keys_released[0] <= 0; // W键按下
                       8'h1C: wsad_keys_released[1] <= 0; // A键按下
                       8'h23: wsad_keys_released[2] <= 0; // S键按下
                       8'h1B: wsad_keys_released[3] <= 0; // D键按下
                       default:;
                   endcase
                          end  
                   count <= 0; // for next
            end else begin
                   buffer[count] <= ps2_data;   // store ps2_data
                   count <= count + 3'b1;   // count ps2_data bits
                   // 在此处增加 WASD键检测
                   if (buffer[0:1] == 2'b10) begin
                       case (buffer[9:1])
                           8'h1D: wsad_keys_released[0] <= 1; // W键释放
                           8'h1C: wsad_keys_released[1] <= 1; // A键释放
                           8'h23: wsad_keys_released[2] <= 1; // S键释放
                           8'h1B: wsad_keys_released[3] <= 1; // D键释放
                           default:;
                       endcase
                   end
            end
        end
        if (!rdn && ready) begin
          r_ptr <= r_ptr + 3'b1;
          overflow <= 0;
        end
   end
assign ready = (w_ptr != r_ptr);
assign data = fifo[r_ptr];
assign wsad_down = ~wsad_keys_released; // 根据每个键是否释放，设置wsad_down信号
endmodule


module antiKeyboard(
    input data,
    input clk,
    output ready
);
reg [5:0]cnt;
always @(clk) begin
    if(data==8'h1c||data==8'h23||data==8'h1d||data==8'h1b)
        cnt<=cnt+1;
    else
        cnt<=0;
end

assign ready=cnt[4];
assign key_board=data;

endmodule

