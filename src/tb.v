`default_nettype none
`timescale 1ns/1ps

`ifdef GL_TEST

////////////////////////////////////////
  module tb
  (
   input        CLK,
   input        RST,
   input [5:0]  SEL,

   output [7:0] io_out
  );

   dwisehart_ring_top m_top
   (
    .vccd1  ( 1'b1 ),
    .vssd1  ( 1'b0 ),
    .io_in  ({ SEL, RST, CLK }),
    .io_out ( io_out )
   );

`else

////////////////////////////////////////
  module tb
  (
   input        CLK,
   input        RST,
   input [5:0]  SEL,

   output [7:0] io_out
  );

   initial begin
      $dumpfile ("tb.vcd");
      $dumpvars (0, tb);
      #1;
   end

   dwisehart_ring_top m_top
   (
    .io_in  ({ SEL, RST, CLK }),
    .io_out ( io_out )
   );

`endif

endmodule
