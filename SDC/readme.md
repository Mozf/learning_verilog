[TOC]

# [时序约束](https://mp.weixin.qq.com/s?__biz=MzI4NjE3MzUwMA==&mid=504654549&idx=1&sn=d1bb03fba37e5b3e9da7129d924becfd&chksm=70003a864777b39033c3d7b2a86f994e35d8248c11216e6465118a287aa74ef52a209dba6a64&mpshare=1&scene=1&srcid=0901clw9IjcJQKPHmRsXjicg&sharer_sharetime=1598946707341&sharer_shareid=0516b2c480f54728ae05eb45e2b16b77&key=0bf7ea9b7da17e981e4f039041f444cf1cff02bb45ee36f610f180e9ae2d913b53a07cf2535d3db1cd4e3986aada0c1a86805cc31ebd84cd2bd56faf2565218f1143dabb2303b4e6576e123feaf4385fcce77617def7dc71bef60618efed169e930eeafa2c7b2bb2c4e2971720c0a47664f92831842c8614749074713d3186aa&ascene=1&uin=OTU2MzUwNjAy&devicetype=Windows+10+x64&version=62090529&lang=zh_CN&exportkey=AUq8CUDc1i2kFo%2BCQszNy9E%3D&pass_ticket=J1WJP6R6rRQQHNdmcv17BKUV9vwy3CTG0AyUMzwdY%2FD4QPmTgHeuirz3l%2F3eNqxD)

## 基础知识

![4](./4.png)

![5](./5.png)

![6](./6.png)

### 时序分析

检查设计中所有D触发器是否正常工作。

1. 同步端口（输入）是否满足setup time和hold time；
2. 异步端口（一般是复位）是否满足恢复时间（recovery）和移除时间（removal）；

![1](./1.png)



### 建立/保持时间

#### 公式

最小时钟路径减setup更大

最大时钟路径加hold更小

$ T_{data\_path\_max}+ T_{setup} <= T_{clk\_path\_min}+T_{period}$

$ T_{data\_path\_min}- T_{hold} >= T_{clk\_path\_max}$



$ T_{clk} \geq T_{co} + T_{Logic} + T_{routing} + T_{setup} - T_{skew}$

$ T_{data\_path} + T_{setup} <= T_{skew} + T_{clk} $

$ T_{data\_path} = T_{co} + T_{logic} + T_{routing} ≥ T_{skew} + T_{hold}$

#### 解释

$ T_{setup} $: 在clk上升沿到来之前，数据提前一个最小时间量“预先准备好”，这个最小时间量就是建立时间。

![2](./2.png)

![7](./7.png)

![8](./8.png)

![9](./9.png)

![10](./10.png)

![11](./11.png)

![12](./12.png)

![13](./13.png)

![14](./14.png)

![15](./15.png)

![16](./16.png)



$ T_{hold}$ :  在clk上升沿来之后，数据必须保持一个最小时间量“不能变化”，这个最小时间量就是保持时间。



![3](./3.png)

![17](./17.png)

![18](./18.png)

![19](19.png)

![20](.\20.png)

### 时序分析路径

有以下四种路径

![21](.\21.png)

设clk period = 2ns `create_clock -period 2 [get_ports clk]`

1. input port -> reg input pin

   ` set_input_delay`

2. clk pin -> reg input pin

   ` create_clock`

3. clk pin -> output port

   ` set_output_delay`

4. input port -> output port

   ` set_max_delay`

$ T_{clk} \geq T_{co} + T_{Logic} + T_{routing} + T_{setup} - T_{skew}$ 

其中，$T_{co}$为发端寄存器时钟到输出时间；$T_{logic}$为组合逻辑延迟；$T_{routing}$为两级寄存器之间的布线延迟；$T_{setup}$为收端寄存器建立时间；$T_{skew}$为两级寄存器的时钟歪斜，其值等于时钟同边沿到达两个寄存器时钟端口的时间差；$T_{clk}$为系统所能达到的最小时钟周期。

#### [$T_{skew}$](https://mp.weixin.qq.com/s?__biz=MzI4NjE3MzUwMA==&mid=2652139737&idx=4&sn=bc6d9542dc3c687dcb6bde6da8ea8de3&chksm=f000208ac777a99c8b879d08286fa1e4de3088fa1c245469336824a043ca170515146aab8f97&scene=21#wechat_redirect)

1. positive

![22](.\22.png)

2. negative

   ![23](.\23.png)

### xilinx 

datasheet：DocNav ---> DC and AC switching characeristics

## arty-z7

### 时钟

1. 获取时钟接口：

`set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports sysclk]`

`create_clock -name sysclk -period 8.000 -waveform {0.000 4.000} [get_ports sysclk]`

2. 时钟uncertainty：

`set_clock_uncertainty -setup 0.14 [get_clocks clk]`