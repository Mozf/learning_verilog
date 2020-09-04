`timescale 1ns/1ps
module tb_clk;

reg clk;
reg rstn;
wire clkout;

initial begin
  clk = 0;
  rstn = 0; 
  #20 rstn = 1;
  #1000 $stop;
end

always #2 clk = ~clk;


clkdiv2 clkdiv2_inst_0
(
  .clk    ( clk     ),
  .rstn   ( rstn    ),
  .clkout ( clkout  )
);

endmodule