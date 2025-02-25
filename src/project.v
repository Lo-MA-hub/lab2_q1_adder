/*
 * 8-bit Ripple Carry Adder for TinyTapeout
 */

`default_nettype none

module tt_um_adder (
    input  wire [7:0] ui_in,    // First 8-bit input (A)
    input  wire [7:0] uio_in,   // Second 8-bit input (B)
    output wire [7:0] uo_out,   // 8-bit sum output (Y)
    output wire [7:0] uio_out,  // Not used, set to 0
    output wire [7:0] uio_oe,   // Not used, set to 0
    input  wire       ena,      // Always 1, can be ignored
    input  wire       clk,      // Clock (not needed for combinational logic)
    input  wire       rst_n     // Reset (not needed for combinational logic)
);

  // Internal carry signals
  wire carry [7:0];

  // Instantiate 8 full adders in a ripple carry structure
  full_adder fa0 (ui_in[0], uio_in[0], 1'b0,    uo_out[0], carry[0]);
  full_adder fa1 (ui_in[1], uio_in[1], carry[0], uo_out[1], carry[1]);
  full_adder fa2 (ui_in[2], uio_in[2], carry[1], uo_out[2], carry[2]);
  full_adder fa3 (ui_in[3], uio_in[3], carry[2], uo_out[3], carry[3]);
  full_adder fa4 (ui_in[4], uio_in[4], carry[3], uo_out[4], carry[4]);
  full_adder fa5 (ui_in[5], uio_in[5], carry[4], uo_out[5], carry[5]);
  full_adder fa6 (ui_in[6], uio_in[6], carry[5], uo_out[6], carry[6]);
  full_adder fa7 (ui_in[7], uio_in[7], carry[6], uo_out[7], carry[7]);

  // Set unused outputs to 0
  assign uio_out = 8'b00000000;
  assign uio_oe  = 8'b00000000;

  // Prevent unused signal warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule

// Full Adder Module
module full_adder (
    input  wire a,    // Input bit A
    input  wire b,    // Input bit B
    input  wire cin,  // Carry-in
    output wire sum,  // Sum output
    output wire cout  // Carry-out
);

  assign sum  = a ^ b ^ cin;
  assign cout = (a & b) | (b & cin) | (cin & a);

endmodule
