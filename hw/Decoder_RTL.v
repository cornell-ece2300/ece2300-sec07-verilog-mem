//========================================================================
// Decoder_RTL
//========================================================================

`ifndef DECODER_RTL
`define DECODER_RTL

module Decoder_RTL
#(
  parameter p_nbits = 4
)(
  (* keep=1 *) input  logic [$clog2(p_nbits)-1:0] in,
  (* keep=1 *) output logic         [p_nbits-1:0] out
);

  //''' ACTIVITY '''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // Implement a parameterized decoder using an always_comb
  //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // Assume p_nbits is always an even power of two
  //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

  always_comb begin
    out = 0;
    out[in] = 1;
  end

  //<'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

endmodule

`endif /* DECODER2To4_RTL */

