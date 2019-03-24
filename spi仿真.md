###  spi_xil_bram_out

![1544860257472](F:\SPI\SPI1\spi仿真\%5CUsers%5CHP%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1544860257472.png)

仿真出来得功能符合预期想要实现的

###### 1.传输停止后，突然wen有一个时钟跳变的仿真

![1547111135362](F:\SPI\SPI1\spi仿真\5C1547111135362.png)

这里第四行为wen的信号

![1547111396034](F:\SPI\SPI1\spi仿真\5C1547111396034.png)

可以观察到那个突然的信号并没有让数据输入进来

###### 2.一个循环过来传输数据

![1547125384856](F:\SPI\SPI1\spi仿真\1547125384856.png)

可以看到，再最后一行信号的7和8的链接处，没有出现问题

# 修改一下程序

![1547125829000](F:\SPI\SPI1\spi仿真\1547125829000.png)

使得一次wen的写入，就算改变地址，也不会写入数据

这里主要把wen0_reg写成三位

```verilog
//==============================================================================
// Module name: spi_xil_bram_out
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2018.12.8
// Description: the bram of Xilinx is instantiated to sending data
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================

module spi_xil_bram_out
#(
  parameter DATAWIDTH = 8,
  parameter ADDRWIDTH = 11
)
(
  input                       clka0,
  input                       clkb0,
  input                       rstn,

  //from outside
  input                       wen0,	
  input       [DATAWIDTH-1:0] wdata0,
  input       [ADDRWIDTH-1:0] waddr0,

  //to module spi_out 
  input                       ren0,
  output wire                 not_empty0,
  output wire [DATAWIDTH-1:0] rdata0
);
 
  reg  [2:0]            wen0_reg;
  wire                  wea_and_ena; 
  //wire [ADDRWIDTH-1:0]  waddr0_wire;
  wire [DATAWIDTH-1:0]  wdata0_wire;
 
  reg                   ren0_reg;
  reg  [ADDRWIDTH-1:0]  raddr_reg;
  reg  [ADDRWIDTH-1:0]  raddr_reg1;
  wire                  rstab;

  always @(posedge clka0 or negedge rstn) begin
    if(!rstn) wen0_reg <= 3'b000;
    else      wen0_reg <= {wen0_reg[1:0],wen0};
  end

  always @(posedge clkb0 or negedge rstn) begin
    if(!rstn) begin 
      raddr_reg <= 11'h000;
      ren0_reg  <=  1'b0;
    end
    else begin
      ren0_reg  <= ren0;
      if(ren0_reg == 1'b0 && ren0 == 1'b1) begin
        raddr_reg1 <= raddr_reg;
        if(raddr_reg == 11'd2047) raddr_reg <= 11'h000;
        else                  raddr_reg <= raddr_reg + 1'b1;
      end
    end
  end

  //assign waddr0_wire = ( rstn == 1'b0 || waddr0 == 11'd2047 ) ? 11'h000 : waddr0;
  assign wdata0_wire = ( rstn      == 1'b0        ) ?  8'h00  : wdata0;
  assign wea_and_ena = ( wen0_reg  == 3'b011      ) ?  1'b1   : 1'b0;
  
  assign not_empty0  = ( raddr_reg == waddr0      ) ?  1'b0   : 1'b1;
  assign rstab       = ( rstn      == 1'b0        ) ?  1'b1   : 1'b0;

  blk_mem_gen_0 u_blk_mem_gen_0
  (
    .clka   ( clka0       ),
    .ena    ( wea_and_ena ),
    .wea    ( wea_and_ena ),
    .addra  ( waddr0      ),
    .dina   ( wdata0_wire ),
    .rsta   ( rstab       ),

    .enb    ( ren0        ),
    .clkb   ( clkb0       ),
    .addrb  ( raddr_reg1  ),
    .doutb  ( rdata0      ),
    .rstb   ( rstab       )
  );
              
endmodule
```

### spi_xil_bram_in

![](spi仿真\%5CUsers%5CHP%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1544959716770.png)

![](spi仿真\%5CUsers%5CHP%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1544959766887.png)

功能没什么问题



### spi_counter_tb

![1545031289285](spi仿真\%5CUsers%5CHP%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1545031289285.png)

从仿真结果来看呢，信号除了posedge clk之外，都是其他都是延迟一个时钟才输出的

**根据这个仿真时序，修改fsm。计划在cnt = 1的时候传送，cnt = 0 的时候接收**



### spi_fsm_tb

![1545034605509](spi仿真\%5CUsers%5CHP%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1545034605509.png)



### spi_top_tb

![1545142410238](spi仿真\%5CUsers%5CHP%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1545142410238.png)

从图片可以看出功能是实现了

**但是我觉得仿真的图片看起来和想想中的有点差别，估计如果要写成理想的效果，counter需要多打几拍**



## 后续仿真思路

仿真几种特殊情境下传入bram_out后，是否成立

1. wen上升后，addr和data才来
2. wen只上升一格
3. wen来了之后中途addr和data改变
4. 读取满了之后是否能回来读