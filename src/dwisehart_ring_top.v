`default_nettype none
`timescale 1ns/1ps

module dwisehart_ring_top
(
 input [7:0]  io_in,
 output [7:0] io_out
);

   wire       w_clk_005, w_clk_011, w_clk_023, w_clk_047;
   ringd #( .pSTAGES(   5 ) ) m_ring005d( .o_clk( w_clk_005 ) );
   ringd #( .pSTAGES(  11 ) ) m_ring011d( .o_clk( w_clk_011 ) );
   ringd #( .pSTAGES(  23 ) ) m_ring023d( .o_clk( w_clk_023 ) );
   ringd #( .pSTAGES(  47 ) ) m_ring047d( .o_clk( w_clk_047 ) );
//   ringd #( .pSTAGES(  97 ) ) m_ring097d( .o_clk( w_clk_097 ) );
//   ringd #( .pSTAGES( 197 ) ) m_ring197d( .o_clk( w_clk_197 ) );
   assign io_out [7:4]  = 'd0;

   wire       i_clk  = io_in[0];
   wire       i_rst  = io_in[1];
   wire [5:0] i_sel  = io_in[7:2];

////////////////////////////////////////
   reg [7:0]    r_rst  = 'hFF;
   wire         w_rst  = r_rst[7];

   always @( posedge i_clk )
     if( i_rst )
       r_rst          <= 'hFF;
     else
       r_rst          <= { r_rst, 1'b0 };

////////////////////////////////////////
   wire [4:0]   w_100_005, w_010_005, w_001_005;

   grey_1000 m_grey_005
   ( .i_clk     ( w_clk_005 ),
     .i_rst     ( w_rst ),
     .o_100     ( w_100_005 ),
     .o_010     ( w_010_005 ),
     .o_001     ( w_001_005 ),
     .o_clk_div ()
   );

   wire [4:0]   w_100_011, w_010_011, w_001_011;

   grey_1000 m_grey_011
   ( .i_clk     ( w_clk_011 ),
     .i_rst     ( w_rst ),
     .o_100     ( w_100_011 ),
     .o_010     ( w_010_011 ),
     .o_001     ( w_001_011 ),
     .o_clk_div ()
   );

   wire [4:0]   w_100_023, w_010_023, w_001_023;

   grey_1000 m_grey_023
   ( .i_clk     ( w_clk_023 ),
     .i_rst     ( w_rst ),
     .o_100     ( w_100_023 ),
     .o_010     ( w_010_023 ),
     .o_001     ( w_001_023 ),
     .o_clk_div ()
   );

   wire [4:0]   w_100_047, w_010_047, w_001_047;

   grey_1000 m_grey_047
   ( .i_clk     ( w_clk_047 ),
     .i_rst     ( w_rst ),
     .o_100     ( w_100_047 ),
     .o_010     ( w_010_047 ),
     .o_001     ( w_001_047 ),
     .o_clk_div ()
   );


////////////////////////////////////////
   wire [4:0]   w_slow_100_005, w_slow_010_005, w_slow_001_005;

   slow_grey #( .pCOUNT( 1300 ) ) m_slow_grey_005
   ( .i_clk     ( w_clk_005 ),
     .i_rst     ( w_rst ),
     .o_100     ( w_slow_100_005 ),
     .o_010     ( w_slow_010_005 ),
     .o_001     ( w_slow_001_005 )
   );

   wire [4:0]   w_slow_100_011, w_slow_010_011, w_slow_001_011;

   slow_grey #( .pCOUNT( 600 ) ) m_slow_grey_011
   ( .i_clk     ( w_clk_011 ),
     .i_rst     ( w_rst ),
     .o_100     ( w_slow_100_011 ),
     .o_010     ( w_slow_010_011 ),
     .o_001     ( w_slow_001_011 )
   );

   wire [4:0]   w_slow_100_023, w_slow_010_023, w_slow_001_023;

   slow_grey #( .pCOUNT( 290 ) ) m_slow_grey_023
   ( .i_clk     ( w_clk_023 ),
     .i_rst     ( w_rst ),
     .o_100     ( w_slow_100_023 ),
     .o_010     ( w_slow_010_023 ),
     .o_001     ( w_slow_001_023 )
   );

   wire [4:0]   w_slow_100_047, w_slow_010_047, w_slow_001_047;

   slow_grey #( .pCOUNT( 290 ) ) m_slow_grey_047
   ( .i_clk     ( w_clk_047 ),
     .i_rst     ( w_rst ),
     .o_100     ( w_slow_100_047 ),
     .o_010     ( w_slow_010_047 ),
     .o_001     ( w_slow_001_047 )
   );


////////////////////////////////////////
   wire [4:0]   w_005_100, w_005_010, w_005_001;

   capture #( .pCOUNT( 1 ) ) m_cap_005
   ( .i_clk     ( i_clk ),
     .i_rst     ( i_rst ),
     .i_100     ( w_slow_100_005 ),
     .i_010     ( w_slow_010_005 ),
     .i_001     ( w_slow_001_005 ),

     .o_100     ( w_005_100 ),
     .o_010     ( w_005_010 ),
     .o_001     ( w_005_001 )
    );

   wire [4:0]   w_011_100, w_011_010, w_011_001;

   capture #( .pCOUNT( 1 ) ) m_cap_011
   ( .i_clk     ( i_clk ),
     .i_rst     ( i_rst ),
     .i_100     ( w_slow_100_011 ),
     .i_010     ( w_slow_010_011 ),
     .i_001     ( w_slow_001_011 ),

     .o_100     ( w_011_100 ),
     .o_010     ( w_011_010 ),
     .o_001     ( w_011_001 )
    );

   wire [4:0]   w_023_100, w_023_010, w_023_001;

   capture #( .pCOUNT( 1 ) ) m_cap_023
   ( .i_clk     ( i_clk ),
     .i_rst     ( i_rst ),
     .i_100     ( w_slow_100_023 ),
     .i_010     ( w_slow_010_023 ),
     .i_001     ( w_slow_001_023 ),

     .o_100     ( w_023_100 ),
     .o_010     ( w_023_010 ),
     .o_001     ( w_023_001 )
    );

   wire [4:0]   w_047_100, w_047_010, w_047_001;

   capture #( .pCOUNT( 1 ) ) m_cap_047
   ( .i_clk     ( i_clk ),
     .i_rst     ( i_rst ),
     .i_100     ( w_slow_100_047 ),
     .i_010     ( w_slow_010_047 ),
     .i_001     ( w_slow_001_047 ),

     .o_100     ( w_047_100 ),
     .o_010     ( w_047_010 ),
     .o_001     ( w_047_001 )
    );


////////////////////////////////////////
   wire [4:0]   w_005_011_100, w_005_011_010, w_005_011_001;

   capture #( .pCOUNT( 1500 ) ) m_cap_005_011
   ( .i_clk     ( w_clk_005 ),
     .i_rst     ( w_rst ),
     .i_100     ( w_100_011 ),
     .i_010     ( w_010_011 ),
     .i_001     ( w_001_011 ),

     .o_100     ( w_005_011_100 ),
     .o_010     ( w_005_011_010 ),
     .o_001     ( w_005_011_001 )
    );

   wire [4:0]   w_005_023_100, w_005_023_010, w_005_023_001;

   capture #( .pCOUNT( 3000 ) ) m_cap_005_023
   ( .i_clk     ( w_clk_005 ),
     .i_rst     ( w_rst ),
     .i_100     ( w_100_023 ),
     .i_010     ( w_010_023 ),
     .i_001     ( w_001_023 ),

     .o_100     ( w_005_023_100 ),
     .o_010     ( w_005_023_010 ),
     .o_001     ( w_005_023_001 )
    );

   wire [4:0]   w_005_047_100, w_005_047_010, w_005_047_001;

   capture #( .pCOUNT( 6000 ) ) m_cap_005_047
   ( .i_clk     ( w_clk_005 ),
     .i_rst     ( w_rst ),
     .i_100     ( w_100_047 ),
     .i_010     ( w_010_047 ),
     .i_001     ( w_001_047 ),

     .o_100     ( w_005_047_100 ),
     .o_010     ( w_005_047_010 ),
     .o_001     ( w_005_047_001 )
    );

   wire [4:0]   w_011_023_100, w_011_023_010, w_011_023_001;

   capture #( .pCOUNT( 1500 ) ) m_cap_011_023
   ( .i_clk     ( w_clk_011 ),
     .i_rst     ( w_rst ),
     .i_100     ( w_100_023 ),
     .i_010     ( w_010_023 ),
     .i_001     ( w_001_023 ),

     .o_100     ( w_011_023_100 ),
     .o_010     ( w_011_023_010 ),
     .o_001     ( w_011_023_001 )
    );

   wire [4:0]   w_011_047_100, w_011_047_010, w_011_047_001;

   capture #( .pCOUNT( 3000 ) ) m_cap_011_047
   ( .i_clk     ( w_clk_011 ),
     .i_rst     ( w_rst ),
     .i_100     ( w_100_047 ),
     .i_010     ( w_010_047 ),
     .i_001     ( w_001_047 ),

     .o_100     ( w_011_047_100 ),
     .o_010     ( w_011_047_010 ),
     .o_001     ( w_011_047_001 )
    );

   wire [4:0]   w_023_047_100, w_023_047_010, w_023_047_001;

   capture #( .pCOUNT( 1500 ) ) m_cap_023_047
   ( .i_clk     ( w_clk_023 ),
     .i_rst     ( w_rst ),
     .i_100     ( w_100_047 ),
     .i_010     ( w_010_047 ),
     .i_001     ( w_001_047 ),

     .o_100     ( w_023_047_100 ),
     .o_010     ( w_023_047_010 ),
     .o_001     ( w_023_047_001 )
    );

endmodule
