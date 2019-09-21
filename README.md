# 三段式状态机

**在两个always模块描述方法基础上，使用三个always模块，一个always模块采用同步时序描述状态转移，一个always采用组合逻辑判断状态转移条件，描述状态转移规律，另一个always模块描述状态输出(可以用组合电路输出，也可以时序电路输出)。**

```
//第一个进程，同步时序always模块，格式化描述次态寄存器迁移到现态寄存器
always @ (posedge clk or negedge rst_n) begin//异步复位
  if(!rst_n)
    current_state <= IDLE;
  else
    current_state <= next_state; //注意，使用的是非阻塞赋值
end
//第二个进程，组合逻辑always模块，描述状态转移条件判断
always @ (*) begin//电平触发
  next_state = x; //要初始化，使得系统复位后能进入正确的状态
  case(current_state)
    S1: if(...)
    next_state = S2; //阻塞赋值
    ...
  endcase
end
//第三个进程，同步时序always模块，格式化描述次态寄存器输出
always @ (posedge clk or negedge rst_n)
  ...//初始化
  case(next_state)
    S1:
      out1 <= 1'b1; //注意是非阻塞逻辑
    S2:
    out 2 <= 1'b1;
    default:... //default的作用是免除综合工具综合出锁存器
  endcase
end

```
