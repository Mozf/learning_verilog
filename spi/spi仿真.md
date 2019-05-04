###  spi_xil_bram_out

![1544860257472](spi仿真\%5CUsers%5CHP%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5C1544860257472.png)

仿真出来得功能符合预期想要实现的

**如何能在内部读取地址的时候，在一开始就把raddr = 11'h000读取出来？**



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