onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpu_tb/cpu_DUT/clk
add wave -noupdate /cpu_tb/cpu_DUT/reset
add wave -noupdate -radix decimal /cpu_tb/cpu_DUT/inM
add wave -noupdate /cpu_tb/cpu_DUT/instruction
add wave -noupdate -radix unsigned /cpu_tb/cpu_DUT/outM
add wave -noupdate /cpu_tb/cpu_DUT/writeM
add wave -noupdate -radix unsigned /cpu_tb/cpu_DUT/addressM
add wave -noupdate -radix decimal /cpu_tb/cpu_DUT/pc
add wave -noupdate -radix unsigned /cpu_tb/cpu_DUT/ARegister
add wave -noupdate -radix unsigned /cpu_tb/cpu_DUT/DRegister
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {60 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ns} {160 ns}
