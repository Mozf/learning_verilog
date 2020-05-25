`timescale 10ns/10ns

module blk_mem_gen_0_tb;

  reg           clka0;
  reg           clkb0;
  reg           rstn;
  reg           rsta;

  reg           wen0;
  reg   [7:0]   wdata0;
  reg   [10:0]  waddr0;

  reg           ren0;
  wire  [7:0]   rdata0;
  wire  [7:0]   wdata;

  initial begin
    clka0 = 1'b0;
    clkb0 = 1'b0;
    rstn  = 1'b0;
    rsta  = 1'b1;

    wen0  = 1'b0;
    wdata0= 8'h00;
    waddr0= 11'h000;

    ren0  = 1'b0;

    #20;
    rstn  = 1'b1;
    wen0  = 1'b1;
    rsta  = 1'b0;    
    #10;
    ren0  = 1'b1;
    #5;
    ren0  = 1'b0;
    #10;
    ren0  = 1'b1;
    #5;
    ren0  = 1'b0;
    #10;
    ren0  = 1'b1;
    #5;
    ren0  = 1'b0;
    #10;
    ren0  = 1'b1;
    #5;
    ren0  = 1'b0;
    #10;
    ren0  = 1'b1;
    #10;
    ren0  = 1'b0;
    #10;
    ren0  = 1'b1;
    #10;
    ren0  = 1'b0;
    #10;
    ren0  = 1'b1;
    #10;
    ren0  = 1'b0;
    #10;
    ren0  = 1'b1;
    #10;
    ren0  = 1'b0;
    #10;
    ren0  = 1'b1;
    #10;
    ren0  = 1'b0;
    #10;
    ren0  = 1'b1;
    #10;
    ren0  = 1'b0;
    #10;
    ren0  = 1'b1;
    #10;
    ren0  = 1'b0;
    
    #500 $stop;
  end

  reg ren0_reg;
  reg [10:0] raddr_reg;

  always #1 clka0 = ~clka0;
  always #2 clkb0 = ~clkb0;
  
  always @(posedge clka0 or negedge rstn) begin
    if(!rstn) begin
      wdata0 <= 8'h00;
      waddr0 <= 11'h000;
    end
    else begin
      waddr0 <= waddr0 + 1'b1;
      wdata0 <= wdata0 + 1'b1;
    end
  end

  always @(posedge clkb0 or negedge rstn) begin
    if(!rstn) ren0_reg <= 1'b0;
    else      ren0_reg <= ren0;
  end

  always @(posedge clkb0 or negedge rstn) begin
    if(!rstn) raddr_reg <= 11'h000;
    else if(ren0_reg == 1'b0 && ren0 == 1'b1) begin
      if(raddr_reg == 11'd2047) raddr_reg <= 11'd0;
      else                      raddr_reg <= raddr_reg + 1'b1;
    end
  end

  blk_mem_gen_0 u_blk_mem_gen_0
  (
    .clka   ( clka0       ),
    .ena    ( wen0        ),
    .wea    ( wen0        ),
    .addra  ( waddr0      ),
    .dina   ( wdata0      ),
    .douta  ( wdata       ),
    .rsta   ( rsta        ),

    .enb    ( ren0        ),
    .clkb   ( clkb0       ),
    .addrb  ( raddr_reg   ),
    .doutb  ( rdata0      ),
    .rstb   ( rsta        )
  );
endmodule 