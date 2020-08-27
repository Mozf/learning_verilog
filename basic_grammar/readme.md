[TOC]

# Verilog HDL

## 进制

|  0   |  1   |  2   |  3   |  4   |  5   |  6   |  7   |  8   |  9   |  10  |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |
|  1   |  2   |  4   |  8   |  16  |  32  |  64  | 128  | 256  | 512  | 1024 |

## 门级原语

逻辑门：

```verilog
and (out,in1,…)
nand (out,in1,…)
or (out,in1,…)
nor (out,in1,…)
xor (out,in1,…)
xnor (out,in1,…)
```

缓冲门和非门：

```verilog
buf (out1,out2,out3,...,in)
/*       
       |    in         |
  buf  | 0 | 1 | x | z |
output | 0 | 1 | x | x |
*/
not (out1,out2,out3,...,in)
/*       
       |    in         |
  not  | 0 | 1 | x | z |
output | 1 | 0 | x | x |
*/
```

 

## 触发器

### RS触发器

$ Q_{n+1} = S + R'Q_{n}$

### D触发器

$ Q_{n+1} = D$

### JK触发器

$ Q_{n+1} = JQ' + K'Q$

### T触发器

$ Q_{n+1} = TQ' + T'Q$



## 状态机

1. mealy状态机：下一状态和输出取决于当前状态和当前输入；
2. moore状态机：下一状态取决于当前状态和当前输入，但是其输出取决于当前状态；

## 可综合与不可综合

1. 所有综合工具都支持的结构：always，assign，begin，end，case，wire，tri，aupply0，supply1，reg，integer，default，for，function，and，nand，or，nor，xor，xnor，buf，not，bufif0，bufif1，notif0，notif1，if，inout，input，instantitation，module，negedge，posedge，operators，output，parameter。

2. 所有综合工具都不支持的结构：time，defparam，$finish，fork，join，initial，delays，UDP，wait。

3. 有些工具支持有些工具不支持的结构：casex，casez，wand，triand，wor，trior，real，disable，forever，arrays，memories，repeat，task，while。 