`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:34:37 01/29/2020 
// Design Name: 
// Module Name:    vga_intials 
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
module vga_initials(
input		clk,
input reset,
input wire vidon,
input wire [9:0] hc,
input wire [9:0] vc,
//input wire [0:31] M,
input wire [7:0] sw,
//output wire [3:0] rom_addr4,
output reg [2:0] red,
output reg [2:0] green,
output reg [1:0] blue,
input[8:0]start,
output  [4:0]state
    );
	 
parameter hbp = 10'd144;
parameter vbp = 10'd31;
parameter W = 256;
parameter H = 256;
wire [10:0] C1, R1, rom_addr, rom_pix;
reg spriteon, R, G, B;

assign C1 = {2'b00, sw[3:0], 5'b00001};
assign R1 = {2'b00, sw[7:4], 5'b00001};
assign rom_addr = vc - vbp - R1;
assign rom_pix = hc - hbp - C1;
//assign rom_addr4 = rom_addr[3:0];

/*always @(*)
	begin
		if ((hc >= C1 + hbp) && (hc < C1 + hbp + W) && (vc >= R1 + vbp) && (vc < R1 + vbp + H))
			spriteon = 1;
		else
			spriteon = 0;
	end*/

///-------------------------------------
//wire [31:0] clk_HPS_32; 
//reg clk_HPS;
//assign clk_HPS = clk_HPS_32[0];

//wire [31:0] reset_32;
//reg reset;
//assign reset = reset_32[0];

//wire [31:0] start_32;
//reg [8:0] start;
//assign start = start_32[8:0];

//wire [31:0] state_32;
//wire [4:0] state;
//assign state_32 = { 27'd0, state};

//wire [31:0] trans_count_32;
//reg [8:0] trans_count;
//assign trans_count = trans_count_32[8:0];

//wire [31:0] neighbor_out_32;
//wire [8:0] neighbor_out;
//assign neighbor_out_32 = { 23'd0, neighbor_out};

//wire [31:0] distance_out_32;
//wire [13:0]  distance_out;
//assign distance_out_32 = { 18'd0, distance_out};

Dijkstra dij1( 
  .clk(clk), 
  //.clk_HPS(clk_HPS), 
  .reset(reset), 
  .start(start), 
  .state(state) 
  //.trans_count(trans_count), 
  //.neighbor_out(neighbor_out),
  //.distance_out(distance_out)
);
//Dijkstra dij1( clk, reset, start, state);// trans_count, neighbor_out, distance_out);

//-----------------------------------------
  reg write_enable = 0;
   parameter RAM_WIDTH = 8;
   parameter RAM_ADDR_BITS = 13;

   //(* RAM_STYLE="{AUTO | BLOCK |  BLOCK_POWER1 | BLOCK_POWER2}" *)
   reg [RAM_WIDTH-1:0] ram_name [(2**RAM_ADDR_BITS)-1:0];
   reg [RAM_WIDTH-1:0] output_data;   

   reg [RAM_ADDR_BITS-1:0] read_address, write_address=0;
   reg [RAM_WIDTH-1:0] input_data=0;

   //  The forllowing code is only necessary if you wish to initialize the RAM 
   //  contents via an external file (use $readmemb for binary data)
   initial
      $readmemh("temph.txt", ram_name, 0, 75*75-1);

   always @(posedge clk) begin
      if (write_enable)
         ram_name[write_address] <= input_data;
      output_data <= ram_name[read_address];
   end
	 //reg [4:0] read_address_reg;
	// reg [7:0] output_data;   
always@* read_address = {rom_pix[7:0],rom_addr[7:0]};
//-----------------------------------------
	
	
always @(*)
	begin
		red = 0;
		green = 0;
		blue = 0;
		if ((spriteon == 1) && (vidon == 1))
			begin
				//R = M[rom_pix];
				//G = M[rom_pix];
				//B = M[rom_pix];
				//red = {R,R,R};
				//green = {G,G,G};
				//blue = {B,B};
				red 	= output_data[2:0];
				green 	= output_data[5:3];
				blue	= output_data[7:6];
			end
	end


endmodule
