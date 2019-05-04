//==============================================================================
// Module name: fir
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2019.5.3
// Description: fir design
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module fir 
#(
  localparam IWIDTH   = 8,
  localparam OWIDTH   = 16  
)
(
  input                       clk,
  input                       rstn,
  input       [IWIDTH - 1:0]  din,
  
  output reg  [OWIDTH:0]      dout
);

  reg [IWIDTH - 1:0]  delay1;
  reg [IWIDTH - 1:0]  delay2;
  reg [IWIDTH - 1:0]  delay3;
  reg [IWIDTH - 1:0]  delay4;
  reg [IWIDTH - 1:0]  delay5;
  reg [IWIDTH - 1:0]  delay6;
  reg [IWIDTH - 1:0]  delay7;
  reg [IWIDTH - 1:0]  delay8;
  reg [IWIDTH - 1:0]  delay9;
  reg [IWIDTH - 1:0]  delay10;
  reg [IWIDTH - 1:0]  delay11;
  reg [IWIDTH - 1:0]  delay12;

  reg [IWIDTH - 1:0]  coeff1  = 8'd9;
  reg [IWIDTH - 1:0]  coeff2  = 8'd7;
  reg [IWIDTH - 1:0]  coeff3  = 8'd12;
  reg [IWIDTH - 1:0]  coeff4  = 8'd34;
  reg [IWIDTH - 1:0]  coeff5  = 8'd71;
  reg [IWIDTH - 1:0]  coeff6  = 8'd101;
  reg [IWIDTH - 1:0]  coeff7  = 8'd101;
  reg [IWIDTH - 1:0]  coeff8  = 8'd71;
  reg [IWIDTH - 1:0]  coeff9  = 8'd34;
  reg [IWIDTH - 1:0]  coeff10 = 8'd12;
  reg [IWIDTH - 1:0]  coeff11 = 8'd7;
  reg [IWIDTH - 1:0]  coeff12 = 8'd9;

  reg  [OWIDTH - 1:0]  dmul1;
  reg  [OWIDTH - 1:0]  dmul2;
  reg  [OWIDTH - 1:0]  dmul3;
  reg  [OWIDTH - 1:0]  dmul4;
  reg  [OWIDTH - 1:0]  dmul5;
  reg  [OWIDTH - 1:0]  dmul6;
  reg  [OWIDTH - 1:0]  dmul7;
  reg  [OWIDTH - 1:0]  dmul8;
  reg  [OWIDTH - 1:0]  dmul9;
  reg  [OWIDTH - 1:0]  dmul10;
  reg  [OWIDTH - 1:0]  dmul11;
  reg  [OWIDTH - 1:0]  dmul12;

  //y(n) = h(n)*x(n)
  //输入信号延迟
  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      delay1  <= 8'd0;
      delay2  <= 8'd0;
      delay3  <= 8'd0;
      delay4  <= 8'd0;
      delay5  <= 8'd0;
      delay6  <= 8'd0;
      delay7  <= 8'd0;
      delay8  <= 8'd0;
      delay9  <= 8'd0;
      delay10 <= 8'd0;
      delay11 <= 8'd0;
      delay12 <= 8'd0;
    end
    else begin
      delay1  <=  din;
      delay2  <=  delay1;
      delay3  <=  delay2;
      delay4  <=  delay3;
      delay5  <=  delay4;
      delay6  <=  delay5;
      delay7  <=  delay6;
      delay8  <=  delay7;
      delay9  <=  delay8;
      delay10 <=  delay9;
      delay11 <=  delay10;
      delay12 <=  delay11;
    end
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) dmul1 <= 16'd0;
    else      dmul1 <= delay1 * coeff1;
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) dmul2 <= 16'd0;
    else      dmul2 <= delay2 * coeff2;
  end
  
  always@(posedge clk or negedge rstn) begin
    if(!rstn) dmul3 <= 16'd0;
    else      dmul3 <= delay3 * coeff3;
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) dmul4 <= 16'd0;
    else      dmul4 <= delay4 * coeff4;
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) dmul5 <= 16'd0;
    else      dmul5 <= delay5 * coeff5;
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) dmul6 <= 16'd0;
    else      dmul6 <= delay6 * coeff6;
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) dmul7 <= 16'd0;
    else      dmul7 <= delay7 * coeff7;
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) dmul8 <= 16'd0;
    else      dmul8 <= delay8 * coeff8;
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) dmul9 <= 16'd0;
    else      dmul9 <= delay9 * coeff9;
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) dmul10 <= 16'd0;
    else      dmul10 <= delay10 * coeff10;
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) dmul11 <= 16'd0;
    else      dmul11 <= delay11 * coeff11;
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) dmul12 <= 16'd0;
    else      dmul12 <= delay12 * coeff12;
  end

  reg [OWIDTH - 1:0] dadd1_1;
  reg [OWIDTH - 1:0] dadd1_2;
  reg [OWIDTH - 1:0] dadd1_3;
  reg [OWIDTH - 1:0] dadd1_4;
  reg [OWIDTH - 1:0] dadd1_5;
  reg [OWIDTH - 1:0] dadd1_6;

  always@(posedge clk or negedge rstn) begin
    if(!rstn) dadd1_1  <= 16'd0;
    else      dadd1_1  <= dmul1 + dmul2;
  end
  always@(posedge clk or negedge rstn) begin
    if(!rstn) dadd1_2  <= 16'd0;
    else      dadd1_2  <= dmul3 + dmul4;
  end
  always@(posedge clk or negedge rstn) begin
    if(!rstn) dadd1_3  <= 16'd0;
    else      dadd1_3  <= dmul5 + dmul6;
  end
  always@(posedge clk or negedge rstn) begin
    if(!rstn) dadd1_4  <= 16'd0;
    else      dadd1_4  <= dmul7 + dmul8;
  end
  always@(posedge clk or negedge rstn) begin
    if(!rstn) dadd1_5  <= 16'd0;
    else      dadd1_5  <= dmul9 + dmul10;
  end
  always@(posedge clk or negedge rstn) begin
    if(!rstn) dadd1_6  <= 16'd0;
    else      dadd1_6  <= dmul11 + dmul12;
  end

  reg [OWIDTH - 1:0] dadd2_1;
  reg [OWIDTH - 1:0] dadd2_2;
  reg [OWIDTH - 1:0] dadd2_3;

  always@(posedge clk or negedge rstn) begin
    if(!rstn) dadd2_1  <= 16'd0;
    else      dadd2_1  <= dadd1_1 + dadd1_2;
  end
  always@(posedge clk or negedge rstn) begin
    if(!rstn) dadd2_2  <= 16'd0;
    else      dadd2_2  <= dadd1_3 + dadd1_4;
  end
  always@(posedge clk or negedge rstn) begin
    if(!rstn) dadd2_3  <= 16'd0;
    else      dadd2_3  <= dadd1_5 + dadd1_6;
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) dout  <= 16'd0;
    else      dout  <= dadd2_1 + dadd2_2 + dadd2_3;
  end

endmodule