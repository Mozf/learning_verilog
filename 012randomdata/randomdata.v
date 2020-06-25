module randomdata
(
  input clk,
  input rstn,

  input      [15 : 0] din,
  output reg [15 : 0] data
);

  always @ (posedge clk or negedge rstn) begin
    if(!rstn)
      data <= 'd0; 
    else 
      data <= din;
  end

endmodule