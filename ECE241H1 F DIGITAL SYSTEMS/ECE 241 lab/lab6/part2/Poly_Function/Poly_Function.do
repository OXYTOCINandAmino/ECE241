# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog Poly_Function.v
#load simulation using mux as the top level simulation module

vsim part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

#	 
force {clk} 1 0ns, 0 1ns -r 2ns 

force {resetn} 0 0ns, 1 3ns

force {go}        0 0ns, 1 5.5ns, 0 10.5ns, 1 15.5ns, 0 20.5ns, 1 25.5ns, 0 30.5ns, 1 35.5ns, 0 40.5ns,1 45.5ns, 0 50.5ns,1 55.5ns, 0 60.5ns, 1 65.5ns, 0 70.5ns

force {data_in}   10#3 0ns,       10#2 10ns,          10#1 20ns,          10#2 30ns

run 80ns


