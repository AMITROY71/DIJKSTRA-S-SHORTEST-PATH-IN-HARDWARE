`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:31:54 01/29/2020 
// Design Name: 
// Module Name:    VGA_img_mod 
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
module vga_640x480(

input wire clk,
input wire clr,
output reg hsync,
output reg vsync,
output reg [9:0] hc,
output reg [9:0] vc,
output reg vidon
    );


parameter hpixels = 10'd800;
parameter vlines = 10'd521;
parameter hbp = 10'd144;
parameter hfp = 10'd784;
parameter vbp = 10'd31;
parameter vfp = 10'd511;

reg vsenable;


always @ (posedge clk or posedge clr)
	begin
		if (clr == 1)
			hc <= 0;
		else
			begin
				if (hc == hpixels - 1)
					begin
						hc <= 0;
						vsenable <= 1;
					end
				else
					begin
						hc <= hc + 1;
						vsenable <= 0;
					end
			end
	end
	
	
always @(*)
	begin
		if (hc < 128)
			hsync = 0;
		else
			hsync = 1;
	end

always @ (posedge clk or posedge clr)
	begin
		if (clr == 1)
			vc <= 0;
		else
			if (vsenable == 1)
				begin
					if (vc == vlines - 1)
						vc <= 0;
					else
						vc <= vc + 1;
				end
	end
	
always @(*)
	begin
		if (vc <= 2)
			vsync = 0;
		else
			vsync = 1;
	end

always @(*)
	begin
	if ((hc < hfp) && (hc > hbp) && (vc < vfp) && (vc > vbp))
		vidon = 1;
	else
		vidon = 0;
	end



endmodule
