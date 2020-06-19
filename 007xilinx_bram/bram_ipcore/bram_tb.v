`timescale 1ns/1ps

module bram_tb;

parameter PERIOD  = 8;

reg clka = 0;
reg rsta = 0;
reg wea  = 0;
reg [5:0] addra = 'd0;
reg [7:0] dina  = 'd3;

reg clkb = 0;
reg rstb = 0;
reg web  = 0;
reg [5:0] addrb = 'd0;
wire [7:0] doutb;

initial forever #(PERIOD/2)  clka=~clka;
initial forever #(PERIOD/2)  clkb=~clkb;

initial begin
  #(PERIOD*5);
  rsta = 1;
  rstb = 1;
end

reg [6:0] weareg;

always @ (posedge clka or negedge rsta) begin
  if(!rsta)
    weareg <= 'd1;
  else
    weareg <= {weareg[5:0], weareg[6]};
end

always @ (posedge clka or negedge rsta) begin
  if(!rsta)
    wea <= 0;
  else if(weareg[6])
    wea <= 1;
  else
    wea <= 0;
end

always @ (posedge clka or negedge rsta) begin
  if(!rsta)
    addra <= 'd0;
  else if(weareg[6] & (addra == 'd59))
    addra <= addra;
  else if(weareg[6])
    addra <= addra + 1;
  else
    addra <= addra;
end

always @ (posedge clka or negedge rsta) begin
  if(!rsta)
    dina  <= 'd3;
  else if(weareg[6] & (addra == 'd59))
    dina <= dina;
  else if(weareg[6])
    dina <= dina + 2;
  else
    dina <= dina;
end

reg [8:0] webreg;

always @ (posedge clkb or negedge rstb) begin
  if(!rstb)
    webreg <= 'd1;
  else
    webreg <= {webreg[7:0], webreg[8]};
end

always @ (posedge clkb or negedge rstb) begin
  if(!rstb)
    web <= 0;
  else if(webreg[8])
    web <= 1;
  else
    web <= 0;
end

always @ (posedge clkb or negedge rstb) begin
  if(!rstb)
    addrb <= 'd0;
  else if(webreg[8] & (addrb == 'd59))
    addrb <= 'd0;
  else if(webreg[8])
    addrb <= addrb + 1;
  else
    addrb <= addrb;
end


bram_8bit_60 bram_8bit_60_inst_0
(
  .clka   (clka),
  .rsta   (rsta),
  .wea    (wea), 
  .addra  (addra),
  .dina   (dina),

  .clkb   (clkb),
  .rstb   (rstb),
  .web    (web),
  .addrb  (addrb),
  .doutb  (doutbs)
);

endmodule