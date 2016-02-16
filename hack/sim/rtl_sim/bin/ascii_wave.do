onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ascii_tb/ascii_DUT/clk
add wave -noupdate -radix ascii /ascii_tb/ascii_DUT/ascii
add wave -noupdate /ascii_tb/ascii_DUT/extended
add wave -noupdate -radix ascii /ascii_tb/ascii_DUT/r_ascii
add wave -noupdate -radix hexadecimal /ascii_tb/ascii_DUT/scan_code
add wave -noupdate -radix hexadecimal /ascii_tb/ascii_DUT/code
add wave -noupdate /ascii_tb/ascii_DUT/scan_ready
add wave -noupdate /ascii_tb/ascii_DUT/scan_ready_edge_detect
add wave -noupdate /ascii_tb/ascii_DUT/caps
add wave -noupdate /ascii_tb/ascii_DUT/caps_lock
add wave -noupdate /ascii_tb/ascii_DUT/shift
add wave -noupdate -radix hexadecimal -childformat {{{/ascii_tb/ascii_DUT/key_code[2]} -radix hexadecimal} {{/ascii_tb/ascii_DUT/key_code[1]} -radix hexadecimal} {{/ascii_tb/ascii_DUT/key_code[0]} -radix hexadecimal}} -expand -subitemconfig {{/ascii_tb/ascii_DUT/key_code[2]} {-height 15 -radix hexadecimal} {/ascii_tb/ascii_DUT/key_code[1]} {-height 15 -radix hexadecimal} {/ascii_tb/ascii_DUT/key_code[0]} {-height 15 -radix hexadecimal}} /ascii_tb/ascii_DUT/key_code
add wave -noupdate -radix unsigned /ascii_tb/ascii_DUT/key_mem_index
add wave -noupdate -radix unsigned /ascii_tb/ascii_DUT/key_current_index
add wave -noupdate /ascii_tb/ascii_DUT/key_clear
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2710 ns} 0}
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
WaveRestoreZoom {0 ns} {7350 ns}
