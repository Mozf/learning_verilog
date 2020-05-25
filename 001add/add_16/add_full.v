module add_full(
  output  c_out,
  output  sum,
  
  input a,
  input b,
  input c_in
);

  wire w1;
  wire w2;
  wire w3;

  add_half M1(w2,w1,a,b);
  add_half M2(w3,sum,c_in,w1);
  or       U1(c_out,w2,w3);

endmodule