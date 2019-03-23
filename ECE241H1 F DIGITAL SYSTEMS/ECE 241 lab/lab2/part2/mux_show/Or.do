# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog mux_show.v

#load simulation using mux as the top level simulation module
vsim v7432

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

##PIN 1,2,3
force {pin1} 0
force {pin2} 0
run 10ns

force {pin1} 0
force {pin2} 1
run 10ns

force {pin1} 1
force {pin2} 0
run 10ns

force {pin1} 1
force {pin2} 1
run 10ns

##PIN 4,5,6
force {pin4} 0
force {pin5} 0
run 10ns

force {pin4} 0
force {pin5} 1
run 10ns

force {pin4} 1
force {pin5} 0
run 10ns

force {pin4} 1
force {pin5} 1
run 10ns

##PIN 13,12,11
force {pin13} 0
force {pin12} 0
run 10ns

force {pin13} 0
force {pin12} 1
run 10ns

force {pin13} 1
force {pin12} 0
run 10ns

force {pin13} 1
force {pin12} 1
run 10ns

##PIN 10,9,8
force {pin10} 0
force {pin9} 0
run 10ns

force {pin10} 0
force {pin9} 1
run 10ns

force {pin10} 1
force {pin9} 0
run 10ns

force {pin10} 1
force {pin9} 1
run 10ns