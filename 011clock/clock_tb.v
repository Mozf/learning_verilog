`timescale  1ns / 1ps

module clock_tb;

// clock Parameters
parameter PERIOD  = 10;
parameter PERIOD250  = 5;

// clock Inputs
reg   clk100M                              = 0 ;
reg   clk250M                              = 0 ;
reg   rstn                                 = 0 ;

// clock Outputs
wire  clk                                  ;    


initial
begin
    forever #(PERIOD/2)  clk100M=~clk100M;
end

initial
begin
    forever #(PERIOD250/2)  clk250M=~clk250M;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

clock  u_clock (
    .clk100M                 ( clk100M   ),
    .clk250M                 ( clk250M   ),
    .rstn                    ( rstn      ),

    .clk                     ( clk       )
);

initial
begin
  #(PERIOD*500)
  $stop;
end

endmodule