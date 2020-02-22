`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:55:59 01/29/2020 
// Design Name: 
// Module Name:    seg 
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
module segments(
	input [3:0] number,
	output reg [6:0] leds
    );

always@*
begin
	case(number)
	4'h0: leds = 7'b1111110;
	4'h1: leds = 7'b0110000;
	4'h2: leds = 7'b1101101;
	4'h3: leds = 7'b1111001;
	4'h4: leds = 7'b0110011;
	4'h5: leds = 7'b1011011;
	4'h6: leds = 7'b1011111;
	4'h7: leds = 7'b1110000;
	4'h8: leds = 7'b1111111;
	4'h9: leds = 7'b1111011;
	4'ha: leds = 7'b1110111;
	4'hb: leds = 7'b0011111;
	4'hc: leds = 7'b0001101;
	4'hd: leds = 7'b0111101;
	4'he: leds = 7'b1001111;
	4'hf: leds = 7'b1000111;
	endcase
end

endmodule
