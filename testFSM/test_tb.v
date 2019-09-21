module test_tb;
  reg clk;
  reg rstn;
  reg a;
  reg b;
  reg f;
  reg g;
  wire c;
  wire d;
  wire e;
  wire h;

  initial begin
    clk = 1'b0;
    rstn = 1'b0;
    a = 1'b0;
    b = 1'b0;
    f = 1'b0;
    g = 1'b0;

    #5 rstn = 1'b1;
    #5 a = 1'b1;
    #5 a = 1'b0;
    #5 b = 1'b1;
    #5 f = 1'b1;
    b = 1'b0;
    #5 g = 1'b1;
    #5 rstn = 1'b0;
    #10 $stop;
  end

  always #1 clk = ~clk;

  a a_inst
  (
    .clk ( clk ),
    .rstn ( rstn),
    .a ( a),
    .b ( b),
    .c ( c),
    .d ( d),
    .e ( e),
    .f ( f),
    .g ( g),
    .h ( h)
  );
endmodule