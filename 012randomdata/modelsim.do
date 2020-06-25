quit -sim
vlib workmodelsim
vmap work workmodelsim
vlog randomdata_tb.v
vlog randomdata.v 
vsim workmodelsim.randomdata_tb -novopt 
#add wave -color red -radix decimal /test_tb/e
add wave sim:/randomdata_tb/*
# add wave sim:/test_tb/a_inst/*
run -all