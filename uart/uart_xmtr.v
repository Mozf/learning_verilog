//==============================================================================
// Module name: uart_xmtr
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

  wire load_xmt_dr;
  wire load_xmt_shftreg;
  wire start;
  wire shift;
  wire clear;
  wire bc_lt_bcmax;

  xmt_control xmt_control_inst_0
  (
    .clk               ( clk               ),
    .rstn              ( rstn              ),
    .load_xmt_dr       ( load_xmt_dr       ),
    .load_xmt_shftreg  ( load_xmt_shftreg  ),
    .start             ( start             ),
    .shift             ( shift             ),
    .clear             ( clear             ),
    .load_xmt_datareg  ( load_xmt_datareg  ),
    .byte_ready        ( byte_ready        ),
    .t_byte            ( t_byte            ),
    .bc_lt_bcmax       ( bc_lt_bcmax       )
  );

  xmt_datapath_unit xmt_datapath_unit_inst_0
  (
    .clk               ( clk               ),
    .rstn              ( rstn              ),
    .data_bus          ( data_bus          ),
    .load_xmt_dr       ( load_xmt_dr       ),
    .load_xmt_shftreg  ( load_xmt_shftreg  ),
    .start             ( start             ),
    .shift             ( shift             ),
    .clear             ( clear             ),
    .bc_lt_bcmax       ( bc_lt_bcmax       ),
    .serial_out        ( serial_out        )
  );
endmodule