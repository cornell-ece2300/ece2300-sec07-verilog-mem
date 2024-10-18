//========================================================================
// RegfileFlat1r1w_4x4b_RTL
//========================================================================

`ifndef REGFILE_FLAT_1R1W_4X4B_RTL
`define REGFILE_FLAT_1R1W_4X4B_RTL

`include "Mux4_RTL.v"
`include "Register_RTL.v"
`include "Decoder_RTL.v"

module RegfileFlat1r1w_4x4b_RTL
(
  (* keep=1 *) input  logic       clk,
  (* keep=1 *) input  logic       rst,

  (* keep=1 *) input  logic       wen,
  (* keep=1 *) input  logic [1:0] waddr,
  (* keep=1 *) input  logic [3:0] wdata,

  (* keep=1 *) input  logic [1:0] raddr,
  (* keep=1 *) output logic [3:0] rdata
);

  // State

  logic [3:0] regfile [4];

  //''' ACTIVITY '''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // Implement a 4-word 4-bit regfile with 1 write port and 1 read port
  //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // Write ports are sequential and should be implemented in a single
  // always_ff block, while read ports are combinational and should be
  // implemented in a separate always_comb block.

endmodule

`endif /* REGFILE_FLAT_1R1W_4X4B2To4_RTL */

