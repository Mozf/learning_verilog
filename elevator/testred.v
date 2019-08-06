module testred
(
  input  IO13,
  input  IO12,
  input  IO11,
  input  IO10,
  input  IO9,
  input  IO8,
  output LED0,
  output LED1,
  output LED2,
  output LED3
);

  assign LED0 = IO8 | IO9;
  assign LED1 = IO10 | IO11;
  assign LED2 = IO12 | IO13;
  assign LED3 = 1'b1;
endmodule