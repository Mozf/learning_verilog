`timescale  1ns / 1ps   

module randomdata_tb;   

// randomdata Parameters
parameter PERIOD  = 10; 


// randomdata Inputs    
reg   clk                                  = 0 ;
reg   rstn                                 = 0 ;
reg   [15 : 0]  din                        = 0 ;

// randomdata Outputs
wire  [15 : 0]  data                       ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

randomdata  u_randomdata (
    .clk                     ( clk            ),
    .rstn                    ( rstn           ),
    .din                     ( din   [15 : 0] ),

    .data                    ( data  [15 : 0] )
);

initial
begin
  #(PERIOD*200);
  $stop;
end

always @ (posedge clk or negedge rstn) begin
  if(!rstn)
    din <= 'd0; 
  else
    din <= $random%1234;
end

endmodule