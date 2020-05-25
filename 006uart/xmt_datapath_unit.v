//==============================================================================
// Module name: xmt_datapath_unit
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
module xmt_datapath_unit
#(
  parameter word_size       = 8,
  parameter size_bit_count  = 3,
  parameter all_ones         = {{word_size + 1}{1'b1}}
)
(
  input  [word_size - 1 : 0] data_bus,
  input                      load_xmt_dr,
  input                      load_xmt_shftreg,
  input                      start,
  input                      shift,
  input                      clear,
  input                      clk,
  input                      rstn,

  output                     serial_out,
  output                     bc_lt_bcmax
);

  reg [word_size - 1 : 0]  xmt_datareg;
  reg [word_size : 0]      xmt_shftreg;
  reg [size_bit_count : 0] bit_count;

  assign serial_out  = xmt_shftreg[0];
  assign bc_lt_bcmax = {bit_count < word_size + 1};

  always @ (posedge clk, negedge rstn) begin
    if(!rstn) begin
      xmt_shftreg <= all_ones;
      bit_count   <= 4'd0;
    end
    else begin
      if(load_xmt_dr)
        xmt_datareg <= data_bus;
      
      if(load_xmt_shftreg)
        xmt_shftreg <= {xmt_datareg, 1'b1};

      if(start)
        xmt_shftreg[0] <= 1'b0;

      if(clear)
        bit_count <= 4'd0;

      if(shift) begin
        xmt_shftreg <= {1'b1, xmt_shftreg[word_size : 1]};
        bit_count   <= bit_count + 1;
      end
    end
  end
  
endmodule