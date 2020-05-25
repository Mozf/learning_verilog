//==============================================================================
// Module name: spi_fsm
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2018.12.8
// Description: Finite state machine of spi
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module spi_fsm
#(
  parameter DATAWIDTH = 8,

  parameter IDLE      = 2'b00,
  parameter WAIT      = 2'b01,
  parameter TRANS     = 2'b10
)
(
  input             clk,
  input             rstn,
  
  input             cs,
  input             mors,

  input             cs_in,
  output reg        cs_out,

  input       [1:0] cnt
);

  reg  [1:0] current_state;
  reg  [1:0] next_state;

  reg  [1:0] cs_reg;
  reg  [3:0] cnt_reg;
  reg  [2:0] wait_reg;
  reg  [3:0] trans_reg;

  always @(posedge clk or negedge rstn) begin
    if(!rstn) cs_reg <= 2'b00;
    else      cs_reg <= {cs_reg[0],cs};
  end

  always @(posedge clk or negedge rstn) begin
    if(!rstn)
      cnt_reg <= 4'h0;
    else
      cnt_reg <= {cnt_reg[1:0],cnt};
  end

  always @(posedge clk or negedge rstn) begin
    if(!rstn) current_state <= IDLE;
    else      current_state <= next_state;
  end

  always @(posedge clk) begin
    case(next_state)
      IDLE:begin
        if({mors,cs_reg[1],cnt_reg} == 6'h31 || {mors,cnt_reg} == 5'h01) 
          next_state = WAIT;
        else           
          next_state = IDLE;
      end
      WAIT:begin
        if({mors,cs_out} == 2'b11 || {mors,cs_in} == 2'b01)
          next_state = TRANS;
        else if({mors,cs} == 2'b10 || {mors,cnt_reg} == 5'h00) 
          next_state = IDLE;
        else                  
          next_state = WAIT;
      end
      TRANS:begin
        if({mors,cs_out} == 2'b10 || {mors,cs_in} == 2'b00)
          next_state = WAIT;
        else if({mors,cs} == 2'b10 || {mors,cnt_reg} == 5'h00) 
          next_state = IDLE;
        else
          next_state = TRANS;
      end
      default:next_state = IDLE;
    endcase
  end

  always @(posedge clk) begin
    case(current_state)
      IDLE:begin
        cs_out     <= 1'b0;
        wait_reg   <= 3'b000;
        trans_reg  <= 4'h0;
      end
      WAIT:begin      
        cs_out     <= 1'b0;
        trans_reg  <= 4'h0;
        if(cnt == 2'b01) begin
          wait_reg <= wait_reg + 1'b1;
        end
        if(mors == 1'b1) begin
          if(wait_reg == 3'b100)
            cs_out   <= 1'b1;
          else
            cs_out   <= 1'b0;
        end
        else begin
          cs_out <= 1'b0;
        end
      end
      TRANS:begin              
        wait_reg   <= 3'b000;
        if(cnt == 2'b01) trans_reg <= trans_reg + 1'b1;
        if(mors == 1'b1) begin
          if(trans_reg == 4'h8)
            cs_out   <= 1'b0;
          else             
            cs_out   <= 1'b1;
        end
        else begin
          cs_out   <= 1'b0;
        end 
      end
    endcase
  end

endmodule