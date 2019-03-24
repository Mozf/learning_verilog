`timescale 1ns/1ns

module spi_xil_bram_in_tb;

  reg           clka1;
  reg           clkb1;
  reg           rstn;

  reg           wen1;
  reg   [7:0]   wdata1;

  reg           ren1;
  reg   [10:0]  raddr1;
  reg   [10:0]  raddr2;
  wire          not_empty1;
  wire  [7:0]   rdata1;

  initial begin
    clka1  = 1'b0;
    clkb1  = 1'b0;
    rstn   = 1'b0;

    wen1   = 1'b0;
    wdata1 = 8'h00;

    ren1   = 1'b0;
    raddr1 = 8'h000;
    raddr2 = 8'h000;

    #20;
    rstn   = 1'b1;
    #8;
    wdata1 = 8'h99;
    #2;
    wen1   = 1'b1;
    #5;
    wen1   = 1'b0;
    #8;
    wdata1 = 8'h34;
    #2;
    wen1   = 1'b1;
    #5;
    wen1   = 1'b0;
    #8;
    wdata1 = 8'h63;
    #2;
    wen1   = 1'b1;
    #5;
    wen1   = 1'b0;
    #8;
    wdata1 = 8'h47;
    #2;
    wen1   = 1'b1;
    #5;
    wen1   = 1'b0;
    #8;
    wdata1 = 8'h87;
    #2;
    wen1   = 1'b1;
    #5;
    wen1   = 1'b0;

    #10;
    ren1   = 1'b1;
    raddr2 = raddr1;
    raddr1 = raddr1 + 1'b1;
    #10;
    ren1   = 1'b0;
    #10;
    ren1   = 1'b1;
    raddr2 = raddr1;
    raddr1 = raddr1 + 1'b1;
    #10;
    ren1   = 1'b0;
    #10;
    ren1   = 1'b1;
    raddr2 = raddr1;
    raddr1 = raddr1 + 1'b1;
    #10;
    ren1   = 1'b0;
    #10;
    ren1   = 1'b1;
    raddr2 = raddr1;
    raddr1 = raddr1 + 1'b1;
    #10;
    ren1   = 1'b0;
    #10;
    ren1   = 1'b1;
    raddr2 = raddr1;
    raddr1 = raddr1 + 1'b1;
    #10;
    ren1   = 1'b0;
    #500 $stop;
  end

  always #1 clka1 = ~clka1;
  always #1 clkb1 = ~clkb1; 

  spi_xil_bram_in u_spi_xil_bram_in
  (
    .clka1(clka1),
    .clkb1(clkb1),
    .rstn(rstn),

    .wen1(wen1),
    .wdata1(wdata1),

    .ren1(ren1),
    .raddr1(raddr2),
    .not_empty1(not_empty1),
    .rdata1(rdata1)
  );

endmodule 
