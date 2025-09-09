`default_nettype none
`timescale 1ns/1ps

/* Testbench for 8-bit Up/Down Counter
   This instantiates the user project (tt_um_updown_counter)
   and drives its inputs for simulation.
*/
module tb ();

  // Dump the signals to a VCD file (view with GTKWave or Surfer)
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  // Inputs & outputs
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Instantiate DUT (replace tt_um_example with your module)
  tt_um_updown_counter user_project (

      // Power pins for GL sim
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in  (ui_in),    // control inputs
      .uo_out (uo_out),   // counter outputs
      .uio_in (uio_in),   // unused
      .uio_out(uio_out),  // unused
      .uio_oe (uio_oe),   // unused
      .ena    (ena),      // always high
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // active-low reset
  );

  // Clock generation: 10ns period
  initial clk = 0;
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    ena    = 1;        // design enabled
    uio_in = 8'b0;     // unused
    ui_in  = 8'b0;     // {up_down, enable} are ui_in[1:0]
    rst_n  = 0;        // assert reset
    #20;
    rst_n  = 1;        // release reset

    // Count up (ui_in[0] = enable, ui_in[1] = up_down)
    ui_in[0] = 1; // enable
    ui_in[1] = 1; // up
    #100;

    // Count down
    ui_in[1] = 0; // down
    #100;

    // Disable counting
    ui_in[0] = 0;
    #50;

    $finish;
  end

endmodule
