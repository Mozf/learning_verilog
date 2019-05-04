//==============================================================================
// Module name: spi_top
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2018.12.12
// Description: the top level of spi 
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module spi_top
#(
  parameter DATAWIDTH = 8,
  parameter ADDRWIDTH = 11
)
(
  input                       clk_out1,
  input                       resetn,
  input                       rstn,

  input                       cs,
  input                       mors,

  input                       wen,
  input       [ADDRWIDTH-1:0] waddr,
  input       [DATAWIDTH-1:0] wdata,

  input                       ren,
  input       [ADDRWIDTH-1:0] raddr,
  output                      not_empty,
  output wire [DATAWIDTH-1:0] rdata,

  inout                       SCLK,
  inout                       MOSI,
  inout                       MISO,
  inout                       CS
);

  //wire                 clk_out1;
  wire                 ren0;
  wire [DATAWIDTH-1:0] rdata0;
  wire                 not_empty0;
  wire                 p2s_enable;
  wire                 s2p_enable;
  wire [1:0]           cnt;
  wire                 wen1;
  wire [DATAWIDTH-1:0] wdata1;

  //as a inout, I define that the input is a reg and the output is wire.
  //the enable of port inout is mors.
  wire                 data_out;
  reg                  data_in;
  wire                 cs_out;
  reg                  cs_in;
  wire                 sclk_out;
  reg                  sclk_in;

  always @(posedge clk_out1 or negedge rstn) begin
    if(!rstn) 
      data_in <= 1'b0;
    else if(mors == 1'b1)
      data_in <= MISO;
    else 
      data_in <= MOSI;
  end

  always @(posedge clk_out1 or negedge rstn) begin
    if(!rstn) cs_in <= 1'b0;
    else      cs_in <= CS;
  end

  always @(posedge clk_out1 or negedge rstn) begin
    if(!rstn) sclk_in <= 1'b0;
    else      sclk_in <= SCLK;
  end

  assign MOSI = (mors == 1'b1) ? data_out : 1'bz;
  assign MISO = (mors == 1'b0) ? data_out : 1'bz;
  assign CS   = (mors == 1'b1) ? cs_out   : 1'bz;
  assign SCLK = (mors == 1'b1) ? sclk_out : 1'bz;

  assign s2p_enable = cs_in | cs_out;
  assign p2s_enable = cs_in | cs_out;

/*
  clk_wiz_0 inst_clk_wiz_0
  (
    .clk_in1    ( clkin1      ),
    .resetn     ( resetn      ),
    
    .clk_out1   ( clk_out1    )
  );
*/

  spi_xil_bram_out inst_spi_xil_bram_out
  (
    .clka0      ( clk_out1    ),
    .clkb0      ( clk_out1    ),
    .rstn       ( rstn        ),

    .wen0       ( wen         ),
    .wdata0     ( wdata       ),
    .waddr0     ( waddr       ),

    .ren0       ( ren0        ),
    .rdata0     ( rdata0      ),
    .not_empty0 ( not_empty0  )
  );

  spi_p2s inst_spi_p2s
  (
    .clk        ( clk_out1    ),
    .rstn       ( rstn        ),

    .p2s_enable ( p2s_enable  ),

    .cnt        ( cnt         ),

    .rdata0     ( rdata0      ),
    .not_empty0 ( not_empty0  ),
    .ren0       ( ren0        ),

    .data_out   (data_out     )
  );

  spi_fsm inst_spi_fsm
  (
    .clk        ( clk_out1    ),
    .rstn       ( rstn        ),

    .cs         ( cs          ),
    .mors       ( mors        ),

    .cs_in      ( cs_in       ),
    .cs_out     ( cs_out      ),

    .cnt        ( cnt         )
  );

  spi_counter inst_spi_counter
  (
    .clk        ( clk_out1    ),
    .rstn       ( rstn        ),

    .cs         ( cs          ),
    .mors       ( mors        ),

    .cnt        ( cnt         ),

    .sclk_in    ( sclk_in     ),
    .sclk_out   ( sclk_out    )
  );

  spi_s2p inst_spi_s2p
  (
    .clk        ( clk_out1    ),
    .rstn       ( rstn        ),

    .cnt        ( cnt         ),

    .s2p_enable ( s2p_enable  ),

    .data_in    ( data_in     ),

    .mors       ( mors        ),

    .wen1       ( wen1        ),
    .wdata1     ( wdata1      )
  );

  spi_xil_bram_in inst_spi_xil_bram_in
  (
    .clka1      ( clk_out1    ),
    .clkb1      ( clk_out1    ),
    .rstn       ( rstn        ),

    .wen1       ( wen1        ),
    .wdata1     ( wdata1      ),

    .ren1       ( ren         ),
    .raddr1     ( raddr       ),
    .rdata1     ( rdata       ),
    .not_empty1 ( not_empty   )
  );

endmodule