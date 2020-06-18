#退出仿真
quit -sim

#新建一个work库
vlib workmodelsim

#该命令的作用是将目前的逻辑工作库work和实际工作库work映射对应。
vmap work workmodelsim

#编译
vlog clock_tb.v
vlog clock.v 

#仿真
vsim workmodelsim.clock_tb -novopt 

#添加信号
#add wave -color red -radix decimal /test_tb/e
add wave sim:/clock_tb/*
# add wave sim:/test_tb/a_inst/*

#运行
run -all