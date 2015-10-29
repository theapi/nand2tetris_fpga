`include "../Screen_export.v"

`timescale 10ns/10ns
module Screen_export_tb();
   
	// Declare inputs as regs and outputs as wires
	reg clk;
    reg[0:0]  rst;

	wire red;
	wire green;
    wire blue;
    wire hsync;
    wire vsync;
    
    Screen_export DUT(
        .CLOCK_50(clk) ,	// input  CLOCK_50_sig
        .RESET(rst) ,	// input [0]:EY[0]] KEY_sig
        .VGA_RED(red) ,	// output  VGA_RED_sig
        .VGA_GREEN(green) ,	// output  VGA_GREEN_sig
        .VGA_BLUE(blue) ,	// output  VGA_BLUE_sig
        .VGA_HSYNC(hsync) ,	// output  VGA_HSYNC_sig
        .VGA_VSYNC(vsync) 	// output  VGA_VSYNC_sig
    );

/*
input wire	RESET;
input wire	CLOCK_50;
output wire	VGA_VSYNC;
output wire	VGA_HSYNC;
output wire	VGA_BLUE;
output wire	VGA_GREEN;
output wire	VGA_RED;

*/
	// Initialize all variables
	initial begin        


        clk = 1;
        rst = 0;

        #2
        rst = 1;

	//#2
        //rst = 0;
        
        //#110
        //$stop;      // Terminate simulation

	end

    always begin
        #1 clk = !clk;
    end
	
endmodule
