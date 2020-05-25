//==============================================================================
// Module name: tb_uart_xmtr
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
module tb_uart_xmtr;
  reg [7:0] data_bus;
  reg load_xmt_datareg;
  reg byte_ready;
  reg t_byte;
  reg clk;
  reg rstn;

  wire serial_out;
  reg [9:0] serreg;
  reg [7:0] ser;

  initial begin
    clk = 1'b0;
    data_bus = 8'ha7;
    load_xmt_datareg = 1'b0;
    byte_ready = 1'b0;
    t_byte = 1'b0;
    rstn = 1'b0;

    #5 rstn = 1'b1;
    #5 load_xmt_datareg = 1'b1;
    #3 load_xmt_datareg = 1'b0;
    #5 byte_ready = 1'b1;
    #3 byte_ready = 1'b0;
    #5 t_byte = 1'b1;
    #3 t_byte = 1'b0;
    #100 $stop;
  end

  always #1 clk = ~clk;

  always @ (posedge clk) begin
    if(!rstn) begin
      serreg <= 10'h000;
      ser    <= 8'h00;
    end
    else begin
      serreg <= {serial_out,serreg[9:1]};
      ser    <= serreg[8:1];
    end
  end

  uart_xmtr uart_xmtr_inst_0
  (
    .data_bus         ( data_bus         ),
    .load_xmt_datareg ( load_xmt_datareg ),
    .byte_ready       ( byte_ready       ),
    .t_byte           ( t_byte           ),
    .clk              ( clk              ),
    .rstn             ( rstn             ),
    .serial_out       ( serial_out       )
  );

endmodule