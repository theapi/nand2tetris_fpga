onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /alu_tb/alu_DUT/x
add wave -noupdate -radix binary /alu_tb/alu_DUT/y
add wave -noupdate -radix binary /alu_tb/alu_DUT/zx
add wave -noupdate -radix binary /alu_tb/alu_DUT/nx
add wave -noupdate -radix binary /alu_tb/alu_DUT/zy
add wave -noupdate -radix binary /alu_tb/alu_DUT/ny
add wave -noupdate -radix binary /alu_tb/alu_DUT/f
add wave -noupdate -radix binary /alu_tb/alu_DUT/no
add wave -noupdate -radix binary /alu_tb/alu_DUT/out
add wave -noupdate -radix binary /alu_tb/alu_DUT/zr
add wave -noupdate -radix binary /alu_tb/alu_DUT/ng
add wave -noupdate -radix binary /alu_tb/alu_DUT/r_x
add wave -noupdate -radix binary /alu_tb/alu_DUT/r_y
add wave -noupdate -radix binary /alu_tb/alu_DUT/r_out
add wave -noupdate -radix binary /alu_tb/alu_DUT/r_zr
add wave -noupdate -radix binary /alu_tb/alu_DUT/r_ng
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ns} {1 us}
