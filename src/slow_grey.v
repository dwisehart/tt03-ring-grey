`default_nettype none
`timescale 1ns/1ps

  module slow_grey #( parameter pCOUNT = 1000 )
  (
   input        i_clk, i_rst,
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
   reg          r_clk;

   always @( posedge i_clk )
     if( w_rst ) begin
        r_cnt         <= 'd0;
        r_clk         <= 'b0;
     end
     else
       casex({ r_cnt == pCOUNT / 2, r_cnt == pCOUNT })
         2'b1x: r_clk        <= 'b1;
         2'b01: begin
            r_cnt            <= 'd0;
            r_clk            <= 'b0;
         end
         default: r_cnt      <= r_cnt + 1;
       endcase

////////////////////////////////////////
   wire         w_clk_001;
   grey_10 m_001
   (
    .i_clk     ( r_clk ),
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
