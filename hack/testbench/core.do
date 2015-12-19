vlog -reportprogress 300 -work work ../../testbench/core_tb.v
vlog -reportprogress 300 -work work ../../instruction_memory.v
vlog -reportprogress 300 -work work ../../memory.v
vlog -reportprogress 300 -work work ../../cpu.v
vlog -reportprogress 300 -work work ../../alu.v
vlog -reportprogress 300 -work work ../../program_counter.v
vsim work.core_tb
do ../../testbench/core_wave.do
run 1800
