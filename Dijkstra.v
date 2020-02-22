`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:55:42 02/02/2020 
// Design Name: 
// Module Name:    Dijkstra 
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
module Dijkstra( clk, reset, start, state);// trans_count, neighbor_out, distance_out);

  input clk;
  //input clk_HPS;
  input reset;
  parameter wid=4;
  parameter wid1=9;
  parameter wid2=32;
   parameter wid3=14;
	parameter wid4=8;
	parameter wid5=10;
  
  input [wid1-1:0]start;    
  
  reg           w_en            [wid2-1:0];
  reg    [wid-1:0]  write_address   [wid2-1:0];
  reg    [wid-1:0]  read_address    [wid2-1:0];
  reg    [wid5-1:0] w_data          [wid2-1:0];
  wire   [wid5-1:0] r_data          [wid2-1:0];
  
  
  reg    [wid3-1:0] distance        [wid2-1:0];
  reg           shortest        [wid2-1:0];
  reg    [wid1-1:0]  neighbor   [wid2-1:0];
  
  //input  [8:0]  trans_count;
  //output [8:0]  neighbor_out;
  //reg    [8:0]  neighbor_out;
  //output [13:0] distance_out;
  //reg    [13:0] distance_out;
  
  
  wire   [wid3-1:0]  min_distance;
  wire   [wid1-1:0]  New;
  reg    [wid3-1:0]  min_distance_reg;
  reg    [wid1-1:0]  New_reg;
  
  output [wid-1:0]  state;
  reg    [wid-1:0]  state;
  reg    [wid-1:0]  state_reg;
  reg    [wid-1:0]  state_reg_reg;
  reg    [wid-1:0]  counter;
  reg    [wid-1:0]  sub_counter;
  reg    [wid-1:0]  sub_counter_reg;
  reg    [wid-1:0]  sub_counter_reg_reg;
  wire [wid4-1:0] map_init_value  [wid2-1:0];
  
  localparam   map_init  = 5'd0;
  localparam   dsn_init  = 5'd1;
  localparam   min_cost2 = 5'd2; 
  localparam   min_cost1 = 5'd3;  
  localparam   min_cost  = 5'd4;
  localparam   upd_minc  = 5'd5;
  localparam   upd_dist  = 5'd6;
  localparam   done      = 5'd7;
  
  always@(posedge clk) begin
    if(reset == 0) begin
	  state_reg       <= map_init;
	  state_reg_reg   <= map_init;
	end
	else begin
	  state_reg       <= state;
	  state_reg_reg   <= state_reg;
	end
  end
  
  always@(posedge clk) begin
    if(reset == 0) begin
	  sub_counter_reg      <= 5'd0;
	  sub_counter_reg_reg  <= 5'd0;
	end
	else begin
	  sub_counter_reg      <= sub_counter;
	  sub_counter_reg_reg  <= sub_counter_reg;
	end
  end
 
  always@(posedge clk) begin
	if(reset == 0) begin
	  state           <= map_init;
	  counter         <= 5'd0;
	  sub_counter     <= 5'd0;
	end
	else if(state == map_init && counter != 31) begin
	  state           <= map_init;
	  counter         <= counter + 5'd1;
    end
	else if(state == map_init && counter == 31) begin
	  state           <= dsn_init;
      counter         <= start;	                
	end	
	else if(state == dsn_init) begin
	  state           <= min_cost2;
	  counter         <= 5'd0;
	end
	else if(state == min_cost2 && counter != 31) begin
	  state           <= min_cost1;
	end
	else if(state == min_cost1) begin
      state           <= min_cost;	
	end
	else if(state == min_cost && sub_counter != 7 && counter != 31) begin
	  state           <= min_cost;
	  sub_counter     <= sub_counter + 5'd1;
	end
	else if(state == min_cost && sub_counter == 7 && counter != 31) begin
	  state           <= upd_minc;
	  sub_counter     <= 5'd0;
	end
	else if(state == upd_minc && counter != 31) begin
	  state           <= upd_dist;
	end
	else if(state == upd_dist && counter != 31) begin
	  state           <= min_cost2;
	  counter         <= counter + 5'd1;
	end
	else begin
	  state           <= done;
	  counter         <= counter;
	end

  end	 
  
 /* always@(posedge clk_HPS) begin
    neighbor_out      <= neighbor[trans_count];
	 distance_out      <= distance[trans_count];
  end*/
 
  always@(posedge clk) begin
    if( state == upd_minc) begin
	  min_distance_reg <= min_distance;
	  New_reg          <= New;
	end
	else begin
	  min_distance_reg <= min_distance_reg;
	  New_reg          <= New_reg;
	end	
  end
	  
  
genvar i;
  generate
	
    for (i=0; i<=31; i=i+1) begin : map
	  RAM uut_1(
     	.clk(clk),
		.w_en(w_en[i]),
		.write_address(write_address[i]), 
		.w_data(w_data[i]),
		.read_address(read_address[i]),
		.r_data(r_data[i])
	  );
	  
	  map_initialization uut_2 (
	    .row(counter),
		.column(i),
		.map_init_value(map_init_value[i])
	  );
		 
  // reg [7:0] map_init_value  [31:0];
	  always@(*) begin
	    if(state == map_init) begin
	      w_en[i]          = 1;
		  write_address[i] = counter;
		  w_data[i]        = map_init[i];
          read_address[i]  = 5'dx;
        end
		else if (state == dsn_init) begin
		  w_en[i]          = 0;
		  write_address[i] = 5'dx;
		  w_data[i]        = 10'dx;
		  read_address[i]  = counter;		  
		end
		else if (state == upd_dist) begin
		  w_en[i]          = 0;
		  write_address[i] = 5'dx;
		  w_data[i]        = 10'dx;
		  read_address[i]  = New_reg;
		end
		else begin
		  w_en[i]          = 0;
		  write_address[i] = 5'dx;
		  w_data[i]        = 10'dx;
		  read_address[i]  = 5'dx;
		end
      end	 


      always@(posedge clk) begin
		if( state_reg_reg == dsn_init ) begin
          distance[i]      <= r_data[i];
          neighbor[i]      <= start;
		end
		else if ( state_reg_reg == upd_dist ) begin
		  if( shortest[i] == 0 && (distance[New_reg] + r_data[i] < distance[i]) ) begin
		    distance[i]    <= distance[New_reg] + r_data[i];
			neighbor[i]    <= New_reg;
		  end
		  else begin
		    distance[i]    <= distance[i];
			neighbor[i]    <= neighbor[i];
		  end
		end
	    else begin
		  distance[i]      <= distance[i];
          neighbor[i]      <= neighbor[i];
	    end
	  end

	  always@(posedge clk) begin
		if( state_reg_reg == dsn_init && start != i) begin
          shortest[i]      <= 0;
		end
	    else if( state_reg_reg == dsn_init && start == i) begin
          shortest[i]      <= 1;
	    end
		else if( state == upd_minc && New == i) begin
		  shortest[i]      <= 1;
		end
		else begin
		  shortest[i]      <= shortest[i];
		end
	  end
	  
    end
endgenerate

wire [9:0] min_distance_1;
  wire [9:0] min_distance_2;
  wire [9:0] min_distance_3;
  wire [9:0] min_distance_4;
  wire [4:0]  new_1;
  wire [4:0]  new_2;
  wire [4:0]  new_3;
  wire [4:0]  new_4;
  wire [4:0]  new_a;
  wire [4:0]  new_b;
  wire [4:0]  new_c;
  wire [4:0]  new_d;
  
  
   comparator comp_dist_0_7 (
    .clk(clk),
	.reset(reset),
	.state(state),
	.distance(distance[5'd0+sub_counter]),
	.shortest(shortest[5'd0+sub_counter]),
	.counter(sub_counter),
	.min_distance(min_distance_1),
	.New(new_a)
  );
  assign new_1 = new_a + 5'd0;
  
  comparator comp_dist_8_15 (
    .clk(clk),
	.reset(reset),
	.state(state),
	.distance(distance[5'd8+sub_counter]),
	.shortest(shortest[5'd8+sub_counter]),
	.counter(sub_counter),
	.min_distance(min_distance_2),
	.New(new_b)
  );
  assign new_2 = new_b + 5'd8;
  
  comparator comp_dist_16_23 (
    .clk(clk),
	.reset(reset),
	.state(state),
	.distance(distance[5'd16+sub_counter]),
	.shortest(shortest[5'd16+sub_counter]),
	.counter(sub_counter),
	.min_distance(min_distance_3),
	.New(new_c)
  );
  assign new_3 = new_c + 5'd16;
  
  comparator comp_dist_24_31 (
    .clk(clk),
	.reset(reset),
	.state(state),
	.distance(distance[5'd24+sub_counter]),
	.shortest(shortest[5'd24+sub_counter]),
	.counter(sub_counter),
	.min_distance(min_distance_4),
	.New(new_d)
  );
  assign new_4 = new_d + 5'd24;
	
  comparator_4_to_1 comp_4_to_1 (
	.min_distance_1(min_distance_1),
	.min_distance_2(min_distance_2),
	.min_distance_3(min_distance_3),
	.min_distance_4(min_distance_4),
	.new_1(new_1),
	.new_2(new_2),
	.new_3(new_3),
	.new_4(new_4),
	.min_distance(min_distance),
	.New(New)
  );
  
endmodule

