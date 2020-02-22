`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:00:45 02/02/2020 
// Design Name: 
// Module Name:    map_init 
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
module map_initialization ( row, column, map_init_value );

  input  [8:0]  row;
  input  [31:0] column;
  
  output [13:0]  map_init_value;
  reg    [13:0]  map_init_value;
  
always@(*) begin
if(row == column) map_init_value = 0;    
else if ( (row == 0   && column == 1  ) || (row == 1   && column == 0  ) ) map_init_value = 247 ;
else if ( (row == 1   && column == 2  ) || (row == 2   && column == 1  ) ) map_init_value = 258 ;
else if ( (row == 2   && column == 3  ) || (row == 3   && column == 2  ) ) map_init_value = 208 ;
else if ( (row == 2   && column == 4  ) || (row == 4   && column == 2  ) ) map_init_value = 184 ;
else if ( (row == 3   && column == 6  ) || (row == 6   && column == 3  ) ) map_init_value = 232 ;
else if ( (row == 3   && column == 7  ) || (row == 7   && column == 3  ) ) map_init_value = 241 ;
else if ( (row == 7   && column == 8  ) || (row == 8   && column == 7  ) ) map_init_value = 78  ;
else if ( (row == 8   && column == 9  ) || (row == 9   && column == 8  ) ) map_init_value = 76  ;
else if ( (row == 8   && column == 10 ) || (row == 10  && column == 8  ) ) map_init_value = 202 ;
else if ( (row == 7   && column == 11 ) || (row == 11  && column == 7  ) ) map_init_value = 161 ;
else if ( (row == 11  && column == 12 ) || (row == 12  && column == 11 ) ) map_init_value = 132 ;
else if ( (row == 11  && column == 13 ) || (row == 13  && column == 11 ) ) map_init_value = 281 ;
else if ( (row == 4   && column == 5  ) || (row == 5   && column == 4  ) ) map_init_value = 33  ;
else if ( (row == 5   && column == 14 ) || (row == 14  && column == 5  ) ) map_init_value = 93  ;
else if ( (row == 14  && column == 13 ) || (row == 13  && column == 14 ) ) map_init_value = 71  ;
else if ( (row == 14  && column == 15 ) || (row == 15  && column == 14 ) ) map_init_value = 185 ;
else if ( (row == 15  && column == 16 ) || (row == 16  && column == 15 ) ) map_init_value = 264 ;
else if ( (row == 16  && column == 17 ) || (row == 17  && column == 16 ) ) map_init_value = 224 ;
else if ( (row == 17  && column == 18 ) || (row == 18  && column == 17 ) ) map_init_value = 239 ;
else if ( (row == 18  && column == 19 ) || (row == 19  && column == 18 ) ) map_init_value = 240 ;
else if ( (row == 18  && column == 20 ) || (row == 20  && column == 18 ) ) map_init_value = 174 ;
else if ( (row == 20  && column == 21 ) || (row == 21  && column == 20 ) ) map_init_value = 102 ;
else if ( (row == 20  && column == 22 ) || (row == 22  && column == 20 ) ) map_init_value = 290 ;
else if ( (row == 20  && column == 25 ) || (row == 25  && column == 20 ) ) map_init_value = 251 ;
else if ( (row == 25  && column == 24 ) || (row == 24  && column == 25 ) ) map_init_value = 79  ;
else if ( (row == 24  && column == 23 ) || (row == 23  && column == 24 ) ) map_init_value = 283 ;
else if ( (row == 24  && column == 27 ) || (row == 27  && column == 24 ) ) map_init_value = 167 ;
else if ( (row == 24  && column == 26 ) || (row == 26  && column == 24 ) ) map_init_value = 167 ;
else if ( (row == 27  && column == 26 ) || (row == 26  && column == 27 ) ) map_init_value = 165 ;
else if ( (row == 25  && column == 26 ) || (row == 26  && column == 25 ) ) map_init_value = 114 ;
else if ( (row == 13  && column == 30 ) || (row == 30  && column == 13 ) ) map_init_value = 149 ;
else if ( (row == 30  && column == 29 ) || (row == 29  && column == 30 ) ) map_init_value = 23  ;
else if ( (row == 29  && column == 28 ) || (row == 28  && column == 29 ) ) map_init_value = 154 ;
else if ( (row == 28  && column == 17 ) || (row == 17  && column == 28 ) ) map_init_value = 112 ;
else if ( (row == 28  && column == 26 ) || (row == 26  && column == 28 ) ) map_init_value = 336 ;
else if ( (row == 13  && column == 33 ) || (row == 33  && column == 13 ) ) map_init_value = 248 ;
else if ( (row == 33  && column == 32 ) || (row == 32  && column == 33 ) ) map_init_value = 85  ;
else if ( (row == 32  && column == 31 ) || (row == 31  && column == 32 ) ) map_init_value = 296 ;
else map_init_value = 10000;

end

endmodule
