
module computer(
	RESET,
	CLOCK_50,
	PS2_CLK,
	PS2_DAT,
	VGA_HS,
	VGA_VS,
	VGA_BLANK_N,
	VGA_CLK,
	LED,
	VGA_B,
	VGA_G,
	VGA_R
);


input wire	RESET;
input wire	CLOCK_50;
input wire	PS2_CLK;
input wire	PS2_DAT;
output wire	VGA_HS;
output wire	VGA_VS;
output wire	VGA_BLANK_N;
output wire	VGA_CLK;
output wire	[7:0] LED;
output wire	[7:0] VGA_B;
output wire	[7:0] VGA_G;
output wire	[7:0] VGA_R;

wire	scan_ready;
wire	[7:0] scan_code;
wire	w_reset;
wire	[15:0] SYNTHESIZED_WIRE_31;
wire	[15:0] SYNTHESIZED_WIRE_32;
wire	SYNTHESIZED_WIRE_5;
wire	[14:0] SYNTHESIZED_WIRE_6;
wire	[15:0] SYNTHESIZED_WIRE_7;
wire	[7:0] SYNTHESIZED_WIRE_33;
wire	[12:0] SYNTHESIZED_WIRE_9;
wire	[15:0] SYNTHESIZED_WIRE_11;
wire	[15:0] SYNTHESIZED_WIRE_13;
wire	[14:0] SYNTHESIZED_WIRE_34;
wire	[15:0] SYNTHESIZED_WIRE_17;
wire	[10:0] SYNTHESIZED_WIRE_18;
wire	[10:0] SYNTHESIZED_WIRE_19;
wire	memory_ready;
wire	memory_ready_n;
wire	reset_n;
wire	clk_25;
wire	[23:0] SYNTHESIZED_WIRE_28;

assign VGA_CLK = clk_25;
assign reset_n = ~RESET;
assign memory_ready_n = ~memory_ready;
assign w_reset = memory_ready_n | reset_n;

clock_25 pixel_clock(
	.CLOCK_50(CLOCK_50),
	.CLOCK_25(clk_25));

    
ps2decoder kb_decoder(
	.reset(w_reset),
	.i_clock(PS2_CLK),
	.i_data(PS2_DAT),
	.scan_ready(scan_ready),
	.scan_code(scan_code));
    
    
ascii b2v_ascii(
	.clk(CLOCK_50),
	.scan_ready(scan_ready),
	.scan_code(scan_code),
	.ascii(SYNTHESIZED_WIRE_33));


cpu	b2v_cpu_inst(
	.clk(CLOCK_50),
	.reset(w_reset),
	.inM(SYNTHESIZED_WIRE_31),
	.instruction(SYNTHESIZED_WIRE_32),
	.writeM(SYNTHESIZED_WIRE_5),
	.addressM(SYNTHESIZED_WIRE_6),
	.areg(SYNTHESIZED_WIRE_11),
	.dreg(SYNTHESIZED_WIRE_13),
	.outM(SYNTHESIZED_WIRE_7),
	.pc(SYNTHESIZED_WIRE_34));


memory b2v_data_memory(
	.clk(CLOCK_50),
	.load(SYNTHESIZED_WIRE_5),
	.address(SYNTHESIZED_WIRE_6),
	.in(SYNTHESIZED_WIRE_7),
	.keyboard(SYNTHESIZED_WIRE_33),
	.screen_read_address(SYNTHESIZED_WIRE_9),
	.ready(memory_ready),
	.out(SYNTHESIZED_WIRE_31),
	.read_value(SYNTHESIZED_WIRE_17));


leds b2v_debug_leds(
	.count(scan_code),
	.led_0(LED[0]),
	.led_1(LED[1]),
	.led_2(LED[2]),
	.led_3(LED[3]),
	.led_4(LED[4]),
	.led_5(LED[5]),
	.led_6(LED[6]),
	.led_7(LED[7]));


frame_buffer b2v_fb(
	.clk(CLOCK_50),
	.areg(SYNTHESIZED_WIRE_11),
	.data_register(SYNTHESIZED_WIRE_31),
	.dreg(SYNTHESIZED_WIRE_13),
	.instruction(SYNTHESIZED_WIRE_32),
	.keyboard(SYNTHESIZED_WIRE_33),
	.pc(SYNTHESIZED_WIRE_34),
	.read_value(SYNTHESIZED_WIRE_17),
	.vga_h(SYNTHESIZED_WIRE_18),
	.vga_v(SYNTHESIZED_WIRE_19),
	.pixel_out(SYNTHESIZED_WIRE_28),
	.read_address(SYNTHESIZED_WIRE_9));


instruction_memory b2v_program_memory(
	.clk(CLOCK_50),
	.read_address(SYNTHESIZED_WIRE_34),
	.q(SYNTHESIZED_WIRE_32));

vga_controller b2v_vga(
	.reset(w_reset),
	.sys_clk(w_reset),
	.vga_clk(VGA_CLK),
	.pixel(SYNTHESIZED_WIRE_28),
	.blank_n(VGA_BLANK_N),
	.HS(VGA_HS),
	.VS(VGA_VS),
	.blue(VGA_B),
	.green(VGA_G),
	
	.next_pixel_h(SYNTHESIZED_WIRE_18),
	.next_pixel_v(SYNTHESIZED_WIRE_19),
	.red(VGA_R));


endmodule
