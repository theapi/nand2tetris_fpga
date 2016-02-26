vlog -reportprogress 300 -work work ../../../bench/verilog/vga_controller_tb.v
vlog -reportprogress 300 -work work ../../../rtl/verilog/vga_controller.v
vlog -reportprogress 300 -work work ../../../rtl/verilog/vga_sync_generator.v
vsim work.vga_controller_tb
do ../../../sim/rtl_sim/bin/vga_controller_wave.do
run 15000000
