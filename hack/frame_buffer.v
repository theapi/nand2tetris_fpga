/**
 * Frame buffer
 * 256 by 512 black-and-white ( / 16 = 8192)
 *
 * Translate pixel positions to ram addresses then reads the ram.
 */
 
 module frame_buffer(
    clk,
    vga_h,
    vga_v,
    pixel_out
 );
 
    input clk; // the system clock
    input [10:0] vga_h; // the current vertical pixel count being displayed
    input [10:0] vga_v; // the current horizontal pixel count being displayed
    
    output pixel_out;  // The requested  pixel value at vga_h x vga_v
    
    wire[15:0] read_value;
    wire[4:0] pixel_bit;
    
    wire[15:0] write_address;
    wire[15:0] read_address;
    wire[15:0] data_in;
    wire load;
    
    // Ram address derived from pixel position.
    assign read_address = (vga_h + (vga_v * 800) ) / 16;
    assign pixel_bit = (vga_h + vga_v) % 16;
    assign pixel_out = read_value[pixel_bit];
    
    assign write_address = read_address; // just needs a value, this never writes.
    assign data_in = 0;
    assign load = 0; // never write to ram
    
    vga_ram vgaram(
        .q(read_value), // from ram
        .d(data_in), // to ram
        .write_address(write_address), // where to write in ram
        .read_address(read_address), // where to read from
        .we(load), // do a write
        .clk(clk)
    );

endmodule
