
##
## DEVICE  "EP4CE22F17C7"
##

set_time_format -unit ns -decimal_places 3

create_clock -name {CLOCK_50} -period 20.000 -waveform { 0.000 0.500 } [get_ports {CLOCK_50}]

create_generated_clock -name {clk_25} -source [get_ports {CLOCK_50}] -divide_by 2 -master_clock {CLOCK_50} [get_registers {vga_clock:pixel_clock|clk_25}] 

derive_clock_uncertainty
