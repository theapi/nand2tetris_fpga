/**
 * Frame buffer
 * 800x480 ( / 16 = 24000) for hack screen of 512 x 256
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
    
    input [12:0] write_address;
    input [15:0] data_in;       // what to write (16 pixels, black or white)
    input load;            // write-enable bit
    
    input [10:0] vga_h; // the current vertical pixel count being displayed
    input [10:0] vga_v; // the current horizontal pixel count being displayed
    
    output pixel_out;            // The requested  pixel value at vga_h x vga_v
    
    wire[15:0] read_value;
    wire[4:0] pixel_bit;
    
    wire[12:0] read_address;
    reg[12:0] r_address;
    
    reg out;
    
    wire [10:0] pixel_bit_calc;
    assign pixel_bit_calc = (vga_h + vga_h) % 5'd16;
    assign pixel_bit = pixel_bit_calc[4:0];
    
    
    always @ (vga_h or vga_v or read_value or pixel_bit)
    begin
        // black board surrounding the hack screen of 512 x 256 
        // on the 800 x 480 vga screen
        if (vga_h > 511) begin
            out = 0;
            r_address = 0;
        end
        else if (vga_v > 255) begin
            out = 0;
            r_address = 0;
        end
        else begin
            r_address = (vga_h + (vga_v * 13'd512) ) / 13'd16;
            out = read_value[pixel_bit];
        end
    end
    
    assign read_address = r_address;
    assign pixel_out = out;
    
    
    vga_ram vgaram(
        .q(read_value), // from ram
        .d(data_in), // to ram
        .write_address(write_address), // where to write in ram
        .read_address(read_address), // where to read from
        .we(load), // do a write
        .clk(clk)
    );
    
    /*
    ram_m9k vgaram(
        .clock(clk),
        .data(data_in),
        .rdaddress(read_address),
        .wraddress(write_address),
        .wren(load),
        .q(read_value)
    );
    */

    
endmodule
