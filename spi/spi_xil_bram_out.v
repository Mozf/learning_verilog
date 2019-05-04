//==============================================================================
// Module name: spi_xil_bram_out
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2018.12.8
// Description: the bram of Xilinx is instantiated to sending data
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================

module spi_xil_bram_out
#(
  parameter DATAWIDTH = 8,
  parameter ADDRWIDTH = 11
)
(
  input                       clka0,
  input                       clkb0,
  input                       rstn,

  //from outside
  input                       wen0,	
  input       [DATAWIDTH-1:0] wdata0,
  input       [ADDRWIDTH-1:0] waddr0,

  //to module spi_out 
  input                       ren0,
  output wire                 not_empty0,
  output wire [DATAWIDTH-1:0] rdata0
);
 
  reg  [1:0]            wen0_reg;
  wire                  wea_and_ena; 
  wire [ADDRWIDTH-1:0]  waddr0_wire;
  wire [DATAWIDTH-1:0]  wdata0_wire;
 
  reg                   ren0_reg;
  reg  [ADDRWIDTH-1:0]  raddr_reg;
  wire                  rstab;

  always @(posedge clka0 or negedge rstn) begin
    if(!rstn) wen0_reg <= 2'b11;
    else      wen0_reg <= {wen0_reg[0],wen0};
  end

  always @(posedge clkb0 or negedge rstn) begin
    if(!rstn) begin 
      raddr_reg <= 11'h000;
      ren0_reg  <=  1'b0;
    end
    else begin
      ren0_reg  <= ren0;
      if(ren0_reg == 1'b0 && ren0 == 1'b1) begin
        if(raddr_reg == 11'd2047) raddr_reg <= 11'h000;
        else                  raddr_reg <= raddr_reg + 1'b1;
      end
    end
  end

  assign waddr0_wire = ( rstn == 1'b0 || waddr0 == 11'd2047 ) ? 11'h000 : waddr0 + 1'b1;
  assign wdata0_wire = ( rstn      == 1'b0        ) ?  8'h00  : wdata0;
  assign wea_and_ena = ( wen0_reg  == 2'b11       ) ?  1'b1   : 1'b0;
  
  assign not_empty0  = ( raddr_reg == waddr0_wire ) ?  1'b0   : 1'b1;
  assign rstab       = ( rstn      == 1'b0        ) ?  1'b1   : 1'b0;

  blk_mem_gen_0 u_blk_mem_gen_0
  (
    .clka   ( clka0       ),
    .ena    ( wea_and_ena ),
    .wea    ( wea_and_ena ),
    .addra  ( waddr0_wire ),
    .dina   ( wdata0_wire ),
    .rsta   ( rstab       ),

    .enb    ( ren0        ),
    .clkb   ( clkb0       ),
    .addrb  ( raddr_reg   ),
    .doutb  ( rdata0      ),
    .rstb   ( rstab       )
  );
              
endmodule