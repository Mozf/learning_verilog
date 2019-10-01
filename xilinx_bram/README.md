这是xilinx的bram，使用ture dual port，port A使用axi与ps相连，port B为自己写入数据。

在top.v中，由fpga写入数据，当rstn = 1时，fpga运行，亮一个led灯，并且往地址0~6中写入数据，之后，保持数据不变，继续写入。