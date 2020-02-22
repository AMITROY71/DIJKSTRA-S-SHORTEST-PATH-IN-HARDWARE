`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:03:53 02/02/2020 
// Design Name: 
// Module Name:    comp 
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
module comparator (clk, reset, state, distance, shortest, counter, min_distance, New);

  input clk;
  input reset;
  
  input  [4:0]  state;
  input  [13:0] distance;
  input         shortest;
  input  [8:0]  counter;
  
  output [13:0] min_distance;
  reg    [13:0] min_distance;
  output [8:0]  New;
  reg    [8:0]  New;
  
  always@(posedge clk) begin
    if(reset == 0 || state != 5'd4) begin
      min_distance <= 14'd10000;
	  New          <= 9'd0;
    end
    else if(shortest == 0 && min_distance > distance) begin
      min_distance <= distance; 
      New          <= counter;	  
	end
	else begin
	  min_distance <= min_distance;
	  New          <= New;
	end
  end
  
endmodule
