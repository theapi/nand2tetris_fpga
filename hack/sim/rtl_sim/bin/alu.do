vlog -reportprogress 300 -work work ../../bench/verilog/alu_tb.v
vlog -reportprogress 300 -work work ../../rtl/verilog/alu.v
vsim work.alu_tb
do ../../sim/rtl_sim/bin/alu_wave.do
run 1600
