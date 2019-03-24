`timescale 10ns/10ns

module spi_xil_bram_out_tb;

  reg           clka0;
  reg           clkb0;
  reg           rstn;

  reg           wen0;
  reg   [7:0]   wdata0;
  reg   [10:0]  waddr0;
  reg   [7:0]   wdata1;
  reg   [10:0]  waddr1;

  reg           ren0;
  wire          not_empty0;
  wire  [7:0]   rdata0;

  reg   [4:0]   i;
  reg   [4:0]   a;

  initial begin
    clka0  = 1'b0;
    clkb0  = 1'b0;
    rstn   = 1'b0;

    wen0   = 1'b0;
    wdata0 = 8'h00;
    waddr0 = 11'h000;
    waddr1 <= 11'h000;
    wdata1 <= 8'h00;

    ren0 = 1'b0;
    i    = 5'b00000;
    a    = 5'b00000;

    #20;
    rstn = 1'b1;
    wen0 = 1'b1;
    
    #10 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #20 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #20 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #20 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #20 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #20 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #20 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #20 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #20 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #20 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #20 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #20 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #20 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #20 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #20 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #20 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #20 ren0 = 1'b1;
    #10 ren0 = 1'b0;
    #100 $stop;
  end

  always #1 clka0 = ~clka0;
  always #1 clkb0 = ~clkb0;

  always @(posedge clka0 or negedge rstn) begin
    if(!rstn) begin
      waddr0 <= 11'h000;
      wdata0 <= 8'h00;
      waddr1 <= 11'h000;
      wdata1 <= 8'h00;
    end
    else begin
      waddr1 <= waddr0;
      wdata1 <= wdata0;
      wdata0 <= wdata0 + 1'b1;
      waddr0 <= waddr0 + 1'b1;   
    end
  end

  always @(posedge clka0 or negedge rstn) begin
    if(!rstn) begin
      ren0 <= 1'b0;
      i <= 5'b00000;
    end
    else begin
      if(i == 5'b01010) begin
        i <= 5'b00000;
        ren0 <= ~ren0;
      end
      else begin             
        i <= i + 1'b1;
      end
    end
  end
/*
  always @(posedge clka0 or negedge rstn) begin
    if(!rstn) begin
      a <= 5'b00000;
    end
    else begin
      if(rdata0 == 8'hff && i == 5'b01001 && ren0 == 1'b1) begin
        a <= a + 1'b1;
      end
      if(a == 5'b01001) begin
        $stop;
      end
    end
  end*/

  spi_xil_bram_out u_spi_xil_bram_out
  (
    .clka0(clka0),
    .clkb0(clkb0),
    .rstn(rstn),

    .wen0(wen0),
    .wdata0(wdata1),
    .waddr0(waddr1),

    .ren0(ren0),
    .not_empty0(not_empty0),
    .rdata0(rdata0)
  );

endmodule 
