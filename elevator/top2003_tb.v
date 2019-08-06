`timescale 1ns/1ns

module top2003_tb;

  reg        a;
  wire [3:0] INgogo;
  wire       led0;
  wire       led1;
  wire       led2;

  initial begin
    a <= 1'b0;

    #500 a = 1'b1;
    #50 a = 1'b0;
    #50 a = 1'b1;
    #50 a = 1'b0;
    #50 a = 1'b1;
    #50 a = 1'b0;
    
    #100000 $stop;
  end

  top2003 inst_top2003
  (
    .a(a),
    .INgogo(INgogo),
    .led0(led0),
    .led1(led1),
    .led2(led2)
  );
endmodule