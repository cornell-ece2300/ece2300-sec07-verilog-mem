//========================================================================
// Regfile1r1w_4x4b_flat_RTL
//========================================================================

`ifndef REGFILE_1R1W_4X4B_FLAT_RTL
`define REGFILE_1R1W_4X4B_FLAT_RTL

`include "ece2300/ece2300-misc.v"

module Regfile1r1w_4x4b_flat_RTL
(
  (* keep=1 *) input  logic       clk,

  (* keep=1 *) input  logic       wen,
  (* keep=1 *) input  logic [1:0] waddr,
  (* keep=1 *) input  logic [3:0] wdata,

  (* keep=1 *) input  logic [1:0] raddr,
  (* keep=1 *) output logic [3:0] rdata
);

  // State

  logic [3:0] mem [4];

  //''' ACTIVITY '''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // Implement a 4-word 4-bit regfile with 1 write port and 1 read port
  //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // Write ports are sequential and should be implemented in a single
  // always_ff block, while read ports are combinational and should be
  // implemented using an assign statement.
  //:
  //: `ECE2300_UNUSED( clk );
  //: `ECE2300_UNUSED( wen );
  //: `ECE2300_UNUSED( waddr );
  //: `ECE2300_UNUSED( wdata );
  //: `ECE2300_UNUSED( rdata );
  //: `ECE2300_FLOATING( rdata );
  //:

  // Sequential write port

  always_ff @( posedge clk ) begin

    if ( wen )
      mem[waddr] <= wdata;
    else if ( !wen )
      mem[waddr] <= mem[waddr];
    else
      mem[waddr] <= 'x;

  end

  // Combinational read port

  assign rdata = mem[raddr];

endmodule

`endif /* REGFILE_1R1W_4X4B_FLAT_RTL */
