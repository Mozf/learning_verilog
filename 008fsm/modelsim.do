quit -sim
vlib workmodelsim
vmap work workmodelsim
vlog test_tb.v
vlog test.v 
vlog test3.v 
vsim workmodelsim.test_tb -novopt 
#add wave -color red -radix decimal /test_tb/e
add wave sim:/test_tb/*
add wave sim:/test_tb/a_inst/state
add wave sim:/test_tb/a_inst/next_state
# add wave sim:/test_tb/a_inst/*
run -all