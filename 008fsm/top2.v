//==============================================================================
// Module name: top2.v
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2020.5.25
// Description: 现在有4个数，两两轮流写入并相加之后，延迟两个时钟，输出
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       :
// Message    :
//==============================================================================
module top2.v
(
  input clk,
  input rstn,

  output inready,
  input  invalid,
  output outvalid,
  input  outready,
  input  [7:0] dina,
  input  [7:0] dinb,

  output reg [7:0] dout,
);
  
  wire preadd;
  reg enadd;

  always @ (posedge clk or negedge rstn) begin
    if(!rstn)
      enadd <= 1'b0;
    else if(preadd) 
      enadd <= 1'b1;
    else
      enadd <= 1'b0;
  end

  always @ (posedge clk or negedge rstn) begin
    if(!rstn) 
      dout <= 8'd0;
    else if(preadd)
      dout <= dina + dinb;
    else
      dout <= dout;
  end




endmodule