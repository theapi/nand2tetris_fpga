vlog -reportprogress 300 -work work ../../testbench/cpu_tb.v
vlog -reportprogress 300 -work work ../../cpu.v
vsim work.cpu_tb
do ../../testbench/cpu_wave.do
run 60
