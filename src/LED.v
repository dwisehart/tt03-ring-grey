`default_nettype none
`timescale 1ns/1ps

  module LED
  (
   input        i_clk, i_rst,
   input [4:0]  i_grey,

   output [7:0] o_led
  );

////////////////////////////////////////
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

   localparam pDP          = 'b10101;  // Decimal point.

////////////////////////////////////////
   reg [4:0]    r_led;
   assign       o_led  = r_led;

   always @( posedge i_clk )
     if( i_rst )
       r_led           <= 'd0;
     else
       case( i_grey )
         pZERO:   r_led  <= 'b00111111;
         pONE:    r_led  <= 'b00000110;
         pTWO:    r_led  <= 'b01011011;
         pTHREE:  r_led  <= 'b01001111;
         pFOUR:   r_led  <= 'b01100110;
         pFIVE:   r_led  <= 'b01101101;
         pSIX:    r_led  <= 'b01111101;
         pSEVEN:  r_led  <= 'b00000111;
         pEIGHT:  r_led  <= 'b01111111;
         pNINE:   r_led  <= 'b01101111;
         pDP:     r_led  <= 'b10000000;
         default: r_led  <= 'b01000000;
       endcase

endmodule
