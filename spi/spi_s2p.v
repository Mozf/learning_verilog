//==============================================================================
// Module name: spi_s2p
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2018.12.12
// Description: serial to parallel  
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module spi_s2p
#(
  parameter DATAWIDTH = 8
)
(
  input                       clk,
  input                       rstn,

  input        [1:0]          cnt,

  input                       s2p_enable,

  input                       data_in,

  input                       mors,

  output reg                  wen1,
  output reg  [DATAWIDTH-1:0] wdata1
);

  reg         data_vaild;
  reg         s2p_enable_reg;
  reg  [15:0] databuff;

  always @(posedge clk or negedge rstn) begin
    if(!rstn) s2p_enable_reg <= 1'b0;
    else      s2p_enable_reg <= s2p_enable;
  end

  always @(posedge clk or negedge rstn) begin
    if(!rstn) 
      wen1 <= 1'b0;
    else if({s2p_enable_reg,s2p_enable,data_vaild} == 3'b101)
      wen1 <= 1'b1;
    else if({s2p_enable_reg,s2p_enable,data_vaild} == 3'b011)
      wen1 <= 1'b0;
  end

  always @(posedge clk or negedge rstn) begin
    if(!rstn) 
      databuff <= 16'h0000;
    else if({s2p_enable,cnt} == 3'b110)
      databuff <= {databuff[14:0],data_in};
  end   

  always @(posedge clk or negedge rstn) begin
    if(!rstn) 
      data_vaild <= 1'b0;
    else if(databuff == 16'h55aa)
      data_vaild <= 1'b1;
    else if(databuff == 16'haa55)
      data_vaild <= 1'b0;
  end

  always @(posedge clk or negedge rstn) begin
    if(!rstn)
      wdata1 <= 8'h00;
    else if({s2p_enable,data_vaild,cnt} == 4'b1110)
      wdata1 <= {wdata1[6:0],data_in};
  end

endmodule