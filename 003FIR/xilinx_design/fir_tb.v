//==============================================================================
// Module name: fir_tb
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2019.5.5
// Description: read mem.txt and run the fir
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
`timescale 1ns/1ns

module fir_tb;

  reg           clk;
  reg           rstn;

  reg   [7:0]   data_mem  [4095:0];
  reg   [11:0]  addr;
  wire  [7:0]   data;
  wire  [17:0]  dout;

  initial begin
    clk   = 1'b0;
    rstn  = 1'b0;

    #20 rstn = 1'b1;
    //文件地址按需求更�?
    $readmemh("F:/gitworkspace/verilog/FIR/mem.txt",data_mem);
    
    #500 $stop;
  end

  always #1 clk = ~clk;

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      addr <= 11'd0;
    end
    else begin
      addr <= addr + 1'b1;
    end
  end

  assign data = data_mem[addr];

  fir fir
  (
    .clk  ( clk   ),
    .rstn ( rstn  ),

    .din  ( data  ),
    .dout ( dout  )
  );

endmodule