onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /vga_controller_tb/vga_ins/vga_clk
add wave -noupdate /vga_controller_tb/vga_ins/reset
add wave -noupdate /vga_controller_tb/vga_ins/blank_n
add wave -noupdate /vga_controller_tb/vga_ins/HS
add wave -noupdate /vga_controller_tb/vga_ins/VS
add wave -noupdate -radix unsigned /vga_controller_tb/vga_ins/pixel_h
add wave -noupdate -radix unsigned /vga_controller_tb/vga_ins/pixel_v
add wave -noupdate -radix hexadecimal /vga_controller_tb/vga_ins/red
add wave -noupdate -radix hexadecimal /vga_controller_tb/vga_ins/green
add wave -noupdate -radix unsigned /vga_controller_tb/vga_ins/blue
add wave -noupdate /vga_controller_tb/vga_ins/vga_sync/hori_valid
add wave -noupdate /vga_controller_tb/vga_ins/vga_sync/vert_valid
add wave -noupdate -radix unsigned /vga_controller_tb/vga_ins/vga_sync/h_cnt
add wave -noupdate -radix unsigned /vga_controller_tb/vga_ins/vga_sync/v_cnt
add wave -noupdate -radix unsigned /vga_controller_tb/vga_ins/vga_sync/next_pixel_addr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10962090 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 176
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
WaveRestoreZoom {0 ns} {15750 us}
