//========================================================================
// Regfile1r1w_4x4b-test-cases
//========================================================================
// This file is meant to be included in a test bench.

//------------------------------------------------------------------------
// check
//------------------------------------------------------------------------
// The ECE 2300 test framework adds a 1 tau delay with respect to the
// rising clock edge at the very beginning of the test bench. So if we
// immediately set the inputs this will take effect 1 tau after the clock
// edge. Then we wait 8 tau, check the outputs, and wait 2 tau which
// means the next check will again start 1 tau after the rising clock
// edge.

task check
(
  input logic       wen_,
  input logic [1:0] waddr_,
  input logic [3:0] wdata_,
  input logic [1:0] raddr_,
  input logic [3:0] rdata_
);
  if ( !t.failed ) begin
    t.num_checks += 1;

    wen   = wen_;
    waddr = waddr_;
    wdata = wdata_;
    raddr = raddr_;

    #8;

    if ( t.n != 0 )
      $display( "%3d: %b %d %h | %d > %h", t.cycles,
                wen, waddr, wdata, raddr, rdata );

    `ECE2300_CHECK_EQ( rdata, rdata_ );

    #2;

  end
endtask

//----------------------------------------------------------------------
// test_case_1_basic
//----------------------------------------------------------------------

task test_case_1_basic();
  t.test_case_begin( "test_case_1_basic" );

  //    wen waddr wdata raddr rdata
  check( 1, 0,    4'h0, 0,    4'b? );
  check( 1, 0,    4'h1, 0,    4'h0 );
  check( 0, 0,    4'h0, 0,    4'h1 );

  t.test_case_end();
endtask

//----------------------------------------------------------------------
// test_case_2_directed_values
//----------------------------------------------------------------------

task test_case_2_directed_values();
  t.test_case_begin( "test_case_2_directed_values" );

  //    wen waddr wdata raddr rdata
  check( 1, 0,    4'h0, 0,    4'b? );
  check( 1, 0,    4'h1, 0,    4'h0 );
  check( 1, 0,    4'h2, 0,    4'h1 );
  check( 1, 0,    4'h3, 0,    4'h2 );

  check( 1, 0,    4'h4, 0,    4'h3 );
  check( 1, 0,    4'h5, 0,    4'h4 );
  check( 1, 0,    4'h6, 0,    4'h5 );
  check( 1, 0,    4'h7, 0,    4'h6 );

  check( 1, 0,    4'h8, 0,    4'h7 );
  check( 1, 0,    4'h9, 0,    4'h8 );
  check( 1, 0,    4'ha, 0,    4'h9 );
  check( 1, 0,    4'hb, 0,    4'ha );

  check( 1, 0,    4'hc, 0,    4'hb );
  check( 1, 0,    4'hd, 0,    4'hc );
  check( 1, 0,    4'he, 0,    4'hd );
  check( 1, 0,    4'hf, 0,    4'he );

  check( 0, 0,    4'h0, 0,    4'hf );

  t.test_case_end();
endtask

//----------------------------------------------------------------------
// test_case_3_directed_regs
//----------------------------------------------------------------------

task test_case_3_directed_regs();
  t.test_case_begin( "test_case_3_directed_regs" );

  //    wen waddr wdata raddr rdata
  check( 1, 0,    4'ha, 0,    4'b? );
  check( 1, 1,    4'hb, 0,    4'ha );
  check( 1, 2,    4'hc, 0,    4'ha );
  check( 1, 3,    4'hd, 0,    4'ha );

  check( 0, 0,    4'h0, 0,    4'ha );
  check( 0, 0,    4'h0, 1,    4'hb );
  check( 0, 0,    4'h0, 2,    4'hc );
  check( 0, 0,    4'h0, 3,    4'hd );

  check( 0, 0,    4'h0, 3,    4'hd );
  check( 0, 0,    4'h0, 2,    4'hc );
  check( 0, 0,    4'h0, 1,    4'hb );
  check( 0, 0,    4'h0, 0,    4'ha );

  t.test_case_end();
endtask

//----------------------------------------------------------------------
// test_case_4_random
//----------------------------------------------------------------------

logic       rand_wen;
logic [1:0] rand_waddr;
logic [3:0] rand_wdata;
logic [1:0] rand_raddr;
logic [3:0] rand_rdata;
logic [3:0] rand_mem [4];

task test_case_4_random();
  t.test_case_begin( "test_case_4_random" );

  // initialize reference memory

  for ( int i = 0; i < 4; i = i+1 )
    rand_mem[i] = 0;

  // initialize register file with all zeros

  check( 1, 0, 4'h0, 0, 4'b? );
  check( 1, 1, 4'h0, 0, 4'b? );
  check( 1, 2, 4'h0, 0, 4'b? );
  check( 1, 3, 4'h0, 0, 4'b? );

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

    check( rand_wen, rand_waddr, rand_wdata, rand_raddr, rand_rdata );

    // Update reference memory

    if ( rand_wen )
      rand_mem[rand_waddr] = rand_wdata;

  end

  t.test_case_end();
endtask

//----------------------------------------------------------------------
// main
//----------------------------------------------------------------------

initial begin
  t.test_bench_begin();

  if ((t.n <= 0) || (t.n == 1)) test_case_1_basic();
  if ((t.n <= 0) || (t.n == 2)) test_case_2_directed_values();
  if ((t.n <= 0) || (t.n == 3)) test_case_3_directed_regs();
  if ((t.n <= 0) || (t.n == 4)) test_case_4_random();

  t.test_bench_end();
end

