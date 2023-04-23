`default_nettype none
`timescale 1ns/1ps

  module capture #( parameter pCOUNT = 1000 )
  (
   input        i_clk, i_rst,
   input [4:0]  i_100,
   input [4:0]  i_010,
   input [4:0]  i_001,
   output [4:0] o_100,
   output [4:0] o_010,
   output [4:0] o_001
  );

////////////////////////////////////////
   reg [7:0]    r_rst  = 'hFF;
   wire         w_rst  = r_rst[7];

   always @( posedge i_clk )
     if( i_rst )
       r_rst          <= 'hFF;
     else
       r_rst          <= { r_rst, 1'b0 };

////////////////////////////////////////
   reg [15:0]   r_cnt;

   always @( posedge i_clk )
     if( w_rst )
       r_cnt          <= 'd0;
     else
       if( r_cnt == pCOUNT )
         r_cnt        <= 'd0;
       else
         r_cnt        <= r_cnt + 1;

////////////////////////////////////////
   reg [4:0]    r_100, r_010, r_001;
   assign       o_100  = r_100;
   assign       o_010  = r_010;
   assign       o_001  = r_001;

   always @( posedge i_clk )
     if( w_rst ) begin
        r_100         <= 'd0;
        r_010         <= 'd0;
        r_001         <= 'd0;
     end
     else if( r_cnt == pCOUNT ) begin
        r_100         <= i_100;
        r_010         <= i_010;
        r_001         <= i_001;
     end

endmodule
