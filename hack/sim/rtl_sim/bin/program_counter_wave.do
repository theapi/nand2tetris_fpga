onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /program_counter_tb/program_counter_DUT/clk
add wave -noupdate /program_counter_tb/program_counter_DUT/reset
add wave -noupdate /program_counter_tb/program_counter_DUT/inc
add wave -noupdate /program_counter_tb/program_counter_DUT/load
add wave -noupdate -radix decimal /program_counter_tb/program_counter_DUT/in
add wave -noupdate -radix decimal /program_counter_tb/program_counter_DUT/out
add wave -noupdate -radix decimal /program_counter_tb/program_counter_DUT/r_out
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
WaveRestoreZoom {0 ns} {530 ns}
