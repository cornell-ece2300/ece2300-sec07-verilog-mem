//========================================================================
// RegfileStruct1r1w_4x4b_RTL
//========================================================================

`ifndef REGFILE_STRUCT_1R1W_4X4B_RTL
`define REGFILE_STRUCT_1R1W_4X4B_RTL

`include "Mux4_RTL.v"
`include "Register_RTL.v"
`include "Decoder_RTL.v"

module RegfileStruct1r1w_4x4b_RTL
(
  (* keep=1 *) input  logic       clk,
  (* keep=1 *) input  logic       rst,

  (* keep=1 *) input  logic       wen,
  (* keep=1 *) input  logic [1:0] waddr,
  (* keep=1 *) input  logic [3:0] wdata,

  (* keep=1 *) input  logic [1:0] raddr,
  (* keep=1 *) output logic [3:0] rdata
);

  // Write Address Decoder

  logic [3:0] regfile_en;

  Decoder_RTL#(4) waddr_decoder
  (
    .in  (waddr),
    .out (regfile_en)
  );

  // Register file array

  logic [3:0] regfile_q [4];

  genvar i;
  generate
    for ( i = 0; i < 4; i = i + 1 ) begin : regfile

     //''' ACTIVITY ''''''''''''''''''''''''''''''''''''''''''''''''''''''
     // Instantate a 4-bit register and connect appropriately
     //>''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

    end
  endgenerate

  // Read mux

  Mux4_RTL#(4) mux
  (
    .in0 (regfile_q[0]),
    .in1 (regfile_q[1]),
    .in2 (regfile_q[2]),
    .in3 (regfile_q[3]),
    .sel (raddr),
    .out (rdata)
  );

endmodule

`endif /* REGFILE_STRUCT_1R1W_4X4B2To4_RTL */

