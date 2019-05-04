//==============================================================================
// Module name: spi_p2s
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2018.12.8
// Description: parallel to serial
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module spi_p2s
#(
  parameter DATAWIDTH = 8,
  parameter RSTN      = 2'b00,
  parameter IDLE      = 2'b01,
  parameter TRANS     = 2'b10
  
)
(
  input                       clk,
  input                       rstn,

  input                       p2s_enable,

  input       [1:0]           cnt,

  input       [DATAWIDTH-1:0] rdata0,
  input                       not_empty0,
  output reg                  ren0,

  output reg                  data_out
);

  reg  [2:0]           i;
  reg  [DATAWIDTH-1:0] databuff;

  reg  [1:0]           current_state;
  reg  [1:0]           next_state;

  always @(posedge clk or negedge rstn) begin
    if(!rstn) current_state <= RSTN;
    else      current_state <= next_state;
  end

  always @(posedge clk) begin
    case (next_state)
      IDLE: begin
        if(p2s_enable == 1'b1)
          next_state = TRANS;
        else
          next_state = IDLE;
      end 
      TRANS: begin
        if(p2s_enable == 1'b0)
          next_state = IDLE;
        else
          next_state = TRANS;
      end
      default: next_state = IDLE;
    endcase
  end

  always @(posedge clk)begin
    case(current_state)
      RSTN: begin
        i         <=  3'd0;
        ren0      <=  1'b0;
        data_out  <=  1'b0;
        databuff  <=  8'h00;
      end
      IDLE: begin
        i         <= 3'd6;         
        data_out  <= databuff[7]; 
        databuff  <= rdata0;
        if(not_empty0 == 1'b1) ren0 <= 1'b1;
        else                   ren0 <= 1'b0;
      end
      TRANS: begin
        ren0 <= 1'b0;
        if(cnt == 2'b01) begin
          data_out  <= databuff[i]; 
          i         <= i - 1'b1;
        end      
      end
    endcase
  end


endmodule