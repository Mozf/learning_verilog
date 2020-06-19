iverilog -o ASD clock_tb.v clock.v
vvp -n ASD ASD.lxt2
cp clock1.vcd ASD.lxt
gtkwave ASD.lxt
