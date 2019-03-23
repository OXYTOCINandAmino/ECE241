# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog mux7to1.v

#load simulation using mux as the top level simulation module
vsim mux7to1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 1
force {SW[6]} 0

force {SW[9]} 0
force {SW[8]} 0
force {SW[7]} 0
#run simulation for a few ns
run 10ns



force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 1
force {SW[6]} 0

force {SW[9]} 0
force {SW[8]} 0
force {SW[7]} 1
#run simulation for a few ns
run 10ns



force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 1
force {SW[6]} 0

force {SW[9]} 0
force {SW[8]} 1
force {SW[7]} 0
#run simulation for a few ns
run 10ns



force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 1
force {SW[6]} 0

force {SW[9]} 0
force {SW[8]} 1
force {SW[7]} 1
#run simulation for a few ns
run 10ns



force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 1
force {SW[6]} 0

force {SW[9]} 1
force {SW[8]} 0
force {SW[7]} 0
#run simulation for a few ns
run 10ns



force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 1
force {SW[6]} 0

force {SW[9]} 1
force {SW[8]} 0
force {SW[7]} 1
#run simulation for a few ns
run 10ns



force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 1
force {SW[6]} 0

force {SW[9]} 1
force {SW[8]} 1
force {SW[7]} 0
#run simulation for a few ns
run 10ns
