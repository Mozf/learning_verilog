//==============================================================================
// Module name: spi_xil_bram_in
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2018.12.8
// Description: the bram of Xilinx is instantiated to receiving data
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module spi_xil_bram_in
#(
  parameter DATAWIDTH = 8,
  parameter ADDRWIDTH = 11
)
(
  input                       clka1,
  input                       clkb1,
  input                       rstn,

  input                       wen1,
  input       [DATAWIDTH-1:0] wdata1,

  input                       ren1,
  input       [ADDRWIDTH-1:0] raddr1,
  output wire [DATAWIDTH-1:0] rdata1,
  output wire                 not_empty1
);

  wire                 rstab;
  reg                  wen1_reg;
  reg  [ADDRWIDTH-1:0] waddr_reg;
  wire [DATAWIDTH-1:0] wdata1_wire;

  reg  [1:0]           ren1_reg;
  wire                 ren1_wire;
  wire [ADDRWIDTH-1:0] raddr1_wire;

  always @(posedge clka1 or negedge rstn) begin
    if(!rstn) begin
      wen1_reg  <=  1'b0;
      waddr_reg <= 11'h000; 
    end
    else begin
      wen1_reg  <= wen1;
      if(wen1_reg == 1'b0 && wen1 == 1'b1) begin
        if(waddr_reg == 2047) waddr_reg <= 11'h000;
        else                  waddr_reg <= waddr_reg + 1'b1;
      end
    end
  end

  always @(posedge clkb1 or negedge rstn) begin
    if(!rstn) ren1_reg <= 2'b00;
    else      ren1_reg <= {ren1_reg[0],ren1};
  end

  assign ren1_wire   = ( ren1_reg  == 2'b11       ) ?  1'b1   : 1'b0;
  assign raddr1_wire = ( rstn      == 1'b0        ) ? 11'h000 : raddr1;

  assign wdata1_wire = ( rstn      == 1'b0        ) ?  8'h00  : wdata1;

  assign not_empty1  = ( raddr1_wire == waddr_reg ) ?  1'b0   : 1'b1;
  assign rstab       = ( rstn      == 1'b0        ) ?  1'b1   : 1'b0;

  blk_mem_gen_1 u_blk_mem_gen_1
  (
    .clka   ( clka1       ),
    .ena    ( wen1_reg    ),
    .wea    ( wen1_reg    ),
    .addra  ( waddr_reg   ),
    .dina   ( wdata1_wire ),
    .rsta   ( rstab       ),

    .enb    ( ren1_wire   ),
    .clkb   ( clkb1       ),
    .addrb  ( raddr1_wire ),
    .doutb  ( rdata1      ),
    .rstb   ( rstab       )
  );

endmodule