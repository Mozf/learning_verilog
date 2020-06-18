module clock
(
  input clk100M,
  input clk250M,
  input rstn,
  output reg clk
);

always @ (posedge clk250M or negedge rstn) begin
  if(!rstn)
    clk <= 0;
  else if(clk100M)
    clk <= 1;
  else
    clk <= 0;
end

endmodule