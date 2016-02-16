vlog -reportprogress 300 -work work ../../bench/verilog/program_counter_tb.v
vlog -reportprogress 300 -work work ../../rtl/verilog/program_counter.v
vsim work.program_counter_tb
do ../../sim/rtl_sim/bin/program_counter_wave.do
run 400
