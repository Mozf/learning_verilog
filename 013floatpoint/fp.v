`timescale 1ns/1ps

module fp;

  parameter PERIOD  = 10; 

  reg   clk                                  = 0 ;
  reg  rstn = 0;

  reg avalid;
  wire aready;
  reg [31 : 0] adata;
  reg bvalid;
  wire bready;
  reg [31 : 0] bdata;
  wire ovalid;
  reg oready;
  wire [31 : 0] odata;

  initial begin
    forever #(PERIOD/2)  clk=~clk;
  end

  initial begin
    #(PERIOD*2);
    rstn = 1;
    #(PERIOD*200);
    $stop;
  end

  reg [3 : 0] cnt4;

  always @ (posedge clk or negedge rstn) begin
    if(!rstn)
      cnt4 <= 'd1;    
    else
      cnt4 <= {cnt4[2:0], cnt4[3]};
  end

  always @ (posedge clk or negedge rstn) begin
    if(!rstn)
      avalid <= 0;
    else if(cnt4[2] & aready)
      avalid <= 1;
    else
      avalid <= 0;
  end

  always @ (posedge clk or negedge rstn) begin
    if(!rstn)
      bvalid <= 0;
    else if(cnt4[2] & bready)
      bvalid <= 1;
    else
      bvalid <= 0;
  end

  always @ (posedge clk or negedge rstn) begin
    if(!rstn)
      adata <= 'd0;
    else if(avalid)
      adata <= $random;
  end

  always @ (posedge clk or negedge rstn) begin
    if(!rstn)
      bdata <= 'd0;
    else if(avalid)
      bdata <= $random;
  end

  always @ (posedge clk or negedge rstn) begin
    if(!rstn)
      oready <= 0; 
    else if(ovalid)
      oready <= 1;
    else
      oready <= 0;
  end

  floating_point_0 floating_point_0_inst
  (
    .aclk  ( clk ),
    .s_axis_a_tvalid ( avalid ),
    .s_axis_a_tready( aready ),
    .s_axis_a_tdata ( adata ),
    .s_axis_b_tvalid ( bvalid ),
    .s_axis_b_tready ( bready ),
    .s_axis_b_tdata ( bdata ),
    .m_axis_result_tvalid ( ovalid ),
    .m_axis_result_tready ( oready ),
    .m_axis_result_tdata( odata )
  );
endmodule