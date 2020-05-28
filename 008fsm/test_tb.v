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
  wire c1;
  wire d1;
  wire e1;
  wire h1;

  initial begin
    clk = 1'b0;
    rstn = 1'b0;
    a = 1'b0;
    b = 1'b0;
    f = 1'b0;
    g = 1'b0;

    #5 rstn = 1'b1;
    #4 a = 1'b1;
    #6 b = 1'b1;
    #2 b = 1'b0;
    #6 f = 1'b1;
    #2 f = 1'b0;
    #10 $stop;
  end

  always @ (posedge clk or negedge rstn) begin
    if(!rstn)
      g <= 0;
    else if(e)
      g <= 1;
    else
      g <= 0;
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

  b b_inst
  (
    .clk ( clk ),
    .rstn ( rstn),
    .a ( a),
    .b ( b),
    .c ( c1),
    .d ( d1),
    .e ( e1),
    .f ( f),
    .g ( g),
    .h ( h1)
  );
endmodule