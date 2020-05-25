`timescale 1ns/1ns

module btncon_tb;

  reg       clk;
  reg       rstn;

  //外呼
  reg       BTN0;

  wire      BTN0_out;


  initial begin
    clk  <= 1'b0;
    rstn <= 1'b0;
    BTN0 <= 1'b0;

    #50 rstn <= 1'b1;
    #50 BTN0 <= 1'b1;
    #1  BTN0 <= 1'b0;
    #10 BTN0 <= 1'b1;
    #2  BTN0 <= 1'b0;
    #10 BTN0 <= 1'b1;
    #3  BTN0 <= 1'b0;
    #10 BTN0 <= 1'b1;
    #4  BTN0 <= 1'b0;
    #10 BTN0 <= 1'b1;
    #5  BTN0 <= 1'b0;
    
    #500 $stop;
  end

  always #1 clk = ~clk;

  btncontrol inst_btncontrol
  (
    .clk(clk),
    .rstn(rstn),
    .BTN0(BTN0),
    .BTN0_out(BTN0_out)
  );
endmodule