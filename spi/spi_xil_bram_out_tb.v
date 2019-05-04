`timescale 10ns/10ns

module spi_xil_bram_out_tb;

  reg           clka0;
  reg           clkb0;
  reg           rstn;

  reg           wen0;
  reg   [7:0]   wdata0;
  reg   [10:0]  waddr0;

  reg           ren0;
  wire          not_empty0;
  wire  [7:0]   rdata0;

  initial begin
    clka0  = 1'b0;
    clkb0  = 1'b0;
    rstn   = 1'b0;

    wen0   = 1'b0;
    wdata0 = 8'h00;
    waddr0 = 11'h000;

    ren0 = 1'b0;

    #20;
    rstn = 1'b1;
    wen0 = 1'b1;
    #10 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #20 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #500 $stop;
  end

  always #1 clka0 = ~clka0;
  always #1 clkb0 = ~clkb0;

  always @(posedge clka0 or negedge rstn) begin
    if(!rstn) begin
      waddr0 <= 11'h000;
      wdata0 <= 8'h00;
    end
    else begin
      waddr0 <= waddr0 + 1'b1;
      wdata0 <= wdata0 + 1'b1;
    end
  end

  spi_xil_bram_out u_spi_xil_bram_out
  (
    .clka0(clka0),
    .clkb0(clkb0),
    .rstn(rstn),

    .wen0(wen0),
    .wdata0(wdata0),
    .waddr0(waddr0),

    .ren0(ren0),
    .not_empty0(not_empty0),
    .rdata0(rdata0)
  );

endmodule 
