vlib work

vlog part3.v

vsim try

log {/*}

add wave {/*}

force {clock} 0 0ns,1 1ns -r 2ns
force {reset_n} 0 0ns,1 2ns
force {ld} 1 0ns, 0 2ns, 1 4ns
force {color_in} 2#111

run 1500ns 