//==============================================================================
// Module name: rcv_control
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2019.9.25
// Description: 
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module rcv_control
#(
  parameter word_size      = 8,
  parameter half_word      = word_size/2,
  parameter num_state_bits = 2,

  parameter s_idle         = 2'b00,
  parameter s_starting     = 2'b01,
  parameter s_receiving    = 2'b10
)
(
  input      clk,
  input      rstn,

  input      read_not_ready_in,
  input      ser_in_0,
  input      sc_eq_3,
  input      sc_lt_7,
  input      bc_eq_8,

  output reg read_not_ready_out,
  output reg error1,
  output reg error2,
  output reg clr_sample_counter,
  output reg inc_sample_counter,
  output reg clr_bit_counter,
  output reg inc_bit_counter,
  output reg shift,
  output reg load
);

endmodule