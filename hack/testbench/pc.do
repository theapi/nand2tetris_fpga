vlog -reportprogress 300 -work work ../../testbench/program_counter_tb.v
vlog -reportprogress 300 -work work ../../program_counter.v
vsim work.program_counter_tb
do ../../testbench/program_counter_wave.do
run 400
