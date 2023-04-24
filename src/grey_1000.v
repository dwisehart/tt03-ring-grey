`default_nettype none
`timescale 1ns/1ps

  module grey_1000
  (
   input        i_clk, i_rst,
   output [4:0] o_100,
   output [4:0] o_010,
   output [4:0] o_001
  );

   wire         w_clk_001;
   grey_10 m_001
   (
    .i_clk     ( i_clk ),
    .i_rst     ( i_rst ),
    .o_cnt     ( o_001 ),
    .o_clk_div ( w_clk_001 )
   );

   wire         w_clk_010;
   grey_10 m_010
   (
    .i_clk     ( w_clk_001 ),
    .i_rst     ( i_rst ),
    .o_cnt     ( o_010 ),
    .o_clk_div ( w_clk_010 )
   );

   grey_10 m_100
   (
    .i_clk     ( w_clk_010 ),
    .i_rst     ( i_rst ),
    .o_cnt     ( o_100 ),
    .o_clk_div ()
   );

endmodule
