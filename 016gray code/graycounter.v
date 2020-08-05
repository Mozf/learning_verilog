module graycounter
(
clk,
reset_n,
gray_out
);

parameter data_width = 4;

input clk;
input reset_n;
// input [data_width-1:0] gray_in;
output [data_width-1:0] gray_out;

//格雷码转二进制
wire [data_width-1:0] bin_out;

gray2bin gray2bin_1
(
  .gray_in (gray_wire),
  .bin_out (bin_out)
);

//二进制加一
wire [data_width-1:0] bin_add_wire;
assign bin_add_wire = bin_out + 1'b1;

//二进制转格雷码
wire [data_width-1:0] gray_wire;
reg [data_width-1:0] gray_out;
bin2gray bin2gray_1
(
  .bin_in (bin_add_wire),
  .gray_out (gray_wire)
);

always @(posedge clk or negedge reset_n) begin
if(reset_n == 1'b0)
  gray_out <= {data_width{1'b0}};
else
  gray_out <= gray_wire;
end
endmodule