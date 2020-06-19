`timescale  1ns / 1ps

module clock_tb;

// clock Parameters
parameter PERIOD  = 10;
parameter PERIOD250  = 5;

// clock Inputs
reg   clk100M                              = 0 ;
reg   clk200M                              = 0 ;
reg   rstn                                 = 0 ;

// clock Outputs
wire  clk                                  ;    


initial
begin
    forever #(PERIOD/2)  clk100M=~clk100M;
end

initial
begin
    forever #(PERIOD250/2)  clk200M=~clk200M;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

clock  u_clock (
    .clk100M                 ( clk100M   ),
    .clk200M                 ( clk200M   ),
    .rstn                    ( rstn      ),

    .clk                     ( clk       )
);

initial
begin
  #(PERIOD*500)
  $stop;
end

initial
begin
$dumpfile("clock.vcd");
$dumpvars(0, clock_tb);

#1500;
$finish;
end

endmodule