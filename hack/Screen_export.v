// Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, the Altera Quartus II License Agreement,
// the Altera MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Altera and sold by Altera or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 15.0.2 Build 153 07/15/2015 SJ Web Edition"
// CREATED		"Sat Oct 31 17:23:50 2015"

module Screen_export(
	RESET,
	CLOCK_50,
	VGA_VSYNC,
	VGA_HSYNC,
	VGA_BLUE,
	VGA_GREEN,
	VGA_RED
);


input wire	RESET;
input wire	CLOCK_50;
output wire	VGA_VSYNC;
output wire	VGA_HSYNC;
output wire	VGA_BLUE;
output wire	VGA_GREEN;
output wire	VGA_RED;

wire	SYNTHESIZED_WIRE_0;
wire	[15:0] SYNTHESIZED_WIRE_1;
wire	[10:0] SYNTHESIZED_WIRE_2;
wire	[10:0] SYNTHESIZED_WIRE_3;
wire	[12:0] SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_7;





frame_buffer	b2v_inst(
	.clk(CLOCK_50),
	.load(SYNTHESIZED_WIRE_0),
	.data_in(SYNTHESIZED_WIRE_1),
	.vga_h(SYNTHESIZED_WIRE_2),
	.vga_v(SYNTHESIZED_WIRE_3),
	.write_address(SYNTHESIZED_WIRE_4),
	.pixel_out(SYNTHESIZED_WIRE_7));


clock_25	b2v_inst1(
	.CLOCK_50(CLOCK_50),
	.CLOCK_25(SYNTHESIZED_WIRE_5));

assign	SYNTHESIZED_WIRE_9 =  ~RESET;


vga_driver	b2v_inst3(
	.CLOCK_PIXEL(SYNTHESIZED_WIRE_5),
	.RESET(SYNTHESIZED_WIRE_9),
	.PIXEL(SYNTHESIZED_WIRE_7),
	.VGA_RED(VGA_RED),
	.VGA_GREEN(VGA_GREEN),
	.VGA_BLUE(VGA_BLUE),
	.VGA_HS(VGA_HSYNC),
	.VGA_VS(VGA_VSYNC),
	.PIXEL_H(SYNTHESIZED_WIRE_2),
	.PIXEL_V(SYNTHESIZED_WIRE_3));


screen_init	b2v_inst4(
	.clk(CLOCK_50),
	.reset(SYNTHESIZED_WIRE_9),
	.load(SYNTHESIZED_WIRE_0),
	.address(SYNTHESIZED_WIRE_4),
	.out(SYNTHESIZED_WIRE_1));


endmodule