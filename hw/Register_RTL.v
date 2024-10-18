//========================================================================
// Register_RTL
//========================================================================

`ifndef REGISTER_RTL_V
`define REGISTER_RTL_V

module Register_RTL
#(
  parameter p_nbits = 1
)(
  input  logic               clk,
  input  logic               rst,
  input  logic               en,
  input  logic [p_nbits-1:0] d,
  output logic [p_nbits-1:0] q
);

  //''' LAB ASSIGNMENT '''''''''''''''''''''''''''''''''''''''''''''''''''
  // Implement a parameterized register using an always_ff
  //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

  always_ff @(posedge clk) begin
    if ( rst )
      q <= 0;
    else if ( en )
      q <= d;
  end

  //<'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

endmodule

`endif /* REGISTER_RTL_V */

