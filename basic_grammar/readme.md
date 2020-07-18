[TOC]

# Verilog HDL

## other

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

