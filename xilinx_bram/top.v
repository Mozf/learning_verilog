//==============================================================================
// Module name: top
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 
// Description: 
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module top
(
  input         sysclk,
  inout [14:0]  DDR_addr,
  inout [2:0]   DDR_ba,
  inout         DDR_cas_n,
  inout         DDR_ck_n,
  inout         DDR_ck_p,
  inout         DDR_cke,
  inout         DDR_cs_n,
  inout [3:0]   DDR_dm,
  inout [31:0]  DDR_dq,
  inout [3:0]   DDR_dqs_n,
  inout [3:0]   DDR_dqs_p,
  inout         DDR_odt,
  inout         DDR_ras_n,
  inout         DDR_reset_n,
  inout         DDR_we_n,
  inout         FIXED_IO_ddr_vrn,
  inout         FIXED_IO_ddr_vrp,
  inout [53:0]  FIXED_IO_mio,
  inout         FIXED_IO_ps_clk,
  inout         FIXED_IO_ps_porb,
  inout         FIXED_IO_ps_srstb,
  input         sysrstn,

  output        led0
);

  /////////////////////////////////////////////////////////////////////////////////
  //assign BRAM_PORTB_0_din = {dout + 2'b11,dout + 2'b10,dout + 1'b1,dout};
  //dout <= dout + 1'b1;
  //rstn = 0 时，
  //add = 0 的dout = 03020100；

  //rstn = 1 时，
  //add = 0 的dout = 06050403，
  //add = 1 的dout = 0a090807，
  //add = 2 的dout = 0e0d0c0b 
  /////////////////////////////////////////////////////////////////////////////////
  // wire         clk;
  // wire         rstn;
  // reg  [7:0]   dout;
  // wire [31:0]  BRAM_PORTB_0_din;
  // wire         BRAM_PORTB_0_rst;
  // wire         BRAM_PORTB_0_en;
  // reg  [3:0]   BRAM_PORTB_0_we;
  // reg  [31:0]  BRAM_PORTB_0_addr;
  // reg  [1:0]   a;

  // assign BRAM_PORTB_0_din = {dout + 2'b11,dout + 2'b10,dout + 1'b1,dout};
  // assign led0 = (rstn) ? 1'b1 : 1'b0;
  // assign BRAM_PORTB_0_rst = ~rstn;
  // assign BRAM_PORTB_0_en = 1'b1;


  // always@(posedge clk or negedge rstn) begin
  //   if(!rstn) begin
  //     BRAM_PORTB_0_addr <= 32'd0;
  //     a <= 2'b00;
  //     dout <= 8'h00;
  //     BRAM_PORTB_0_we <= 4'b1111;
  //   end
  //   else if(a == 2'b10) begin
  //     BRAM_PORTB_0_addr <= BRAM_PORTB_0_addr + 1'b1;  
  //     dout <= dout + 1'b1;
  //     BRAM_PORTB_0_we <= 4'b1111;
  //     a <= 2'b00;
  //   end
  //   else begin
  //     a <= a + 1'b1;
  //   end
  // end

  wire         clk;
  wire         rstn;
  reg  [31:0]  dout;
  //wire [31:0]  BRAM_PORTB_0_din;
  wire         BRAM_PORTB_0_rst;
  wire         BRAM_PORTB_0_en;
  wire [3:0]   BRAM_PORTB_0_we;
  reg  [31:0]  BRAM_PORTB_0_addr;
  reg  [2:0]   a;

  //assign BRAM_PORTB_0_din = dout;
  assign led0 = (rstn) ? 1'b1 : 1'b0;
  assign BRAM_PORTB_0_rst = ~rstn;
  assign BRAM_PORTB_0_en = 1'b1;
  assign BRAM_PORTB_0_we = 4'b1111;

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      BRAM_PORTB_0_addr <= 32'd0;
      a <= 3'b000;
      dout <= 32'd0;
    end
    else if(BRAM_PORTB_0_addr <= 32'd24) begin
      if(a == 3'b001) begin
        BRAM_PORTB_0_addr <= BRAM_PORTB_0_addr + 3'd4;  
        a <= a + 1'b1;
      end
      else if(a == 3'b111) begin
        dout <= dout + 1'b1;
        a <= a + 1'b1;
      end
      else begin
        a <= a + 1'b1;
      end
    end
    else if(BRAM_PORTB_0_addr <= 32'd60) begin
      BRAM_PORTB_0_addr <= BRAM_PORTB_0_addr + 3'd4; 
      dout <= dout;
    end
    else begin
      BRAM_PORTB_0_addr <= BRAM_PORTB_0_addr;
    end
  end

  design_1_wrapper design_1_wrapper_1
  ( 
    .BRAM_PORTB_0_addr      ( BRAM_PORTB_0_addr ),
    .BRAM_PORTB_0_clk       ( clk               ),
    .BRAM_PORTB_0_din       ( dout              ),
    .BRAM_PORTB_0_en        ( BRAM_PORTB_0_en   ),
    .BRAM_PORTB_0_rst       ( BRAM_PORTB_0_rst  ),
    .BRAM_PORTB_0_we        ( BRAM_PORTB_0_we   ),
    .DDR_addr               ( DDR_addr          ),
    .DDR_ba                 ( DDR_ba            ),
    .DDR_cas_n              ( DDR_cas_n         ),
    .DDR_ck_n               ( DDR_ck_n          ),
    .DDR_ck_p               ( DDR_ck_p          ),
    .DDR_cke                ( DDR_cke           ),
    .DDR_cs_n               ( DDR_cs_n          ),
    .DDR_dm                 ( DDR_dm            ),
    .DDR_dq                 ( DDR_dq            ),
    .DDR_dqs_n              ( DDR_dqs_n         ),
    .DDR_dqs_p              ( DDR_dqs_p         ),
    .DDR_odt                ( DDR_odt           ),
    .DDR_ras_n              ( DDR_ras_n         ),
    .DDR_reset_n            ( DDR_reset_n       ),
    .DDR_we_n               ( DDR_we_n          ),
    .FIXED_IO_ddr_vrn       ( FIXED_IO_ddr_vrn  ),
    .FIXED_IO_ddr_vrp       ( FIXED_IO_ddr_vrp  ),
    .FIXED_IO_mio           ( FIXED_IO_mio      ),
    .FIXED_IO_ps_clk        ( FIXED_IO_ps_clk   ),
    .FIXED_IO_ps_porb       ( FIXED_IO_ps_porb  ),
    .FIXED_IO_ps_srstb      ( FIXED_IO_ps_srstb )
  );

  clk_wiz_0 clk_wiz_0_inst_0
  (
    .clk_out1     ( clk       ),
    .clk_in1      ( sysclk    )
  );

  reset reset_inst_0
  (
    .clk          ( clk       ),
    .sysrstn      ( sysrstn   ),
    .rstn         ( rstn      )
  );
endmodule
