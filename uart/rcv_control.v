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

  reg [word_size - 1 : 0]      rcv_shftreg;

  reg [num_state_bits - 1 : 0] current_state;
  reg [num_state_bits - 1 : 0] next_state;

  always @ (posedge clk) begin
    if(!rstn)
      next_state <= s_idle;
    else 
      next_state <= current_state;
  end

  always @ (current_state, ser_in_0, sc_eq_3, sc_lt_7) begin

    read_not_ready_out = 1'b0;
    clr_bit_counter    = 1'b0;
    clr_bit_counter    = 1'b0;
    inc_sample_counter = 1'b0;
    inc_bit_counter    = 1'b0;
    shift              = 1'b0;
    error1             = 1'b0;
    error2             = 1'b0;
    load               = 1'b0;
    next_state         = s_idle;

    case (current_state)
      s_idle: begin
        if(ser_in_0)
          next_state = s_starting;
        else
          next_state = s_idle;
      end

      s_starting: begin
        if(!ser_in_0) begin
          next_state         = s_idle;
          clr_sample_counter = 1'b1;
        end
        else if(sc_eq_3) begin
          clr_sample_counter = 1'b1;
          next_state         = s_receiving;
        end
        else begin
          inc_sample_counter = 1'b1;
          next_state         = s_starting;
        end
      end

      s_receiving: begin
        if(sc_lt_7) begin
          inc_sample_counter = 1'b1;
          next_state         = s_receiving;
        end
        else begin
          clr_sample_counter = 1'b1;
          if(!bc_eq_8) begin
            shift            = 1'b1;
            inc_bit_counter  = 1'b1;
            next_state       = s_receiving;
          end
          else begin
            read_not_ready_out = 1'b1;
            clr_bit_counter    = 1'b1;
            next_state         = s_idle;
            if(read_not_ready_in) 
              error1         = 1'b1;
            else if(ser_in_0)
              error2         = 1'b1;
            else
              load           = 1'b1;
          end
        end
      end

      default: next_state    = s_idle;
    endcase
  end

endmodule