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

wire rstawire = ~rsta;
wire rstbwire = ~rstb;

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
  else if(weareg[3])
    wea <= 1;
  else
    wea <= 0;
end

always @ (posedge clka or negedge rsta) begin
  if(!rsta)
    addra <= 'd0;
  else if(wea & (addra == 'd60))
    addra <= addra;
  else if(wea)
    addra <= addra + 1;
  else
    addra <= addra;
end

always @ (posedge clka or negedge rsta) begin
  if(!rsta)
    dina  <= 'd3;
  else if(weareg[6] & (addra == 'd60))
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
  else if(addra >= 'd59)
    webreg <= {webreg[7:0], webreg[8]};
  else
    webreg <= webreg;
end

always @ (posedge clkb or negedge rstb) begin
  if(!rstb)
    web <= 0;
  else if(webreg[8])
    web <= 1;
  else
    web <= 0;
end

reg         cnt2;
reg [5 : 0] cnt50;
reg [3 : 0] cnt09;
reg [3 : 0] cnt19;
reg         loop;

always @ (posedge clkb or negedge rstb) begin
  if(!rstb)
    cnt2 <= 0;
  else if(web)
    cnt2 <= cnt2 + 1;
  else
    cnt2 <= cnt2;
end

always @ (posedge clkb or negedge rstb) begin
  if(!rstb)
    cnt50 <= 'd0;
  else if(web & (!cnt2) & (cnt50=='d50))
    cnt50 <= 'd0;
  else if(web & (!cnt2))
    cnt50 <= cnt50 + 'd10;
  else
    cnt50 <= cnt50;
end

always @ (posedge clkb or negedge rstb) begin
  if(!rstb)
    loop <= 0;
  else if(cnt50=='d50)
    loop <= 1;
  else
    loop <= 0;
end

always @ (posedge clkb or negedge rstb) begin
  if(!rstb)
    cnt09 <= 'd0;
  else if(web & (!cnt2) & (cnt09=='d8) & (cnt50=='d50))
    cnt09 <= 'd0;
  else if(web & (!cnt2) & loop)
    cnt09 <= cnt09 + 'd2;
  else
    cnt09 <= cnt09;
end

always @ (posedge clkb or negedge rstb) begin
  if(!rstb)
    cnt19 <= 'd1;
  else if(web & (!cnt2) & (cnt19=='d9) & (cnt50=='d50))
    cnt19 <= 'd1;
  else if(web & (!cnt2) & loop)
    cnt19 <= cnt19 + 'd2;
  else
    cnt19 <= cnt19;
end

always @ (posedge clkb or negedge rstb) begin
  if(!rstb)
    addrb <= 'd0;
  else if(web & cnt2)
    addrb <= cnt09 + cnt50;
  else if(web & (!cnt2))
    addrb <= cnt19 + cnt50;  
  else
    addrb <= addrb;
end

bram_8bit_60 bram_8bit_60_inst_0
(
  .clka   (clka),
  .wea    (wea), 
  .addra  (addra),
  .dina   (dina),

  .clkb   (clkb),
  .rstb   (rstbwire),
  .addrb  (addrb),
  .doutb  (doutb)
);

endmodule