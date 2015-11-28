/**
 * Frame buffer
 * 800x480 ( / 16 = 24000) for hack screen of 512 x 256
 *
 * Translate pixel positions to ram addresses then uses ram.
 */
 
 module frame_buffer(
    input clk,             // the system clock
    
    input [12:0] write_address,
    input [15:0] data_in,       // what to write (16 pixels, black or white)
    input load,            // write-enable bit
    
    input [7:0] keyboard, // debug the current keypress on the vga
    
    input [10:0] vga_h, // the current vertical pixel count being displayed
    input [10:0] vga_v, // the current horizontal pixel count being displayed
    
    output [2:0] pixel_out    // The requested  pixel value at vga_h x vga_v
 );
 

    
    wire[15:0] read_value;
    wire[4:0] pixel_bit;
    
    wire[12:0] read_address;
    reg[12:0] r_address;
    
    reg [2:0] out;
    
    //wire [15:0] pixel_bit_calc;
    //assign pixel_bit_calc = (vga_h + vga_v);// % 5'd16;
    assign pixel_bit = pixel_bit_calc[3:0];
    
    reg [15:0] pixel_bit_calc;
    reg [10:0] h;
    reg [10:0] v;
    reg [31:0] pixel_addr;
    
    wire [2:0] kb_display_out;
    wire kb_display_on;
    register_display kb_display (.data_in({8'd0, keyboard}), 
      .position_h(11'd10), .position_v(11'd10), 
      .vga_h(vga_h), .vga_v(vga_v), 
      .bg(3'b001), .pixel_out(kb_display_out), .display_on(kb_display_on));

    always @ (*)
    begin
        // black board surrounding the hack screen of 512 x 256 
        // on the 800 x 480 vga screen
        if (vga_h < 11'd144 || vga_h > 11'd655 
         || vga_v < 11'd112 || vga_v > 11'd367) begin
         /*
            // Keyboard debug
            if (vga_v > 11'd10 && vga_v < 11'd16) begin
                if (vga_h > 11'd10 && vga_h < 11'd16) begin
                    out = keyboard[7] ? 3'b100 : 3'b000;
                end else if (vga_h > 11'd20 && vga_h < 11'd26) begin
                    out = keyboard[6] ? 3'b100 : 3'b000;
                end else if (vga_h > 11'd30 && vga_h < 11'd36) begin
                    out = keyboard[5] ? 3'b100 : 3'b000;
                end else if (vga_h > 11'd40 && vga_h < 11'd46) begin
                    out = keyboard[4] ? 3'b100 : 3'b000;
                end else if (vga_h > 11'd50 && vga_h < 11'd56) begin
                    out = keyboard[3] ? 3'b100 : 3'b000;
                end else if (vga_h > 11'd60 && vga_h < 11'd66) begin
                    out = keyboard[2] ? 3'b100 : 3'b000;
                end else if (vga_h > 11'd70 && vga_h < 11'd76) begin
                    out = keyboard[1] ? 3'b100 : 3'b000;
                end else if (vga_h > 11'd80 && vga_h < 11'd86) begin
                    out = keyboard[0] ? 3'b100 : 3'b000;
                end else begin
                    out = 3'b001;
                end
            // Border
            end else begin
                out = 3'b001;
            end
         */
         if (kb_display_on) begin
            out = kb_display_out;
         end else begin
            out = 3'b001;
         end
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
            //out = read_value[pixel_bit];
            if (read_value[pixel_bit]) begin
                out = 3'b111;
            end else begin
                out = 3'b000;
            end
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
    
    
endmodule
