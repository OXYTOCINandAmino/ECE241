vlib work

vlog -timescale 1ns/1ns sine_cos.v

vsim sine_cos

log {/*}

add wave {/*}


force {clk} 0 0,1 1 -r 2
force {reset} 1 0,0 2
force {en} 1
run 300ns