module top2003
(
  input         a,
  input         SW1,
  input         sysclk,

  output  [3:0] INgogo,
  output        led0,
  output        led1,
  output        led2,
  output        led3
);

  wire clk1;
  wire rstn1;

  assign led2 = SW1;
  assign led3 = clk1;

  testULN2003 inst_testULN2003_0
  (
    .clk    ( clk1    ),
    .a      ( a       ),
    .rstn   ( rstn1   ),
    .INgogo ( INgogo  ),
    .led0   ( led0    ),
    .led1   ( led1    )
  );

  clk_wiz_0 inst_clk_wiz_0_0
  (
    .clk_out1 ( clk1    ),
    .clk_in1  ( sysclk  )
  );

  resetn inst_resetn_0
  (
    .SW1  ( SW1   ),
    .rstn ( rstn1 )
  );
endmodule