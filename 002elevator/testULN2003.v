//==============================================================================
// Module name: testULN2003
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2019.7.8
// Description: test ULN2003 
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module testULN2003
(
  input               clk,
  input               a,
  input               rstn,

  output  reg  [3:0]  INgogo,
  output  reg         led0,
  output  reg         led1
);

  reg  [6:0]  cnt100;
  reg  [9:0]  cnt1000;
  reg  [3:0]  cnt_speed;
  reg  [1:0]  fsm;

  always@(posedge clk or negedge rstn) begin //10 * 100 = 1000 ns = 1us
    if(!rstn) begin
      cnt100 <= 7'd0;
    end
    else if(cnt100 == 7'd99) begin
      cnt100 <= 7'd0;
    end
    else begin
      cnt100 <= cnt100 + 1'b1;
    end
  end

  always@(posedge clk or negedge rstn) begin //1 * 1000 = 1000 us = 1ms
    if(!rstn) begin
      cnt1000 <= 10'd0;
    end
    else if(cnt1000 == 10'd999) begin
      cnt1000 <= 10'd0;
    end
    else if(cnt100 == 7'd99) begin
      cnt1000 <= cnt1000 + 1'b1;
    end
  end

  always@(posedge clk or negedge rstn) begin //1ms * 6 = 6ms
    if(!rstn) begin
      cnt_speed <= 4'd0;
      fsm <= 2'b00;
      led1   <= 1'b0;
    end
    else if(cnt_speed == 4'd5) begin
      cnt_speed <= 4'd0;
      led1  <= ~led1;
      fsm <= fsm + 1'b1;
    end
    else if(cnt1000 == 10'd999) begin
      cnt_speed <= cnt_speed + 1'b1;
    end
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      INgogo <= 4'd0;
    end
    else begin
      case(fsm)
        2'b00:INgogo <= 4'b0001;
        2'b01:INgogo <= 4'b0010;
        2'b10:INgogo <= 4'b0100;
        2'b11:INgogo <= 4'b1000;
        default:;
      endcase
    end
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      led0 <= 1'b0;
    end
    else 
      case(a)
        1'b0:led0 <= 1'b0;
        1'b1:led0 <= 1'b1;
        default:;
      endcase
  end

endmodule