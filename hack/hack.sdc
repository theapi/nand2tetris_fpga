
##
## DEVICE  "EP4CE22F17C7"
##

set_time_format -unit ns -decimal_places 3

create_clock -name {CLOCK_50} -period 20.000 -waveform { 0.000 0.500 } [get_ports {CLOCK_50}]
create_clock -name {PS2_CLOCK} -period 80.000 -waveform { 0.000 40.000 } [get_ports {PS2_CLOCK}]

create_generated_clock -name {clk_25} -source [get_ports {CLOCK_50}] -divide_by 2 -master_clock {CLOCK_50} [get_registers {clock_25:pixel_clock|clk}] 

derive_clock_uncertainty
