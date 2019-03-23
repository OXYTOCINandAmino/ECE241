
vlib work

vlog  fill.v

vsim control

log {/*}

add wave {/*}

force {clk} 0 0ns, 1 1ns -r 2ns
force {reset_n} 0 0ns, 1 2ns

force {ld} 0 0ns,1 2ns,0 4ns,1 6ns,0 8ns
force {plot} 0 0ns, 1 8ns, 0 10ns

run 50ns