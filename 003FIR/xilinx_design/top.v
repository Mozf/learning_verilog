module top
(
  input         button,
  output        light,

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
  inout         FIXED_IO_ps_srstb
);

  //wrapper
  //0 -> rom
  //1 -> fir
  wire         clk;
  wire         rstn;
  reg  [31:0]  bram0_ps_out_addr;
  wire [31:0]  bram0_ps_out_data;
  wire         en;
  wire [3:0]   bram_we;
  wire         rst;
  reg  [31:0]  bram1_ps_out_addr;
  wire [31:0]  bram1_ps_out_data;

  //rom
  reg  [3:0]   rom_addr_reg;
  wire [7:0]   rom_dout;

  //fir
  wire [17:0]  fir_out;
  
  wire [31:0]  BRAM0_dout;
  wire [31:0]  BRAM1_dout;

  //读取10个数据
  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      rom_addr_reg <= 4'd0;
    end
    else if(!en) begin
      rom_addr_reg <= rom_addr_reg;
    end
    else if(rom_addr_reg == 4'd9) begin
      rom_addr_reg <= 4'd0;
    end
    else begin
      rom_addr_reg <= rom_addr_reg + 1'b1;
    end
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      bram1_ps_out_addr <= 32'd0;
    end
    else if(!en) begin
      bram1_ps_out_addr <= bram1_ps_out_addr;
    end
    else begin
      bram1_ps_out_addr <= bram1_ps_out_addr + 1'b1;
    end
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      bram0_ps_out_addr <= 32'd0;
    end
    else if(!en) begin
      bram0_ps_out_addr <= bram0_ps_out_addr;
    end
    else begin
      bram0_ps_out_addr <= bram0_ps_out_addr + 1'b1;
    end
  end

  assign en      = 1'b1;
  assign bram_we = 1'b1;
  assign rst     = !rstn;
  assign bram0_ps_out_data = {24'd0,rom_dout[7:0]};
  assign bram1_ps_out_data = {15'd0,fir_out[17:0]};

  assign light = button;

  dsp_wrapper dsp_wrapper_inst
  (
    .BRAM0_addr       ( bram0_ps_out_addr ),
    .BRAM0_clk        ( clk               ),
    .BRAM0_din        ( bram0_ps_out_data ),
    .BRAM0_en         ( en                ),
    .BRAM0_rst        ( rst               ),
    .BRAM0_we         ( bram_we           ),
    .BRAM0_dout       ( BRAM0_dout        ),

    .BRAM1_addr       ( bram1_ps_out_addr ),
    .BRAM1_clk        ( clk               ),
    .BRAM1_din        ( bram1_ps_out_data ),
    .BRAM1_en         ( en                ),
    .BRAM1_rst        ( rst               ),
    .BRAM1_we         ( bram_we           ),
    .BRAM1_dout       ( BRAM1_dout        ),

    .DDR_addr         ( DDR_addr          ),
    .DDR_ba           ( DDR_ba            ),
    .DDR_cas_n        ( DDR_cas_n         ),
    .DDR_ck_n         ( DDR_ck_n          ),
    .DDR_ck_p         ( DDR_ck_p          ),
    .DDR_cke          ( DDR_cke           ),
    .DDR_cs_n         ( DDR_cs_n          ),
    .DDR_dm           ( DDR_dm            ),
    .DDR_dq           ( DDR_dq            ),
    .DDR_dqs_n        ( DDR_dqs_n         ),
    .DDR_dqs_p        ( DDR_dqs_p         ),
    .DDR_odt          ( DDR_odt           ),
    .DDR_ras_n        ( DDR_ras_n         ),
    .DDR_reset_n      ( DDR_reset_n       ),
    .DDR_we_n         ( DDR_we_n          ),
    .FIXED_IO_ddr_vrn ( FIXED_IO_ddr_vrn  ),
    .FIXED_IO_ddr_vrp ( FIXED_IO_ddr_vrp  ),
    .FIXED_IO_mio     ( FIXED_IO_mio      ),
    .FIXED_IO_ps_clk  ( FIXED_IO_ps_clk   ),
    .FIXED_IO_ps_porb ( FIXED_IO_ps_porb  ),
    .FIXED_IO_ps_srstb( FIXED_IO_ps_srstb ),

    .clk              ( clk               ),
    .rst              ( rstn              )
  );

  blk_mem_gen_0 blk_mem_gen_0
  (
    .clka   ( clk          ),
    .ena    ( en           ),
    .addra  ( rom_addr_reg ),
    .douta  ( rom_dout     )
  );

  fir ld_fir
  (
    .clk    ( clk               ),
    .rstn   ( rstn              ),
    .din    ( rom_dout          ),
    .dout   ( fir_out           )
  );
endmodule