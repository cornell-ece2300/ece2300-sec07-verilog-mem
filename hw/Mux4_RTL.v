//========================================================================
// Mux4_RTL
//========================================================================

`ifndef MUX4_RTL
`define MUX4_RTL

module Mux4_RTL
#(
  parameter p_nbits = 1
)(
  (* keep=1 *) input  logic [p_nbits-1:0] in0,
  (* keep=1 *) input  logic [p_nbits-1:0] in1,
  (* keep=1 *) input  logic [p_nbits-1:0] in2,
  (* keep=1 *) input  logic [p_nbits-1:0] in3,
  (* keep=1 *) input  logic         [1:0] sel,
  (* keep=1 *) output logic [p_nbits-1:0] out
);

  //''' ACTIVITY '''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // Implement a parameterized 4-to-1 mux using a case statement
  //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

  always_comb begin
    case ( sel )
      0       : out = in0;
      1       : out = in1;
      2       : out = in2;
      3       : out = in3;
      default : out = 'x;
    endcase
  end

  //<'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

endmodule

`endif /* MUX4_RTL */

