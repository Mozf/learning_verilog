//==============================================================================
// Module name: tb_add_prop
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2019.10.3
// Description: 
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
`timescale 1ns/1ns

module tb_add_prop;
  reg   [3:0]   a;
  reg   [3:0]   b;
  reg           c_in;
  wire  [3:0]   sum;
  wire          c_out;

  initial begin
    a = 0;
    b = 0;
    c_in = 0;

    #5 a = 3;
    #5 b = 7;
    #5 c_in = 1;
    #5 a = 11;
    #5 c_in = 0;
    #5 b = 2;
    #5 $stop;
  end

  add_prop_gen add_prop_gen_inst_0
  (
    .a      ( a       ),
    .b      ( b       ),
    .c_in   ( c_in    ),
    .sum    ( sum     ),
    .c_out  ( c_out   )
  );
endmodule