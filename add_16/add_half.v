module add_half(
  output c_out,
  output sum,

  input  a,
  input  b
);

  xor U1(sum,a,b);
  and U2(c_out,a,b);

endmodule