`timescale 10ns/10ns

module spi_top_tb;

  reg clk;
  reg resetn;
  reg rstn;

  reg cs_m;
  reg cs_s;
  reg mors_m;
  reg mors_s;

  reg wen_m;
  reg wen_s;
  reg [10:0] waddr_m;
  reg [10:0] waddr_s;
  reg [7:0] wdata_m;
  reg [7:0] wdata_s;

  reg ren_m;
  reg ren_s;
  reg [10:0] raddr_m;
  reg [10:0] raddr_s;
  wire not_empty_m;
  wire not_empty_s;
  wire [7:0] rdata_m;
  wire [7:0] rdata_s;

  wire SCLK;
  wire MOSI;
  wire MISO;
  wire CS;

  reg flag1;

  initial begin
    clk = 1'b0;
    resetn = 1'b0;
    rstn = 1'b0;
    cs_m = 1'b0;
    cs_s = 1'b0;
    mors_m = 1'b0;
    mors_s = 1'b0;
    wen_m = 1'b0;
    wen_s = 1'b0;
    waddr_m = 11'h000;
    waddr_s = 11'h000;
    wdata_m = 8'h00;
    wdata_s = 8'h00;
    ren_m = 1'b0;
    ren_s = 1'b0;
    raddr_m = 11'h000;
    raddr_s = 11'h000;
    flag1 = 1'b0;

    #10;
    resetn = 1'b1;
    rstn = 1'b1;
    cs_m = 1'b1;
    mors_m = 1'b1;

    #5;
    wen_m = 1'b1;
    wen_s = 1'b1;
    waddr_m = 11'h001;
    waddr_s = 11'h001;
    wdata_m = 8'h55;
    wdata_s = 8'h55;

    #5;
    waddr_m = 11'h002;
    waddr_s = 11'h002;
    wdata_m = 8'haa;
    wdata_s = 8'haa;
    flag1 = 1'b1;

    #600;
    ren_m   = 1'b1;
    raddr_m = raddr_m + 1'b1;
    ren_s   = 1'b1;
    raddr_s = raddr_s + 1'b1;
    #10;
    ren_m = 1'b0;
    ren_s = 1'b0;
    #50;
    ren_m   = 1'b1;
    raddr_m = raddr_m + 1'b1;
    ren_s   = 1'b1;
    raddr_s = raddr_s + 1'b1;
    #10;
    ren_m = 1'b0;
    ren_s = 1'b0;
    #50;
    ren_m   = 1'b1;
    raddr_m = raddr_m + 1'b1;
    ren_s   = 1'b1;
    raddr_s = raddr_s + 1'b1;
    #10;
    ren_m = 1'b0;
    ren_s = 1'b0;
    #50;
    ren_m   = 1'b1;
    raddr_m = raddr_m + 1'b1;
    ren_s   = 1'b1;
    raddr_s = raddr_s + 1'b1;
    #10;
    ren_m = 1'b0;
    ren_s = 1'b0;
    #50;
    ren_m   = 1'b1;
    raddr_m = raddr_m + 1'b1;
    ren_s   = 1'b1;
    raddr_s = raddr_s + 1'b1;
    #10;
    ren_m = 1'b0;
    ren_s = 1'b0;
    #50;
    ren_m   = 1'b1;
    raddr_m = raddr_m + 1'b1;
    ren_s   = 1'b1;
    raddr_s = raddr_s + 1'b1;
    #10;
    ren_m = 1'b0;
    ren_s = 1'b0;
    #50;
    ren_m   = 1'b1;
    raddr_m = raddr_m + 1'b1;
    ren_s   = 1'b1;
    raddr_s = raddr_s + 1'b1;
    #10;
    ren_m = 1'b0;
    ren_s = 1'b0;
    #50;
    ren_m   = 1'b1;
    raddr_m = raddr_m + 1'b1;
    ren_s   = 1'b1;
    raddr_s = raddr_s + 1'b1;
    #10;
    ren_m = 1'b0;
    ren_s = 1'b0;

    #500 $stop;
  end

  always #1 clk = ~clk;

  always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
      wen_m = 1'b0;
      wen_s = 1'b0;
      waddr_m = 11'h000;
      waddr_s = 11'h000;
      wdata_m = 8'h00;
      wdata_s = 8'h00;
    end
    else if(flag1 == 1'b1) begin
      waddr_m = waddr_m + 1;
      waddr_s = waddr_s + 1;
      wdata_m = waddr_m[7:0];
      wdata_s = waddr_s[7:0];
    end
  end

/*
  always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
      ren_m = 1'b0;
      ren_s = 1'b0;
      raddr_m = 11'h000;
      raddr_s = 11'h000;
    end
    else if(not_empty_m == 1'b1 || not_empty_s == 1'b1) begin
      ren_m = 1'b1;
      ren_s = 1'b1;
      raddr_m = raddr_m + 1'b1;
      raddr_s = raddr_s + 1'b1;
    end
    else if(not_empty_m == 1'b0 || not_empty_s == 1'b0) begin
      ren_m = 1'b0;
      ren_s = 1'b0;
      raddr_m = raddr_m;
      raddr_s = raddr_s;
    end
  end
*/

  spi_top spi_top_m
  (
    .clk_out1(clk),
    .resetn(resetn),
    .rstn(rstn),

    .cs(cs_m),
    .mors(mors_m),

    .wen(wen_m),
    .waddr(waddr_m),
    .wdata(wdata_m),

    .ren(ren_m),
    .raddr(raddr_s),
    .not_empty(not_empty_m),
    .rdata(rdata_m),

    .SCLK(SCLK),
    .MOSI(MOSI),
    .MISO(MISO),
    .CS(CS)
  );

  spi_top spi_top_s
  (
    .clk_out1(clk),
    .resetn(resetn),
    .rstn(rstn),

    .cs(cs_s),
    .mors(mors_s),

    .wen(wen_s),
    .waddr(waddr_s),
    .wdata(wdata_s),

    .ren(ren_m),
    .raddr(raddr_s),
    .not_empty(not_empty_s),
    .rdata(rdata_s),

    .SCLK(SCLK),
    .MOSI(MOSI),
    .MISO(MISO),
    .CS(CS)
  );

endmodule