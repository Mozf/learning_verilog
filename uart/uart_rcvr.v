//==============================================================================
// Module name: uart_rcvr
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2019.10.2
// Description: 
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module uart_rcvr 
#(
  parameter  word_size = 8,
  parameter  half_word = word_size / 2
)
(
  output [word_size - 1 : 0]  rcv_datareg,
  output                      read_not_ready_out,
  output                      error1,
  output                      error2,

  input                       serial_in,
  input                       read_not_ready_in,
  input                       clk,
  input                       rstn
);

  wire serial_in_0;
  wire sc_eq_3;
  wire sc_lt_7;
  wire bc_eq_8;
  wire clr_sample_counter;
  wire inc_sample_counter;
  wire clr_bit_counter;
  wire inc_bit_counter;
  wire shift;
  wire load;

  rcv_countrol rcv_countrol_inst_0
  (
    .clk                ( clk                 ),
    .rstn               ( rstn                ),

    .read_not_ready_in  ( read_not_ready_in   ),
    .serial_in_0        ( serial_in_0         ),
    .sc_eq_3            ( sc_eq_3             ),
    .sc_lt_7            ( sc_lt_7             ),
    .bc_eq_8            ( bc_eq_8             ),

    .read_not_ready_out ( read_not_ready_out  ),
    .error1             ( error1              ),
    .error2             ( error2              ),
    .clr_sample_counter ( clr_sample_counter  ),
    .inc_sample_counter ( inc_sample_counter  ),
    .clr_bit_counter    ( clr_bit_counter     ),
    .inc_bit_counter    ( inc_bit_counter     ),
    .shift              ( shift               ),
    .load               ( load                )
  );

  rcv_datapath_unit rcv_datapath_unit_inst_0
  (
    .clk                ( clk                 ),
    .rstn               ( rstn                ),

    .rcv_datareg        ( rcv_datareg         ),
    .serial_in_0        ( serial_in_0         ),
    .sc_eq_3            ( sc_eq_3             ),
    .sc_lt_7            ( sc_lt_7             ),
    .bc_eq_8            ( bc_eq_8             ),

    .serial_in          ( serial_in           ),
    .clr_sample_counter ( clr_sample_counter  ),
    .inc_sample_counter ( inc_sample_counter  ),
    .clr_bit_counter    ( clr_bit_counter     ),
    .inc_bit_counter    ( inc_bit_counter     ),
    .shift              ( shift               ),
    .load               ( load                )
  );

endmodule 