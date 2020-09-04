#退出仿真
quit -sim

#新建一个work库
vlib workmodelsim

#该命令的作用是将目前的逻辑工作库work和实际工作库work映射对应。
vmap work workmodelsim

#编译
vlog tb_clk.v
vlog clkdiv2.v 

#仿真
vsim workmodelsim.tb_clk -novopt 

#添加信号
#add wave -color red -radix decimal /tb_clk/e
add wave sim:/tb_clk/*
add wave sim:/tb_clk/clkdiv2_inst_0/*
# add wave sim:/test_tb/a_inst/*

#运行
run -all