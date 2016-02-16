vlog -reportprogress 300 -work work ../../bench/verilog/core_tb.v
vlog -reportprogress 300 -work work ../../rtl/verilog/ram_16.v
vlog -reportprogress 300 -work work ../../rtl/verilog/vga_ram.v
vlog -reportprogress 300 -work work ../../rtl/verilog/instruction_memory.v
vlog -reportprogress 300 -work work ../../rtl/verilog/memory.v
vlog -reportprogress 300 -work work ../../rtl/verilog/cpu.v
vlog -reportprogress 300 -work work ../../rtl/verilog/alu.v
vlog -reportprogress 300 -work work ../../rtl/verilog/program_counter.v
vsim work.core_tb
do ../../sim/rtl_sim/bin/core_wave.do
run 4000
