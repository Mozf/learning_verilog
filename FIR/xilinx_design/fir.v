//==============================================================================
// Module name: fir
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2019.5.5
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
  input                  clk,
  input                  rstn,
  input  [IWIDTH - 1:0]  din,
  
  output [OWIDTH + 1:0]  dout
);

  reg [IWIDTH - 1:0]  delay0;
  reg [IWIDTH - 1:0]  delay1;
  reg [IWIDTH - 1:0]  delay2;
  reg [IWIDTH - 1:0]  delay3;
  reg [IWIDTH - 1:0]  delay4;
  reg [IWIDTH - 1:0]  delay5;
  reg [IWIDTH - 1:0]  delay6;
  reg [IWIDTH - 1:0]  delay7;

  wire [IWIDTH:0]  dadd0_0;
  wire [IWIDTH:0]  dadd0_1;
  wire [IWIDTH:0]  dadd0_2;
  wire [IWIDTH:0]  dadd0_3;

  reg [IWIDTH - 1:0]  coeff0  = 8'd4;
  reg [IWIDTH - 1:0]  coeff1  = 8'd27;
  reg [IWIDTH - 1:0]  coeff2  = 8'd135;
  reg [IWIDTH - 1:0]  coeff3  = 8'd254;

  wire [OWIDTH:0]  dmul0;
  wire [OWIDTH:0]  dmul1;
  wire [OWIDTH:0]  dmul2;
  wire [OWIDTH:0]  dmul3;

  wire [OWIDTH + 1:0]  dadd1_0;
  wire [OWIDTH + 1:0]  dadd1_1;


  //y(n) = h(n)*x(n)
  //输入信号延迟
  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      delay0  <= 8'd0;
      delay1  <= 8'd0;
      delay2  <= 8'd0;
      delay3  <= 8'd0;
      delay4  <= 8'd0;
      delay5  <= 8'd0;
      delay6  <= 8'd0;
      delay7  <= 8'd0;
    end
    else begin
      delay0  <=  din;
      delay1  <=  delay0;
      delay2  <=  delay1;
      delay3  <=  delay2;
      delay4  <=  delay3;
      delay5  <=  delay4;
      delay6  <=  delay5;
      delay7  <=  delay6;
    end
  end

  //add_0    0
  c_addsub_0_0 c_addsub_0_0_inst
  (
    .CLK  ( clk      ),
    .A    ( delay0   ),
    .B    ( delay7   ),
    .S    ( dadd0_0  )
  );

  c_addsub_0_1 c_addsub_0_1_inst
  (
    .CLK  ( clk      ),
    .A    ( delay1   ),
    .B    ( delay6   ),
    .S    ( dadd0_1  )
  );

  c_addsub_0_2 c_addsub_0_2_inst
  (
    .CLK  ( clk      ),
    .A    ( delay2   ),
    .B    ( delay5   ),
    .S    ( dadd0_2  )
  );

  c_addsub_0_3 c_addsub_0_3_inst
  (
    .CLK  ( clk      ),
    .A    ( delay3   ),
    .B    ( delay4   ),
    .S    ( dadd0_3  )
  );

  //mult    1
  mult_gen_0 mult_gen_0_inst
  (
    .CLK  ( clk     ),
    .A    ( dadd0_0 ),
    .B    ( coeff0  ),
    .P    ( dmul0   )
  );

  mult_gen_1 mult_gen_1_inst
  (
    .CLK  ( clk     ),
    .A    ( dadd0_1 ),
    .B    ( coeff1  ),
    .P    ( dmul1   )
  );

  mult_gen_2 mult_gen_2_inst
  (
    .CLK  ( clk     ),
    .A    ( dadd0_2 ),
    .B    ( coeff2  ),
    .P    ( dmul2   )
  );

  mult_gen_3 mult_gen_3_inst
  (
    .CLK  ( clk     ),
    .A    ( dadd0_3 ),
    .B    ( coeff3  ),
    .P    ( dmul3   )
  );

  //add1       2
  c_addsub_1_0 c_addsub_1_0_inst
  (
    .CLK  ( clk     ),
    .A    ( dmul0   ),
    .B    ( dmul1   ),
    .S    ( dadd1_0 )
  );

  c_addsub_1_1 c_addsub_1_1_inst
  (
    .CLK  ( clk     ),
    .A    ( dmul2   ),
    .B    ( dmul3   ),
    .S    ( dadd1_1 )
  );
  
  //add2       3
  c_addsub_2_0 c_addsub_2_0_inst
  (
    .CLK  ( clk     ),
    .A    ( dadd1_0 ),
    .B    ( dadd1_1 ),
    .S    ( dout    )
  );

endmodule