`default_nettype none
`timescale 1ns/1ps

  module tb
  (
   input        CLK,
   input        RST,
   input [5:0]  SEL,

   output       O_CLK_005,
   output       O_CLK_011,
   output       O_CLK_023,
   output       O_CLK_047,
   output       O_CLK_097,
   output       O_CLK_197
  );

   initial begin
      $dumpfile ("tb.vcd");
      $dumpvars (0, tb);
      #1;
   end

   ringd #( .pSTAGES(   5 ) ) m_ring005d( .o_clk( O_CLK_005 ) );
   ringd #( .pSTAGES(  11 ) ) m_ring011d( .o_clk( O_CLK_011 ) );
   ringd #( .pSTAGES(  23 ) ) m_ring023d( .o_clk( O_CLK_023 ) );
   ringd #( .pSTAGES(  47 ) ) m_ring047d( .o_clk( O_CLK_047 ) );
   ringd #( .pSTAGES(  97 ) ) m_ring097d( .o_clk( O_CLK_097 ) );
   ringd #( .pSTAGES( 197 ) ) m_ring197d( .o_clk( O_CLK_197 ) );

endmodule
