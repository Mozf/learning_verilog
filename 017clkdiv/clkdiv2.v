module clkdiv2
(
  input clk,
  input rstn,
  output clkout
);

reg d1;
reg d2;
reg d3;
reg d4;

wire in;

always @ (posedge clk or negedge rstn) begin
  if(!rstn)
    d1 <= 0; 
  else
    d1 <= in;
end

always @ (posedge clk or negedge rstn) begin
  if(!rstn)
    d2 <= 0; 
  else
    d2 <= d1;
end

always @ (posedge clk or negedge rstn) begin
  if(!rstn)
    d3 <= 0; 
  else
    d3 <= d2;
end

always @ (posedge clk or negedge rstn) begin
  if(!rstn)
    d4 <= 0; 
  else
    d4 <= d3;
end

// assign in = ((~d1)&(~d2)&(~d3)&(~d4) | ((~d1)&(d2)&(~d3)&(~d4)) | ((d1)&(~d2)&(d3)&(~d4)) | ((d1)&(d2)&(~d3)&(d4)));
assign in = (((~d1)&(~d3)&(~d4)) | ((d2)&(~d3)) | ((d1)&(~d2)&(d3)) | ((d1)&(d4)));
// assign clkout = (((~d1)&(~d2)&(~d3)&(~d4)) | ((d1)&(~d2)&(~d3)&(~d4)) | ((d1)&(d2)&(~d3)&(d4)&clk) | ((d1)&(~d2)&(d3)&(~d4)) | ((~d1)&(d2)&(~d3)&(~d4)));
assign clkout = (((~d3)&(~d4)) | ((d1)&(~d2)) | ((~d4)&(~d2)) | clk);// | ((d1)&(~d3)&clk) | ((d1)&(d4)&(clk))
//0
// assign clkout = (~((d4&clk) | (d1&d2&clk)));

endmodule