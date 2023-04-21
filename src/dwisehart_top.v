`default_nettype none
`timescale 1ns/1ps

module dwisehart_ring_top
(
 input [7:0]  io_in,
 output [7:0] io_out
);

   ring m_ring
   (
    .io_in  ( io_in ),
    .io_out ( io_out )
   );

endmodule
