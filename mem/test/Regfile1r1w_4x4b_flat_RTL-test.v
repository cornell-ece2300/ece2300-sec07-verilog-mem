//========================================================================
// Regfile1r1w_4x4b_flat_RTL-test
//========================================================================

`include "ece2300/ece2300-test.v"
`include "mem/Regfile1r1w_4x4b_flat_RTL.v"

module Top();

  //----------------------------------------------------------------------
  // Setup
  //----------------------------------------------------------------------

  logic clk;
  logic rst;

  TestUtilsClkRst t
  (
    .clk (clk),
    .rst (rst)
  );

  `ECE2300_UNUSED( rst );

  //----------------------------------------------------------------------
  // Instantiate design under test
  //----------------------------------------------------------------------

  logic       wen;
  logic [1:0] waddr;
  logic [3:0] wdata;
  logic [1:0] raddr;
  logic [3:0] rdata;

  Regfile1r1w_4x4b_flat_RTL dut
  (
    .clk   (clk),
    .wen   (wen),
    .waddr (waddr),
    .wdata (wdata),
    .raddr (raddr),
    .rdata (rdata)
  );

  //----------------------------------------------------------------------
  // Include test cases
  //----------------------------------------------------------------------

  `include "mem/test/Regfile1r1w_4x4b-test-cases.v"

endmodule

