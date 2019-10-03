`timescale 1ps/1ps

module tb_add;

reg [15:0]  a,b;
reg         c_in;

wire  [15:0]  sum;
wire          c_out;

initial begin
  a = 16'h0000;
  b = 16'h0000;
  c_in = 1'b0;

  #20;
  a = 16'ha23c;
  b = 16'hb3d5;
  c_in = 1'b0;

  #20;
  a = 16'hb3d5;
  b = 16'ha23c;
  c_in = 1'b0;

  #20;
  $stop;
end

add_rca_16 M1(c_out,sum[15:0],a[15:0],b[15:0],c_in);

endmodule