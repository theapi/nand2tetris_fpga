vlog -reportprogress 300 -work work ../../testbench/ascii_tb.v
vlog -reportprogress 300 -work work ../../ascii.v
vsim work.ascii_tb
do ../../testbench/ascii_wave.do
run 8000
