module testred
(
  input  btn0,
  output led0,
  output led1
);

  assign led0 = 1'b0;
  assign led1 = btn0;
endmodule