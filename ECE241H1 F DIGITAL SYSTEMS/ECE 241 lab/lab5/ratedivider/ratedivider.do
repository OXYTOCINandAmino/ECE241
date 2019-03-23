# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog ratedivider.v

#load simulation using mux as the top level simulation module
vsim ratedivider

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# 
force {enable} 1

force {clk} 0 0ns, 1 1ns -r 2ns

force {load}  10#7  
#automatically convert 7 into 111

force {reset_n} 0 0ns, 1 3ns



run 20ns


