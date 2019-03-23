# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog Divider.v

#load simulation using mux as the top level simulation module
vsim show_part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# 
force {clk} 0 0ns, 1 1ns -r 2ns

force {reset} 1 0ns,0 2ns
force {go} 0 0ns, 1 4ns, 0 6ns


force {Divisor} 10#3
force {divident} 10#7

force {Quotient}  1110 7ns, 1100 11ns, 1001 15ns, 0010 19ns
force {Remainder}  0000 7ns, 0001 11ns, 0000 15ns, 0001 19ns

run 22ns


