//==============================================================================
// Module name: testfsm2.v
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2020.5.25
// Description:
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       :
// Message    :
//==============================================================================

module testfsm2.v
(
  parameter swidth = 2,
  parameter IDLE = 2'b00,
  parameter ADD = 2'b01,
)
(
  input clk,
  input rstn,

  output inready,
  input  invalid,

  output preadd,
  input  enadd,

  output outvalid,
  input  outready,
);

  reg  [swidth - 1 : 0] current_state;
  reg  [swidth - 1 : 0] next_state;
  
  always @ (posedge clk or negedge rstn) begin
    if(!rstn)
      current_state <= IDLE;
    else
      current_state <= next_state;
    end
  end
  
  always @ (*) begin
    next_state = IDLE;
    inready = 1'b0;
    preadd = 1'b0;
    case (current_state)
      IDLE: begin
        inready = 1'b1;
        if(invalid) begin
          preadd = 1'b1;
          next_state = ADD;
        end
        else
          next_state = IDLE;
      end

      ADD:begin
        
      end


      default: next_state = IDLE;
    endcase
  end

endmodule