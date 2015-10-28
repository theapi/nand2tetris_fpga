/**
 * Frame buffer
 * 800x480 ( / 16 = 24000)
 *
 * Translate pixel positions to ram addresses then uses ram.
 */
 
 module frame_buffer(
    clk,
    write_address,
    data_in,
    load,
    vga_h,
    vga_v,
    pixel_out
 );
 
    input clk;             // the system clock
    
    input [15:0] write_address;
    input [15:0] data_in;       // what to write (16 pixels, black or white)
    input load;            // write-enable bit
    
    input [10:0] vga_h; // the current vertical pixel count being displayed
    input [10:0] vga_v; // the current horizontal pixel count being displayed
    
    output pixel_out;            // The requested  pixel value at vga_h x vga_v
    
    wire[15:0] read_value;
    wire[4:0] pixel_bit;
    
    wire[15:0] read_address;
     
    assign read_address = (vga_h + (vga_v * 800) ) / 16;
    assign pixel_bit = (vga_h + vga_v) % 16;
    assign pixel_out = read_value[pixel_bit];

    
    
    vga_ram vgaram(
        .q(read_value), // from ram
        .d(data_in), // to ram
        .write_address(write_address), // where to write in ram
        .read_address(read_address), // where to read from
        .we(load), // do a write
        .clk(clk)
    );

    
endmodule
