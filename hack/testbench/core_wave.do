onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /core_tb/clk
add wave -noupdate /core_tb/reset
add wave -noupdate /core_tb/inM
add wave -noupdate /core_tb/instruction
add wave -noupdate -radix binary /core_tb/outM
add wave -noupdate /core_tb/writeM
add wave -noupdate /core_tb/addressM
add wave -noupdate -radix decimal /core_tb/pc
add wave -noupdate /core_tb/screen_address
add wave -noupdate /core_tb/screen_data
add wave -noupdate /core_tb/screen_we
add wave -noupdate -radix decimal /core_tb/areg
add wave -noupdate -radix decimal /core_tb/dreg
add wave -noupdate -divider ALU
add wave -noupdate /core_tb/cpu/alu_inst/x
add wave -noupdate /core_tb/cpu/alu_inst/y
add wave -noupdate /core_tb/cpu/alu_inst/zx
add wave -noupdate /core_tb/cpu/alu_inst/nx
add wave -noupdate /core_tb/cpu/alu_inst/zy
add wave -noupdate /core_tb/cpu/alu_inst/ny
add wave -noupdate /core_tb/cpu/alu_inst/f
add wave -noupdate /core_tb/cpu/alu_inst/no
add wave -noupdate /core_tb/cpu/alu_inst/out
add wave -noupdate /core_tb/cpu/alu_inst/zr
add wave -noupdate /core_tb/cpu/alu_inst/ng
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {200 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 208
configure wave -valuecolwidth 100
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
WaveRestoreZoom {40 ns} {360 ns}
