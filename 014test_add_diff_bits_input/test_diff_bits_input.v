`timescale 1ns/1ps

module test_diff_bits_input;

reg [7:0] A = 'd0;
reg [8:0] B = 'b1111_11111;
reg clk = 'd0;
wire [9:0] S;
wire [16:0] P;

always #1 clk = ~clk;

always @(posedge clk) begin
  A[7] <= A[7] + 1;
  A[6:0] <= A[6:0] + 1;
  B[8] <= B[8] + 1;
  B[7:0] <= B[7:0] - 2;
end

initial begin
  #100 $stop;
end


c_addsub_0 c_addsub_0
(
  .A(A),
  .B(B),
  .CLK(clk),
  .S(S)
);

mult_gen_0 mult_gen_0
(
  .A(A),
  .B(B),
  .CLK(clk),
  .P(P)
);
endmodule