# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog sequence_detector.v
#load simulation using mux as the top level simulation module
vsim sequence_detector

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

#
force {KEY[0]} 1 0ns, 0 1ns -r 2ns 

force {SW[0]} 0 0ns, 1 2ns

force {SW[1]} 0 0ns, 1 2ns, 0 14ns, 1 16ns



run 20ns


