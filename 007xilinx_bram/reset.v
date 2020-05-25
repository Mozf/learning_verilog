module reset
(
  input      clk,
  input      sysrstn,
  output reg rstn
);
  reg rstn1;

  always@(posedge clk or negedge sysrstn) begin
    if(!sysrstn)
      rstn1 <= 1'b0;
    else
      rstn1 <= 1'b1;
  end

  always@(posedge clk or negedge sysrstn) begin
    if(!sysrstn)
      rstn <= 1'b0;
    else
      rstn <= rstn1;
  end

endmodule