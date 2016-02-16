vlog -reportprogress 300 -work work ../../bench/verilog/cpu_tb.v
vlog -reportprogress 300 -work work ../../rtl/verilog/register.v
vlog -reportprogress 300 -work work ../../rtl/verilog/cpu.v
vlog -reportprogress 300 -work work ../../rtl/verilog/alu.v
vlog -reportprogress 300 -work work ../../rtl/verilog/program_counter.v
vsim work.cpu_tb
do ../../sim/rtl_sim/bin/cpu_wave.do
run 1900
