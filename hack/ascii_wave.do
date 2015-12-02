onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ascii_tb/ascii_DUT/clk
add wave -noupdate -radix ascii /ascii_tb/ascii_DUT/ascii
add wave -noupdate /ascii_tb/ascii_DUT/extended
add wave -noupdate -radix ascii /ascii_tb/ascii_DUT/r_ascii
add wave -noupdate -radix hexadecimal /ascii_tb/ascii_DUT/scan_code
add wave -noupdate /ascii_tb/ascii_DUT/keyup
add wave -noupdate /ascii_tb/ascii_DUT/scan_ready
add wave -noupdate -expand /ascii_tb/ascii_DUT/scan_ready_edge_detect
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {620 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 181
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
WaveRestoreZoom {0 ns} {2100 ns}
