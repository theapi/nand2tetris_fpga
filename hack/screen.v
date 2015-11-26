/**
 * Populates the frame buffer.
 */

 module screen(
    clk,
    reset,
    address,
    out,
    load
 );
 
    input clk;
    input reset;
    output load; 
    output [12:0] address; // ram address to write the pixel data
    output [15:0] out;     // pixel values for ram address in the buffer

    
    assign load = 0;
    assign address = 0;
    assign out = 0;
    
endmodule
