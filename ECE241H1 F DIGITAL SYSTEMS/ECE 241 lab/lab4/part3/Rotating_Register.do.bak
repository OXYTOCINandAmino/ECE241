# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog Rotating_Register.v

#load simulation using mux as the top level simulation module
vsim Rotating_Register

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# clock rising edge 0
force {KEY[0]} 0

force {SW[9]} 0
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 1


force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

run 10ns

force {KEY[0]} 1

force {SW[9]} 0
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 1


force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

run 10ns

# clock rising edge 1
force {KEY[0]} 0

force {SW[9]} 1
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 1


force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

run 10ns

force {KEY[0]} 1

force {SW[9]} 1
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 1


force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

run 10ns

# clock rising edge 2
force {KEY[0]} 0

force {SW[9]} 0
force {KEY[1]} 0
force {KEY[2]} 1
force {KEY[3]} 0


force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

run 10ns

force {KEY[0]} 1

force {SW[9]} 0
force {KEY[1]} 0
force {KEY[2]} 1
force {KEY[3]} 0


force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

run 10ns

# clock rising edge 3
force {KEY[0]} 0

force {SW[9]} 0
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0


force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

run 10ns

force {KEY[0]} 1

force {SW[9]} 0
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0


force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

run 10ns

# clock rising edge 4
force {KEY[0]} 0

force {SW[9]} 0
force {KEY[1]} 0
force {KEY[2]} 1
force {KEY[3]} 1


force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

run 10ns

force {KEY[0]} 1

force {SW[9]} 0
force {KEY[1]} 0
force {KEY[2]} 1
force {KEY[3]} 1


force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

run 10ns

# clock rising edge 5
force {KEY[0]} 0

force {SW[9]} 0
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1


force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

run 10ns

force {KEY[0]} 1

force {SW[9]} 0
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1


force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

run 10ns

# clock rising edge 6
force {KEY[0]} 0

force {SW[9]} 0
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 0


force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

run 10ns

force {KEY[0]} 1

force {SW[9]} 0
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 0


force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

run 10ns

# clock rising edge 7
force {KEY[0]} 0

force {SW[9]} 0
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 0


force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

run 10ns

force {KEY[0]} 1

force {SW[9]} 0
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 0


force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

run 10ns