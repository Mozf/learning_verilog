//==============================================================================
// Module name: xmt_control
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2019.9.24
// Description: 
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module xmt_control
#(
  parameter one_hot_count  = 3,
  parameter state_count    = 3,
  parameter size_bit_conut = 3,
  
  parameter s_idle         = 3'b001,
  parameter s_waiting      = 3'b010,
  parameter s_sending      = 3'b100,
  parameter all_ones       = 9'b1_1111_1111  
)
(
  output reg load_xmt_dr,
  output reg load_xmt_shftreg,
  output reg start,
  output reg shift,
  output reg clear,
  input      load_xmt_datareg,
  input      byte_ready,
  input      t_byte,
  input      bc_lt_bcmax,

  input      clk,
  input      rstn
);

  reg [state_count - 1 : 0]  current_state;
  reg [state_count - 1 : 0]  next_state;

  always @ (posedge clk or negedge rstn) begin
    if(!rstn)
      current_state <= s_idle;
    else
      current_state <= next_state;
  end

  always @ (current_state, load_xmt_datareg, byte_ready, t_byte, bc_lt_bcmax) begin
    
    load_xmt_dr      = 1'b0;
    load_xmt_shftreg = 1'b0;
    start            = 1'b0;
    shift            = 1'b0;
    clear            = 1'b0;
    next_state       = s_idle;

    case(current_state)
      s_idle: begin
        if(load_xmt_datareg == 1'b1) begin 
          load_xmt_dr = 1;
          next_state  = s_idle;
        end
        else if(byte_ready == 1'b1) begin
          load_xmt_shftreg = 1'b1;
          next_state       = s_waiting;
        end
      end

      s_waiting: begin
        if(t_byte == 1'b1) begin
          start      = 1'b1;
          next_state = s_sending;
        end
        else 
          next_state = s_waiting;
      end

      s_sending: begin
        if(bc_lt_bcmax == 1'b1) begin
          shift      = 1'b1;
          next_state = s_sending;
        end
        else begin
          clear = 1'b1;
          next_state = s_idle;
        end
      end

      default: next_state = s_idle;
    endcase
  end

endmodule