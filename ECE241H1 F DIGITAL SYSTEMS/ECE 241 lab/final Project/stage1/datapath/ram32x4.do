vlib work

vlog -timescale 1ps/1ps ram32x4.v

vsim -L altera_mf_ver ram32x4

log {/*}

add wave {/*}

force {address} 2#01101 0, 2#01000 40, 2#10010 80, 2#01101 120, 2#01000 160, 2#10010 200

force {clock} 0 0, 1 10 -r 20

force {data} 2#1010 0, 2#1111 40, 2#0000 80

force {wren} 1 0, 0 80


run 300ps