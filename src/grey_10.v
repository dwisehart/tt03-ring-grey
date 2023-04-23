`default_nettype none
`timescale 1ns/1ps

  module grey_10
  (
   input        i_clk, i_rst,
   output [4:0] o_cnt,
   output       o_clk_div
  );

   localparam pZERO        = 'b10001;
   localparam pONE         = 'b00001;
   localparam pTWO         = 'b00011;
   localparam pTHREE       = 'b00010;
   localparam pFOUR        = 'b00110;
   localparam pFIVE        = 'b00100;
   localparam pSIX         = 'b01100;
   localparam pSEVEN       = 'b01000;
   localparam pEIGHT       = 'b11000;
   localparam pNINE        = 'b10000;

////////////////////////////////////////
   reg [7:0]    r_rst  = 'hFF;
   wire         w_rst  = r_rst[7];

   always @( posedge i_clk )
     if( i_rst )
       r_rst          <= 'hFF;
     else
       r_rst          <= { r_rst, 1'b0 };

////////////////////////////////////////
   reg [4:0]    r_cnt;
   assign       o_cnt      = r_cnt;

   always @( posedge i_clk )
     if( w_rst )
        r_cnt             <= pZERO;
     else
       r_cnt              <= f_next( r_cnt );

////////////////////////////////////////
   reg          r_clk_div, r_start;
   assign       o_clk_div  = r_clk_div;

   always @( posedge i_clk )
     if( w_rst ) begin
        r_clk_div            <= 'b1;
        r_start              <= 'b1;
     end
     else
       casex({ r_cnt == pFOUR, r_cnt == pNINE, r_start })
         'b1xx:   r_clk_div  <= 'b1;
         'b01x:   r_clk_div  <= 'b0;
         'b001: begin
            r_clk_div        <= 'b0;
            r_start          <= 'b0;
         end
         default: r_clk_div  <= r_clk_div;
       endcase

////////////////////////////////////////
   function [4:0] f_next( input [4:0] f_in );
      case( f_in )
        pZERO:   f_next    = pONE;
        pONE:    f_next    = pTWO;
        pTWO:    f_next    = pTHREE;
        pTHREE:  f_next    = pFOUR;
        pFOUR:   f_next    = pFIVE;
        pFIVE:   f_next    = pSIX;
        pSIX:    f_next    = pSEVEN;
        pSEVEN:  f_next    = pEIGHT;
        pEIGHT:  f_next    = pNINE;
        default: f_next    = pZERO;
      endcase
   endfunction

endmodule
