`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:04:36 02/02/2020 
// Design Name: 
// Module Name:    comp4_1 
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
module comparator_4_to_1 
(
  input  [13:0] min_distance_1, 
  input  [13:0] min_distance_2, 
  input  [13:0] min_distance_3, 
  input  [13:0] min_distance_4,  
  input  [8:0]  new_1,
  input  [8:0]  new_2,
  input  [8:0]  new_3,
  input  [8:0]  new_4,
  
  output reg [13:0] min_distance,
  output reg [8:0]  New
);

always@(*) begin
  if(min_distance_1 <= min_distance_2 && min_distance_1 <= min_distance_3 && min_distance_1 <= min_distance_4) begin
     min_distance = min_distance_1;
	 New          = new_1;
  end
  else if(min_distance_2 <= min_distance_1 && min_distance_2 <= min_distance_3 && min_distance_2 <= min_distance_4) begin
     min_distance = min_distance_2;
	 New          = new_2;
  end
  else if(min_distance_3 <= min_distance_1 && min_distance_3 <= min_distance_2 && min_distance_3 <= min_distance_4) begin
     min_distance = min_distance_3;
	 New          = new_3;
  end 
  else begin
     min_distance = min_distance_4;
     New          = new_4;
  end
end  

endmodule
