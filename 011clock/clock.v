module clock
(
  input clk100M,
  input clk200M,
  input rstn,
  output reg clk
);

always @ (posedge clk200M or negedge rstn) begin
  if(!rstn)
    clk <= 0;
  else if(clk100M)
    clk <= 1;
  else
    clk <= 0;
end

endmodule