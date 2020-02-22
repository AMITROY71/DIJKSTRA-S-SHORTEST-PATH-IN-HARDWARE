`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:53:26 01/29/2020 
// Design Name: 
// Module Name:    VGA_TOP 
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
module vga_shortest(
	input clk_in,
	input 	reset,
	
	output reg [6:0] seven_segment,
	output dp,
	output reg [3:0] an,
	
    //input  	ps2d,  
	//input	ps2c, 
	
	output [2:0] red,
	output [2:0] green,
	output [1:0] blue,
	output		 hsync,
	output		 vsync,
	//output	[7:0] Led,
	input	[7:0] sw
	
    );

//reg  [7:0] 	key_code;
//wire [7:0]  key_code_rcv;
//wire		interrupt;
//assign Led = key_code;

reg [3:0] clk_new_cnt;
reg		  clk;
always@(posedge clk_in)
	clk_new_cnt <= clk_new_cnt + 1;

always@* clk = clk_new_cnt[0];
	
/*ps2_rx ps2_rx_inst
(
   .clk			(clk		), 
   .reset		(reset		), 
   .ps2d		(ps2d		),  
   .ps2c		(ps2c		), 
   .interrupt	(interrupt	), 
   .key_code	(key_code_rcv) 
);*/

/*always@(posedge clk)
 if(reset)			key_code <= #1 8'h1c;
 else if(interrupt) key_code <= #1 key_code_rcv;*/

vga_initials_top vga_initials_top_inst(
	.clk		(clk		),
	.reset		(reset		),
	//.key_code	(key_code	),
	.hsync		(hsync		),
	.vsync		(vsync		),
	.red		(red		),
	.green		(green		),
	.blue		(blue		),
	.sw			(sw			)
);
	
parameter offset = 4;
reg [63:0] count;
wire [6:0] seven_segment0;
wire [6:0] seven_segment1;
wire [6:0] seven_segment2;
wire [6:0] seven_segment3;

always@(posedge clk)
	count <= #1 count+1;
	
assign dp = 1;

segments seg_inst0(count[19+offset:16+offset],seven_segment0);
segments seg_inst1(count[23+offset:20+offset],seven_segment1);
segments seg_inst2(count[27+offset:24+offset],seven_segment2);
segments seg_inst3(count[31+offset:28+offset],seven_segment3);

always@(posedge clk)
begin
	case(count[12:11])
	2'd0: begin seven_segment = ~seven_segment0; an = 4'b1110;end
	2'd1: begin seven_segment = ~seven_segment1; an = 4'b1101;end
	2'd2: begin seven_segment = ~seven_segment2; an = 4'b1011;end
	2'd3: begin seven_segment = ~seven_segment3; an = 4'b0111;end
	endcase
end
endmodule
