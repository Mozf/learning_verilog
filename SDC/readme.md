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

### [时钟周期约束](https://mp.weixin.qq.com/s?__biz=MzI4NjE3MzUwMA==&mid=2652139737&idx=6&sn=a8d6b7543672ce44bde6d14c12b7244f&chksm=f000208ac777a99c8de943ffda0ab16c55b5b4d3c0a414484442e6cab4252c8ffff64d86bf0e&scene=21#wechat_redirect)

1. 获取时钟接口：

`set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports sysclk]`

`create_clock -name sysclk -period 8.000 -waveform {0.000 4.000} [get_ports sysclk]`

2. 时钟uncertainty：

`set_clock_uncertainty -setup 0.14 [get_clocks clk]`

3. **set_clock_groups**

```xdc
create_clock -name clk1A -period 20.0 [get_ports clk1]
create_clock -name clk1B -period 10.0 [get_ports clk1] -add
create_clock -name clk1C -period 5.0 [get_ports clk1] -add 
create_clock -name clk2 -period 10.0 [get_ports clk2]
set_clock_groups -physically_exclusive -group clk1A -group clk1B -group clk1C
set_clock_groups -asynchronous -group "clk1A clk1B clk1C" -group clk2
```

4. 创建虚拟时钟

![24](.\24.png)

```xdc
reate_clock -name sysclk -period 10 [get_ports clkin]
create_clock -name virclk -period 6.4
set_input_delay 2 -clock sysclk [get_ports A]
set_input_delay 2 -clock virclk [get_ports B]
```

注意，虚拟时钟必须在约束I/O延迟之前被定义。

5. 最大最小延迟约束

顾名思义，就是设置路径的max/min delay，主要应用场景有两个：

* 输入管脚的信号经过组合逻辑后直接输出到管脚
* 异步电路之间的最大最小延迟

![25](.\25.png)

```xdc
set_max_delay <delay> [-datapath_only] [-from <node_list>][-to <node_list>][-through <node_list>]
set_min_delay <delay> [-from <node_list>] [-to <node_list>][-through <node_list>]
```



### 延迟约束

延迟约束用的是`set_input_delay`和`set_output_delay`，分别用于input端和output端，其时钟源可以是时钟输入管脚，也可以是虚拟时钟。**但需要注意的是，这个两个约束并不是起延迟的作用**，具体原因下面分析。

1. `set_input_delay`

$T_{inputdelay} = T_{co} + T_{D}$

当满足的时序时，最大延迟为2ns，最小延迟为1ns。

因此，需要加的时序约束为：

```xdc
create_clock -name sysclk -period 10 [get_ports clkin]
set_input_delay 2 -max -clock sysclk [get_ports Datain]
set_input_delay 1 -min -clock sysclk [get_ports Datain]
```

2. `set_output_delay`

   和input delay 很相似。

### 多周期约束

​		默认情况下,保持时间的检查是以建立时间的检查为前提,即总是在建立时间的前一个时钟周期确定保持时间检查。这个也不难理解，上面的图中，数据在时刻1的边沿被发起，建立时间的检查是在时刻2进行，而保持时间的检查是在时刻1（如果这里不能理解，再回头看我们讲保持时间章节的内容），因此保持时间的检查是在建立时间检查的前一个时钟沿。

  但在实际的工程中，经常会碰到数据被发起后，由于路径过长或者逻辑延迟过长要经过多个时钟周期才能到达捕获寄存器；又或者在数据发起的几个周期后，后续逻辑才能使用。这时如果按照单周期路径进行时序检查，就会报出时序违规。因此就需要我们这一节所讲的多周期路径了。

`set_multicycle_path <num_cycles> [-setup|-hold] [-start|-end][-from <startpoints>] [-to <endpoints>] [-through <pins|cells|nets>]`

| 参数                       | 含义                    |
| -------------------------- | ----------------------- |
| num_cycles [-setup  -hold] | 建立/保持时间的周期个数 |
| [-start  -end]             | 参数时钟选取            |
| -from                      | 发起点                  |
| -to                        | 捕获点                  |
| -through                   | 经过点                  |

1. 单时钟域

![16](.\26.png)

若我们没有指定任何的约束，默认的建立/保持时间的分析就像我们上面所讲的单周期路径，如下图所示。

![27](.\27.png)

但由于我们的的数据经过了两个时钟周期才被捕获，因此建立时间的分析时需要再延迟一个周期的时间。

采用如下的时序约束：

`set_multicycle_path 2 -setup -from [get_pins data0_reg/C] -to [get_pins data1_reg/D]`

在建立时间被修改后，保持时间也会自动调整到捕获时钟沿的前一个时钟沿，如下图所示。

![28](.\28.png)

很明显，这个保持时间检查是不对的，因为保持时间的检查针对的是同一个时钟沿，因此我们要把保持时间往回调一个周期，需要再增加一句约束：

`set_multicycle_path 1 -hold -end -from [get_pins data0_reg/C] -to [get_pins data1_reg/D]`

这里加上`-end`参数是因为我们要把捕获时钟沿往前移，因此针对的是接收端，但由于我们这边讲的是单时钟域，发送端和接收端的时钟是同一个，因此`-end`可以省略。

2. 时钟相移

前面我们讨论的是在单时钟域下，发送端和接收端时钟是同频同相的，如果两个时钟同频不同相怎么处理？

![29](.\29.png)

​		如上图所示，时钟周期为4ns，接收端的时钟沿比发送端晚了0.3ns，若不进行约束，建立时间只有0.3ns，时序基本不可能收敛；而保持时间则为3.7ns，过于丰富。可能有的同学对保持时间会有疑惑，3.7ns是怎么来的？还记得我们上面讲的保持时间的定义么，在0ns时刻，接收端捕获到发送的数据后，要再过3.7ns的时间发送端才会发出下一个数据，因此本次捕获的数据最短可持续3.7ns，即保持时间为3.7ns。

  因此，在这种情况下，我们应把捕获沿向后移一个周期，约束如下：`set_multicycle_path 2 -setup -from [get_clocks CLK1] -to [get_clocks CLK2]`

![30](.\30.png)

3. 慢时钟到快时钟的多周期

当发起时钟慢于捕获时钟时，我们应该如何处理？

![31](.\31.png)

假设捕获时钟频率是发起时钟频率的3倍，在没有任何约束的情况下，Vivado默认会按照如下图所示的建立保持时间进行分析。

![32](.\32.png)

但我们可以通过约束让建立时间的要求更容易满足，即:`set_multicycle_path 3 -setup -from [get_clocks CLK1] -to [get_clocks CLK2]`,跟上面讲的一样，设置了setup，hold会自动变化，但我们不希望hold变化，因此再增加：`set_multicycle_path 2 -hold -end -from [get_clocks CLK1] -to [get_clocks CLK2]`。这里由于发起和捕获是两个时钟，因此`-end`参数是不可省的。加上时序约束后，Vivado会按照下面的方式进行时序分析。

![33](.\33.png)

4. 快时钟到慢时钟的多周期

   ​		当发起时钟快于捕获时钟时，我们应该如何处理？

    	假设发起时钟频率是捕获时钟频率的3倍，在没有任何约束的情况下，Vivado默认会按照如下图所示的建立保持时间进行分析。

![34](.\34.png)

同理，我们可以通过约束，让时序条件更加宽裕。

```xdc
set_multicycle_path 3 -setup -start -from [get_clocks CLK1] -to [get_clocks CLK2]
set_multicycle_path 2 -hold -from [get_clocks CLK1] -to [get_clocks CLK2]
```

![35](.\35.png)

![36](.\36.png)

### 伪路径

什么是伪路径？伪路径指的是该路径存在，但该路径的电路功能不会发生或者无须时序约束。如果路径上的电路不会发生，那Vivado综合后会自动优化掉，因此我们无需考虑这种情况。

  为什么要创建伪路径？创建伪路径可以减少工具运行优化时间,增强实现结果,避免在不需要进行时序约束的地方花较多时间而忽略了真正需要进行优化的地方。

  伪路径一般用于：

* 跨时钟域
* 一上电就被写入数据的寄存器
* 异步复位或测试逻辑
* 异步双端口RAM

  可以看出，伪路径主要就是用在异步时钟的处理上，我们上一节讲的多周期路径中，也存在跨时钟域的情况的，但上面我们讲的是两个同步的时钟域。

伪路径的约束为：`set_false_path [-setup] [-hold] [-from <node_list>] [-to <node_list>] [-through <node_list>]`

* `-from`的节点应是有效的起始点.有效的起始点包含时钟对象,时序单元的clock引脚,或者input(or inout)原语;
* `-to`的节点应包含有效的终结点.一个有效的终结点包含时钟对象,output(or inout)原语端口,或者时序功能单元的数据输入端口;
* `-through`的节点应包括引脚,端口,或线网.当单独使用-through时,应注意所有路径中包含-through节点的路径都将被时序分析工具所忽略.

因为它们经过的先后顺序不同，伪路径的约束是单向的，并非双向的，若两个时钟域相互之间都有数据传输，则应采用如下约束：

```xdc
set_false_path -from [get_clocks clk1] -to [get_clocks clk2]
set_false_path -from [get_clocks clk2] -to [get_clocks clk1]
```

也可以直接采用如下的方式，与上述两行约束等效：

```xdc
set_clock_groups -async -group [get_clocks clk1] -to [get_clocks clk2]
```