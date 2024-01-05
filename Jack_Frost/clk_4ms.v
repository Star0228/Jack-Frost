`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:34:46 11/22/2023 
// Design Name: 
// Module Name:    clk_4ms 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clk_4ms(
	input wire clk,
	output reg clk_4ms
    );
	reg [31:0]cnt;
	always @(posedge clk)begin
		if(cnt < 200_000)begin
		cnt<=cnt +1;
		end else begin
		cnt <=0;
		clk_4ms <= ~clk_4ms;  
		end
	end
endmodule
