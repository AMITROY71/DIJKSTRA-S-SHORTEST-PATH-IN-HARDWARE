`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:49:10 01/29/2020 
// Design Name: 
// Module Name:    clk 
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
module clkdiv(

input wire mclk,
input wire clr,
output wire clk25
    );

reg [24:0] q;

always @ (posedge mclk or posedge clr)
	begin
		if (clr == 1)
			q <= 0;
		else
			q <= q + 1;
	end

assign clk25 = q[0];

endmodule
