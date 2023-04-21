`default_nettype none
`timescale 1ns/1ps

module dwisehart_ring_top
(
 input [7:0]  io_in,
 output [7:0] io_out
);

   ringd #( .pSTAGES(   5 ) ) m_ring005d( .o_clk( io_out[0] ) );
   ringd #( .pSTAGES(  11 ) ) m_ring011d( .o_clk( io_out[1] ) );
   ringd #( .pSTAGES(  23 ) ) m_ring023d( .o_clk( io_out[2] ) );
   ringd #( .pSTAGES(  47 ) ) m_ring047d( .o_clk( io_out[3] ) );
   ringd #( .pSTAGES(  97 ) ) m_ring097d( .o_clk( io_out[4] ) );
#   ringd #( .pSTAGES( 197 ) ) m_ring197d( .o_clk( io_out[5] ) );

endmodule
