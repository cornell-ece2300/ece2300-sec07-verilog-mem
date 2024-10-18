//========================================================================
// RegfileStruct1r1w_4x4b_RTL-test
//========================================================================

`include "ece2300-test.v"
`include "RegfileStruct1r1w_4x4b_RTL.v"

module Top();

  //----------------------------------------------------------------------
  // Setup
  //----------------------------------------------------------------------

  logic clk;
  logic reset;

  ece2300_TestUtils t( .* );

  //----------------------------------------------------------------------
  // Instantiate design under test
  //----------------------------------------------------------------------

  logic       dut_rst;
  logic       dut_wen;
  logic [1:0] dut_waddr;
  logic [3:0] dut_wdata;
  logic [1:0] dut_raddr;
  logic [3:0] dut_rdata;

  RegfileStruct1r1w_4x4b_RTL dut
  (
    .clk   (clk),
    .rst   (dut_rst || reset),
    .wen   (dut_wen),
    .waddr (dut_waddr),
    .wdata (dut_wdata),
    .raddr (dut_raddr),
    .rdata (dut_rdata)
  );

  //----------------------------------------------------------------------
  // check
  //----------------------------------------------------------------------
  // All tasks start at #1 after the rising edge of the clock. So we
  // write the inputs #1 after the rising edge, and check the outputs #1
  // before the next rising edge.

  task check
  (
    input logic       rst,
    input logic       wen,
    input logic [1:0] waddr,
    input logic [3:0] wdata,
    input logic [1:0] raddr,
    input logic [3:0] rdata
  );
    if ( !t.failed ) begin

      dut_rst   = rst;
      dut_wen   = wen;
      dut_waddr = waddr;
      dut_wdata = wdata;
      dut_raddr = raddr;

      #8;

      if ( t.n != 0 ) begin
        $display( "%3d: %b %b %d %h | %d > %h", t.cycles,
                  dut_rst, dut_wen, dut_waddr, dut_wdata, dut_raddr, dut_rdata );
      end

      `ECE2300_CHECK_EQ( dut_rdata, rdata );

      #2;

    end
  endtask

  //----------------------------------------------------------------------
  // test_case_1_basic
  //----------------------------------------------------------------------

  task test_case_1_basic();
    t.test_case_begin( "test_case_1_basic" );

    //   rst wen waddr wdata raddr rdata
    check( 0, 1, 0,    4'h0, 0,    4'h0 );
    check( 0, 1, 0,    4'h1, 0,    4'h0 );
    check( 0, 0, 0,    4'h0, 0,    4'h1 );

  endtask

  //----------------------------------------------------------------------
  // test_case_2_directed_values
  //----------------------------------------------------------------------

  task test_case_2_directed_values();
    t.test_case_begin( "test_case_2_directed_values" );

    //   rst wen waddr wdata raddr rdata
    check( 0, 1, 0,    4'h0, 0,    4'h0 );
    check( 0, 1, 0,    4'h1, 0,    4'h0 );
    check( 0, 1, 0,    4'h2, 0,    4'h1 );
    check( 0, 1, 0,    4'h3, 0,    4'h2 );

    check( 0, 1, 0,    4'h4, 0,    4'h3 );
    check( 0, 1, 0,    4'h5, 0,    4'h4 );
    check( 0, 1, 0,    4'h6, 0,    4'h5 );
    check( 0, 1, 0,    4'h7, 0,    4'h6 );

    check( 0, 1, 0,    4'h8, 0,    4'h7 );
    check( 0, 1, 0,    4'h9, 0,    4'h8 );
    check( 0, 1, 0,    4'ha, 0,    4'h9 );
    check( 0, 1, 0,    4'hb, 0,    4'ha );

    check( 0, 1, 0,    4'hc, 0,    4'hb );
    check( 0, 1, 0,    4'hd, 0,    4'hc );
    check( 0, 1, 0,    4'he, 0,    4'hd );
    check( 0, 1, 0,    4'hf, 0,    4'he );

    check( 0, 0, 0,    4'h0, 0,    4'hf );

  endtask

  //----------------------------------------------------------------------
  // test_case_3_directed_regs
  //----------------------------------------------------------------------

  task test_case_3_directed_regs();
    t.test_case_begin( "test_case_3_directed_regs" );

    //   rst wen waddr wdata raddr rdata
    check( 0, 1, 0,    4'ha, 0,    4'h0 );
    check( 0, 1, 1,    4'hb, 0,    4'ha );
    check( 0, 1, 2,    4'hc, 0,    4'ha );
    check( 0, 1, 3,    4'hd, 0,    4'ha );

    check( 0, 0, 0,    4'h0, 0,    4'ha );
    check( 0, 0, 0,    4'h0, 1,    4'hb );
    check( 0, 0, 0,    4'h0, 2,    4'hc );
    check( 0, 0, 0,    4'h0, 3,    4'hd );

    check( 0, 0, 0,    4'h0, 3,    4'hd );
    check( 0, 0, 0,    4'h0, 2,    4'hc );
    check( 0, 0, 0,    4'h0, 1,    4'hb );
    check( 0, 0, 0,    4'h0, 0,    4'ha );

  endtask

  //----------------------------------------------------------------------
  // test_case_4_random
  //----------------------------------------------------------------------

  logic       rand_wen;
  logic [1:0] rand_waddr;
  logic [3:0] rand_wdata;
  logic [1:0] rand_raddr;
  logic [3:0] rand_rdata;
  logic [3:0] rand_mem [3];

  task test_case_4_random();
    t.test_case_begin( "test_case_4_random" );

    // initialize reference memory

    for ( int i = 0; i < 4; i = i+1 ) begin
      rand_mem[i] = 0;
    end

    // random test loop

    for ( int i = 0; i < 50; i = i+1 ) begin

      // Generate random values for all inputs

      rand_wen   = 1'($urandom(t.seed));
      rand_waddr = 2'($urandom(t.seed));
      rand_wdata = 4'($urandom(t.seed));
      rand_raddr = 2'($urandom(t.seed));

      // Determine correct answer

      rand_rdata = rand_mem[rand_raddr];

      // Check DUT output matches correct answer

      check( 0, rand_wen, rand_waddr, rand_wdata, rand_raddr, rand_rdata );

      // Update reference memory

      if ( rand_wen )
        rand_mem[rand_waddr] = rand_wdata;

    end

  endtask

  //----------------------------------------------------------------------
  // test_case_5_random_reset
  //----------------------------------------------------------------------

  logic       rand_reset_rst;
  logic       rand_reset_wen;
  logic [1:0] rand_reset_waddr;
  logic [3:0] rand_reset_wdata;
  logic [1:0] rand_reset_raddr;
  logic [3:0] rand_reset_rdata;
  logic [3:0] rand_reset_mem [3];

  task test_case_5_random_reset();
    t.test_case_begin( "test_case_5_random_rest" );

    // initialize reference memory

    for ( int i = 0; i < 4; i = i+1 ) begin
      rand_reset_mem[i] = 0;
    end

    // random test loop

    for ( int i = 0; i < 50; i = i+1 ) begin

      // Generate random values for all inputs

      rand_reset_rst   = 1'($urandom(t.seed));
      rand_reset_wen   = 1'($urandom(t.seed));
      rand_reset_waddr = 2'($urandom(t.seed));
      rand_reset_wdata = 4'($urandom(t.seed));
      rand_reset_raddr = 2'($urandom(t.seed));

      // Determine correct answer

      rand_reset_rdata = rand_reset_mem[rand_reset_raddr];

      // Check DUT output matches correct answer

      check( rand_reset_rst, rand_reset_wen, rand_reset_waddr,
             rand_reset_wdata, rand_reset_raddr, rand_reset_rdata );

      // Update reference memory

      if ( rand_reset_rst ) begin
        for ( int j = 0; j < 3; j = j + 1 )
          rand_reset_mem[j] = 0;
      end
      else if ( rand_reset_wen )
        rand_reset_mem[rand_reset_waddr] = rand_reset_wdata;

    end

  endtask

  //----------------------------------------------------------------------
  // main
  //----------------------------------------------------------------------

  initial begin
    t.test_bench_begin( `__FILE__ );

    if ((t.n <= 0) || (t.n == 1)) test_case_1_basic();
    if ((t.n <= 0) || (t.n == 2)) test_case_2_directed_values();
    if ((t.n <= 0) || (t.n == 3)) test_case_3_directed_regs();
    if ((t.n <= 0) || (t.n == 4)) test_case_4_random();
    if ((t.n <= 0) || (t.n == 5)) test_case_5_random_reset();

    t.test_bench_end();
  end

endmodule

