#退出仿真
quit -sim

#新建一个work库
vlib workmodelsim

#该命令的作用是将目前的逻辑工作库work和实际工作库work映射对应。
vmap work workmodelsim

#编译
vlog test_tb.v
vlog test.v 
vlog test3.v 

#仿真
vsim workmodelsim.test_tb -novopt 

#添加信号
#add wave -color red -radix decimal /test_tb/e
add wave sim:/test_tb/*
# add wave sim:/test_tb/a_inst/*

#运行
run -all