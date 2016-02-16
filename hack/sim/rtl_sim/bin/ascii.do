vlog -reportprogress 300 -work work ../../bench/verilog/ascii_tb.v
vlog -reportprogress 300 -work work ../../rtl/verilog/ascii.v
vsim work.ascii_tb
do ../../sim/rtl_sim/bin/ascii_wave.do
run 8000
