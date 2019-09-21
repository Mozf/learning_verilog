module uart_xmtr
#(
  parameter word_size = 8
)
(
  output                    serial_out,
  
  input [word_size - 1 : 0] data_bus,
  
  input                     load_xmt_datareg,
  input                     byte_ready,
  input                     t_byte,

  input                     clk,
  input                     rstn
);
endmodule