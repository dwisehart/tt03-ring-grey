`default_nettype none
`timescale 1ns/1ps

  module ringd #( parameter pSTAGES = 5 )
  (
   output     o_clk
  );

////////////////////////////////////////
   wire [7:0] w_rst;
   reg        r_rst       = 'b1;
   always @( w_rst[7] )
     r_rst               <= 'b0;

   localparam pDEL        = 0.020;
   assign #pDEL w_rst[0]  = r_rst;
   assign #pDEL w_rst[1]  = w_rst[0];
   assign #pDEL w_rst[2]  = w_rst[1];
   assign #pDEL w_rst[3]  = w_rst[2];
   assign #pDEL w_rst[4]  = w_rst[3];
   assign #pDEL w_rst[5]  = w_rst[4];
   assign #pDEL w_rst[6]  = w_rst[5];
   assign #pDEL w_rst[7]  = w_rst[6];

////////////////////////////////////////
   localparam pNUM        = ( pSTAGES * 2 ) - 1;
   wire [pNUM:0] w_clk;
   assign        o_clk    = w_clk[1];

   genvar ii;
   for( ii=0; ii<pNUM; ii=ii+2 ) begin
      wire w_init    = ( ii % 4 ) >> 1;
      localparam xx  = ii+3 > pNUM ? 1 : ii+3;
      localparam yy  = ii+2 > pNUM ? 0 : ii+2;
      assign #pDEL w_clk[ ii+1 :ii]  = f_inv( r_rst, w_init, w_clk[ xx :yy], w_clk[ ii+1 :ii] );
   end

////////////////////////////////////////
   function [1:0] f_inv( input i_rst, i_init,
                         input [1:0] i_pn, i_ppn );
      if( i_rst )
        if( i_init )
          f_inv           = 'b10;
        else
          f_inv           = 'b01;
      else
        case( i_pn )
          'b01:    f_inv  = 'b10;
          'b10:    f_inv  = 'b01;
          default: f_inv  = i_ppn;
        endcase
   endfunction

endmodule
