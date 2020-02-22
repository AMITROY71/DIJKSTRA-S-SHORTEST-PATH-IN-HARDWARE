`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:56:56 01/29/2020 
// Design Name: 
// Module Name:    ps2_rx 
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

module ps2_rx 
(
   input  wire  clk, reset, 
   input  wire  ps2d,  ps2c, 
   output  wire  interrupt, 
   output wire  [7:0]  key_code 
);


wire [7:0] dout1;
wire rx_done_tick;
reg [7:0] dout;
reg inter;

wire [7:0] dout_nxt;
wire inter_nxt; 





   ps2 ps2_inst1 
								( 
			.clk(clk), 
			.reset(reset), 
			.ps2d(ps2d),
			.ps2c(ps2c),
			.rx_en(1'b1), 
			.rx_done_tick(rx_done_tick), 
			.dout(dout1) 
								);
								
								
								
always @ (posedge clk or posedge reset)
   begin
       if (reset)
       begin
           inter <= 1'b0;
           dout <= 8'b0;
       end
       
       else
       
       begin
           inter <= inter_nxt;
           dout <= dout_nxt;
       end
          
   end   

   
   
   assign dout_nxt = (rx_done_tick==1'b1) ? dout1 : dout;
   assign inter_nxt = rx_done_tick;
   
   
   assign key_code = dout;
   assign interrupt = inter;  

endmodule
