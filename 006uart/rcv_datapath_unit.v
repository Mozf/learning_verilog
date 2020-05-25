//==============================================================================
// Module name: rcv_datapath_unit
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2019.10.1
// Description: 
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module rcv_datapath_unit
#(
  parameter word_size        = 8,
  parameter half_word        = word_size/2,
  parameter num_counter_bits = 4
)
(
  input                           clk,
  input                           rstn,

  output reg [word_size - 1 : 0]  rcv_datareg,
  output                          ser_in_0,
  output                          sc_eq_3,
  output                          sc_lt_7,
  output                          bc_eq_8,

  input                           serial_in,
  input                           clr_sample_counter,
  input                           inc_sample_counter,
  input                           clr_bit_counter,
  input                           inc_bit_counter,
  input                           shift,
  input                           load
);

  reg [word_size - 1 : 0]         rcv_shftreg;
  reg [num_counter_bits - 1 : 0]  sample_counter;
  reg [num_counter_bits : 0]      bit_counter;

  assign ser_in_0 = (serial_in == 1'b1);
  assign bc_eq_8  = (bit_counter == word_size);
  assign sc_lt_7  = (sample_counter < word_size - 1);
  assign sc_eq_3  = (sample_counter == half_word - 1);

  always @ (posedge clk, negedge rstn) begin
    if(!rstn) begin
      sample_counter <= 4'd0;
      bit_counter    <= 5'd0;
      rcv_datareg    <= 8'd0;
      rcv_shftreg    <= 8'd0;
    end
    else begin
      if(clr_sample_counter)
        sample_counter <= 1'b0;
      else if(inc_sample_counter)
        sample_counter <= sample_counter + 1'b1;
      
      if(clr_bit_counter)
        bit_counter <= 1'b0;
      else if(inc_bit_counter)
        bit_counter <= bit_counter + 1'b1;

      if(shift) 
        rcv_shftreg <= {serial_in, rcv_shftreg[word_size - 1 : 1]};

      if(load)
        rcv_datareg <= rcv_shftreg;
    end
  end

endmodule