onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /core_tb/clk
add wave -noupdate /core_tb/reset
add wave -noupdate -radix decimal /core_tb/cpu/pc_in
add wave -noupdate /core_tb/cpu/pc_load
add wave -noupdate -radix decimal /core_tb/pc
add wave -noupdate -radix unsigned /core_tb/inM
add wave -noupdate /core_tb/instruction
add wave -noupdate -radix unsigned /core_tb/outM
add wave -noupdate /core_tb/writeM
add wave -noupdate -radix unsigned /core_tb/addressM
add wave -noupdate -radix decimal /core_tb/areg
add wave -noupdate -radix decimal /core_tb/dreg
add wave -noupdate -divider {VGA ram}
add wave -noupdate -radix unsigned /core_tb/data_memory/vgaram/d
add wave -noupdate /core_tb/data_memory/vgaram/q
add wave -noupdate /core_tb/data_memory/vgaram/we
add wave -noupdate -radix unsigned /core_tb/data_memory/vgaram/write_address
add wave -noupdate -radix unsigned {/core_tb/data_memory/vgaram/mem[0]}
add wave -noupdate -divider ALU
add wave -noupdate -radix decimal /core_tb/cpu/alu_inst/out
add wave -noupdate -radix decimal /core_tb/cpu/alu_inst/x
add wave -noupdate -radix decimal /core_tb/cpu/alu_inst/y
add wave -noupdate -divider {Data memory}
add wave -noupdate /core_tb/data_memory/load
add wave -noupdate -radix unsigned /core_tb/data_memory/address
add wave -noupdate -radix unsigned /core_tb/data_memory/in
add wave -noupdate -radix unsigned /core_tb/data_memory/ram16/d
add wave -noupdate /core_tb/data_memory/ram16/we
add wave -noupdate -radix unsigned /core_tb/data_memory/ram16/q
add wave -noupdate -radix unsigned /core_tb/data_memory/out
add wave -noupdate -radix unsigned /core_tb/data_memory/r_out
add wave -noupdate -radix unsigned /core_tb/data_memory/ram_q
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[20]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[19]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[18]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[17]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[16]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[15]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[14]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[13]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[12]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[11]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[10]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[9]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[8]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[7]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[6]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[5]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[4]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[3]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[2]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[1]}
add wave -noupdate -radix unsigned {/core_tb/data_memory/ram16/mem[0]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {1320 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 193
configure wave -valuecolwidth 124
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1180 ns} {1460 ns}
