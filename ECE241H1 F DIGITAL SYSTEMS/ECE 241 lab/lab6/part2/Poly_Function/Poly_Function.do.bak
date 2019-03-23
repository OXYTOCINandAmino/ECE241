# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog poly_function.v
#load simulation using mux as the top level simulation module

vsim part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

#	 
force {clk} 1 0ns, 0 1ns -r 2ns 

force {resetn} 0 0ns, 1 3ns

force {go} 0 0ns, 1 4.5ns, 0 6.5ns, 1 8.5ns, 0 10.5ns, 1 12.5ns, 0 14.5ns, 1 16.5ns, 0 18.5ns,1 20.5ns, 0 22.5ns,1 24.5ns, 0 26.5ns, 1 28.5ns, 0 30.5ns

force {data_in}   10#5 4ns,         10#4 8ns,         10#3 12ns,           10#2 16ns

run 40ns


