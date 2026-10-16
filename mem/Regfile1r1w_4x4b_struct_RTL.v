//========================================================================
// Regfile1r1w_4x4b_struct_RTL
//========================================================================

`ifndef REGFILE_1R1W_4X4B_STRUCT_RTL
`define REGFILE_1R1W_4X4B_STRUCT_RTL

`include "ece2300/ece2300-misc.v"

`include "mem/Mux4_4b_RTL.v"
`include "mem/Decoder_2b_RTL.v"
`include "mem/Register_4b_RTL.v"

module Regfile1r1w_4x4b_struct_RTL
(
  (* keep=1 *) input  logic       clk,

  (* keep=1 *) input  logic       wen,
  (* keep=1 *) input  logic [1:0] waddr,
  (* keep=1 *) input  logic [3:0] wdata,

  (* keep=1 *) input  logic [1:0] raddr,
  (* keep=1 *) output logic [3:0] rdata
);

  //''' LAB ASSIGNMENT '''''''''''''''''''''''''''''''''''''''''''''''''''
  // Implement 4-element, 4-bit regfile structurally
  //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

  `ECE2300_UNUSED( clk );
  `ECE2300_UNUSED( wen );
  `ECE2300_UNUSED( waddr );
  `ECE2300_UNUSED( wdata );
  `ECE2300_UNUSED( raddr );
  `ECE2300_FLOATING( rdata );

endmodule

`endif /* REGFILE_R1W_4X4B_STRUCT_RTL */
