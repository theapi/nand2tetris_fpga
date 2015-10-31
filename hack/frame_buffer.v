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
    
    //wire [15:0] pixel_bit_calc;
    //assign pixel_bit_calc = (vga_h + vga_v);// % 5'd16;
    assign pixel_bit = pixel_bit_calc[3:0];
    
    reg [15:0] pixel_bit_calc;
    reg [10:0] h;
    reg [10:0] v;
    reg [31:0] pixel_addr;
    
    always @ (*)
    begin
        // black board surrounding the hack screen of 512 x 256 
        // on the 800 x 480 vga screen
        if (vga_h < 11'd144 || vga_h > 11'd655 
         || vga_v < 11'd112 || vga_v > 11'd367) begin
            out = 0;
            r_address = 0;
            h = 0;
            v = 0;
            pixel_addr = 0;
            pixel_bit_calc = 0;
        end
        else begin
            // hack screen contents
            //r_address = ( (vga_h - 144) + ( (vga_v - 112) * 512) ) >> 4; // >> 4 is divide by 16
            h = vga_h - 11'd144;
            v = vga_v - 11'd112;
            pixel_addr = (h + (v * 32'd512)) >> 4;
            r_address = pixel_addr[12:0];
            pixel_bit_calc = h + v;
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
