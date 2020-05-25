//==============================================================================
// Module name: spi_counter
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2018.12.8
// Description: a counter of spi
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module spi_counter
#(
  parameter RSTN = 2'b00,
  parameter SCNT = 2'b01,
  parameter MCNT = 2'b10
)
(
  input             clk,
  input             rstn,
  
  input             cs,
  input             mors,

  output reg  [1:0] cnt,

  input             sclk_in,
  output reg        sclk_out
);

  reg  [2:0] sclk_in_reg;
  reg  [1:0] current_state;
  reg  [1:0] next_state;

  always @(posedge clk or negedge rstn) begin
    if(!rstn) 
      sclk_in_reg <= 3'b000;
    else if(mors == 1'b0)      
      sclk_in_reg <= {sclk_in_reg[1:0],sclk_in};
    else 
      sclk_in_reg <= 1'b0;
  end

//as a master
  always @(posedge clk or negedge rstn) begin
    if(!rstn)
      sclk_out <= 1'b0;
    else if({mors,cs,cnt[0]} == 3'b110)
      sclk_out <= ~sclk_out;
  end

  always @(posedge clk or negedge rstn) begin
    if(!rstn) cnt <= 2'b00;
    else if(mors == 1'b1) begin
      if(cnt == 2'b11) cnt <= 2'b00;
      else             cnt <= cnt + 1'b1;
    end
    else begin
      if(sclk_in_reg == 3'b000)
          cnt <= 2'b00;
      else if({sclk_in_reg[0],sclk_in} == 2'b01)
        cnt   <= 2'b00;
      else 
        cnt   <= cnt + 1'b1; 
    end
  end

/*
  always @(posedge clk or negedge rstn) begin
    if(!rstn) current_state <= RSTN;
    else      current_state <= next_state;
  end

  always @(posedge clk) begin
    case (next_state)
      SCNT: begin
        if(mors == 1'b1) 
          next_state = MCNT;
        else             
          next_state = SCNT;
      end
      MCNT: begin
        if(mors == 1'b0) 
          next_state = SCNT;
        else             
          next_state = MCNT;
      end
      default:next_state = SCNT;
    endcase
  end

  always @(posedge clk) begin
    case(current_state)
      RSTN: begin
        cnt <= 2'b00;
      end
      SCNT: begin
        if(SCLK_reg == 3'b000)
          cnt <= 2'b00;
        else if({SCLK_reg[0],SCLK} == 2'b01)
          cnt <= 2'b00;
        else 
          cnt <= cnt + 1'b1; 
      end
      MCNT: begin
        if(cnt == 2'b11) cnt <= 2'b00;
        else             cnt <= cnt + 1'b1;
      end
    endcase
  end*/
endmodule