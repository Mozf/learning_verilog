`timescale 10ns/10ns

module spi_counter_tb;

  reg clk;
  reg rstn;

  reg cs_m;
  reg mors_m;
  wire [1:0] cnt_m;
  reg SCLK_m;

  reg cs_s;
  reg mors_s;
  wire [1:0] cnt_s;
  wire sclk_s;

  initial begin
    clk = 1'b0;
    rstn = 1'b0;
    cs_m = 1'b0;
    mors_m = 1'b0;
    cs_s = 1'b0;
    mors_s = 1'b0;
    #10;
    rstn = 1'b1;
    #5;
    mors_m = 1'b1;
    cs_m = 1'b1;
    #500 $stop;
  end

  always #1 clk = ~clk;

  wire sclk_ms;

  spi_counter spi_counter_m
  (
    .clk(clk),
    .rstn(rstn),

    .cs(cs_m),
    .mors(mors_m),

    .cnt(cnt_m),

    .sclk_in(SCLK_m),
    .sclk_out(sclk_ms)
  );

  spi_counter spi_counter_s
  (
    .clk(clk),
    .rstn(rstn),

    .cs(cs_s),
    .mors(mors_s),

    .cnt(cnt_s),

    .sclk_in(sclk_ms),
    .sclk_out(sclk_s)
  );

endmodule