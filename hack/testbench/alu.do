vlog -reportprogress 300 -work work ../../testbench/alu_tb.v
vlog -reportprogress 300 -work work ../../alu.v
vsim work.alu_tb
do ../../testbench/alu_wave.do
run 1600
