`timescale 100ns/1ns
module tb_top;
  reg clk;

  reg SW0;

  reg red1;
  reg red2;
  reg red3;

  reg BTN0;
  reg BTN1;
  reg BTN2;
  reg BTN3;
  reg BTN4;
  reg BTN5;
  reg BTN6;

  wire LED0;
  wire LED1;
  wire LED2;
  wire LED3;
  wire LED4_R;
  wire LED4_G;
  wire LED4_B;
  wire LED5_R;
  wire LED5_G;
  wire LED5_B;
  wire LED6;
  wire LED7;
  wire LED8;

  wire [3:0] INgogo;

  initial begin
    clk = 0;
    SW0 = 0;

    red1 = 1;
    red2 = 1;
    red3 = 1;

    BTN0 = 0;
    BTN1 = 0;
    BTN2 = 0;
    BTN3 = 0;
    BTN4 = 0;
    BTN5 = 0;
    BTN6 = 0;

    #1 red2 = 0;
    #50 SW0 = 1;

    #10000;
    #500000 red2 = 1;
    red1 = 0;

    #20 BTN2 = 1;
    #25 BTN2 = 0;
    
    #1000 red1 = 1;
    #500000 red2 = 0;
    #1000000 red2 = 1;
    #2000000 $stop;
  end

  always #1 clk = ~clk;

  top top_inst_0
  (
    .sysclk(clk),

  //reset
    .SW0(SW0),

  //redcatch
    .red1(red1),
    .red2(red2),
    .red3(red3),

  //btncontrol
    .BTN0(BTN0),
    .BTN1(BTN1),
    .BTN2(BTN2),
    .BTN3(BTN3),
    .BTN4(BTN4),
    .BTN5(BTN5),
    .BTN6(BTN6),

  //ledcontrol
    .LED0(LED0),
    .LED1(LED1),
    .LED2(LED2),
    .LED3(LED3),
    .LED4_R(LED4_R),
    .LED4_G(LED4_G),
    .LED4_B(LED4_B),
    .LED5_R(LED5_R),
    .LED5_G(LED5_G),
    .LED5_B(LED5_B),
    .LED6(LED6),
    .LED7(LED7),
    .LED8(LED8),

    .INgogo(INgogo)
  );
endmodule