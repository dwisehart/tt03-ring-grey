`default_nettype none
`timescale 1ns/1ps

  module scan
  (
   input        i_clk, i_rst,
   input [5:0]  i_sel,

   input [4:0]  i_005_100,
   input [4:0]  i_005_010,
   input [4:0]  i_005_001,

   input [4:0]  i_011_100,
   input [4:0]  i_011_010,
   input [4:0]  i_011_001,

   input [4:0]  i_023_100,
   input [4:0]  i_023_010,
   input [4:0]  i_023_001,

   input [4:0]  i_047_100,
   input [4:0]  i_047_010,
   input [4:0]  i_047_001,

   input [4:0]  i_005_011_100,
   input [4:0]  i_005_011_010,
   input [4:0]  i_005_011_001,

   input [4:0]  i_005_023_100,
   input [4:0]  i_005_023_010,
   input [4:0]  i_005_023_001,

   input [4:0]  i_005_047_100,
   input [4:0]  i_005_047_010,
   input [4:0]  i_005_047_001,

   input [4:0]  i_011_023_100,
   input [4:0]  i_011_023_010,
   input [4:0]  i_011_023_001,

   input [4:0]  i_011_047_100,
   input [4:0]  i_011_047_010,
   input [4:0]  i_011_047_001,

   input [4:0]  i_023_047_100,
   input [4:0]  i_023_047_010,
   input [4:0]  i_023_047_001,

   output [7:0] o_LED
  );

////////////////////////////////////////
   reg [7:0]    r_rst  = 'hFF;
   wire         w_rst  = r_rst[7];

   always @( posedge i_clk )
     if( i_rst )
       r_rst              <= 'hFF;
     else
       r_rst              <= { r_rst, 1'b0 };

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
   reg [4:0]    r_100, r_010, r_001;

   always @( posedge i_clk )
     if( w_rst ) begin
        r_100             <= 'd0;
        r_010             <= 'd0;
        r_001             <= 'd0;
     end
     else
       case( i_sel )
         'b00_0001: begin
            r_100         <= i_005_100;
            r_010         <= i_005_010;
            r_001         <= i_005_001;
         end
         'b00_0011: begin
            r_100         <= i_011_100;
            r_010         <= i_011_010;
            r_001         <= i_011_001;
         end
         'b00_0010: begin
            r_100         <= i_023_100;
            r_010         <= i_023_010;
            r_001         <= i_023_001;
         end
         'b00_0110: begin
            r_100         <= i_047_100;
            r_010         <= i_047_010;
            r_001         <= i_047_001;
         end
         'b00_0100: begin
            r_100         <= i_005_011_100;
            r_010         <= i_005_011_010;
            r_001         <= i_005_011_001;
         end
         'b00_1100: begin
            r_100         <= i_005_023_100;
            r_010         <= i_005_023_010;
            r_001         <= i_005_023_001;
         end
         'b00_1000: begin
            r_100         <= i_005_047_100;
            r_010         <= i_005_047_010;
            r_001         <= i_005_047_001;
         end
         'b01_1000: begin
            r_100         <= i_011_023_100;
            r_010         <= i_011_023_010;
            r_001         <= i_011_023_001;
         end
         'b01_0000: begin
            r_100         <= i_011_047_100;
            r_010         <= i_011_047_010;
            r_001         <= i_011_047_001;
         end
         'b11_0000: begin
            r_100         <= i_023_047_100;
            r_010         <= i_023_047_010;
            r_001         <= i_023_047_001;
         end
         default: begin
            r_100         <= pFOUR;
            r_010         <= pFIVE;
            r_001         <= pSIX;
         end
       endcase

////////////////////////////////////////
   reg [15:0]   r_cnt;
   localparam   pCOUNT  = 'd20_000;

   always @( posedge i_clk )
     if( w_rst )
       r_cnt              <= 'd0;
     else if( r_cnt == pCOUNT )
       r_cnt              <= 'd0;
     else
       r_cnt              <= r_cnt + 'd1;

////////////////////////////////////////
   reg [3:0]    r_state;
   reg [4:0]    r_LED;

   always @( posedge i_clk )
     if( w_rst ) begin
        r_state           <= 'd0;
        r_LED             <= 'd0;
     end
     else
       case( r_state )
         'd0: if( r_cnt == pCOUNT ) begin
            r_LED         <= r_100;
            r_state       <= 'd1;
         end
         'd1: if( r_cnt == pCOUNT ) begin
            r_LED         <= r_010;
            r_state       <= 'd2;
         end
         'd2: if( r_cnt == pCOUNT ) begin
            r_LED         <= r_001;
            r_state       <= 'd3;
         end
         default: if( r_cnt == pCOUNT ) begin
            r_LED         <= pDP;
            r_state       <= 'd1;
         end
       endcase

////////////////////////////////////////
   LED m_LED
   (
    .i_clk  ( i_clk ),
    .i_rst  ( w_rst ),
    .i_grey ( r_LED ),
    .o_led  ( o_LED )
   );

endmodule
