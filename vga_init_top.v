`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:35:22 01/29/2020 
// Design Name: 
// Module Name:    vga_init_top 
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
module vga_initials_top(
input wire clk,
input wire  reset,
//input wire [7:0] key_code,
output wire hsync,
output wire vsync,
output wire [2:0] red,
output wire [2:0] green,
output wire [1:0] blue,

input [7:0] sw
);


wire clr, clk25,vidon;
wire [9:0] hc,vc;
//wire [0:31] M;
//wire [3:0] rom_addr4;
wire [8:0]start;
wire [4:0]state;
assign clr = reset;

clkdiv U1 	(
		.mclk(clk),
		.clr(clr),
		.clk25(clk25)
				);
				
vga_640x480 U2	(
		.clk(clk25),
		.clr(clr),
		.hsync(hsync),
		.vsync(vsync),
		.hc(hc),
		.vc(vc),
		.vidon(vidon)
					);
					
vga_initials U3	(
		.clk(clk25),
		.reset(reset),
		.vidon(vidon),
		.hc(hc),
		.vc(vc),
		//.M(M),
		.sw(sw),
		//.rom_addr4(rom_addr4),
		.red(red),
		.green(green),
		.blue(blue),
		.start(start),
		.state(state)
						);
						
						
/*prom_DMH U4	(
		.addr(rom_addr4),
		.M(M),
		.key_code(key_code)
				);*/


endmodule
