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
    input [14:0] pc, // debug the current program count on the vga
    input [15:0] instruction, // debug the current instruction register on the vga
    input [15:0] data_register, // debug the current instruction register on the vga
    
    input [10:0] vga_h, // the current vertical pixel count being displayed
    input [10:0] vga_v, // the current horizontal pixel count being displayed
    
    output [2:0] pixel_out    // The requested  pixel value at vga_h x vga_v
 );
 
    wire[15:0] read_value;
    wire[12:0] read_address;
    reg [2:0] out;

    wire[4:0] pixel_bit;
    wire [15:0] pixel_bit_calc;
    wire [31:0] pixel_addr;
    assign pixel_addr = ((vga_h - 11'd144) + ((vga_v - 11'd112) * 32'd512)) >> 4;
    assign pixel_bit_calc = (vga_h - 11'd144) + (vga_v - 11'd112);
    assign pixel_bit = pixel_bit_calc[3:0];
    assign read_address = pixel_addr[12:0];
    
    assign pixel_out = out;
    
    // Screen ram
    vga_ram vgaram(
        .q(read_value), // from ram
        .d(data_in), // to ram
        .write_address(write_address), // where to write in ram
        .read_address(read_address), // where to read from
        .we(load), // do a write
        .clk(clk)
    );
    
    // Keyboard debug
    wire [2:0] kb_display_out;
    wire kb_display_on;
    register_display #(.START_H(11'd10), .START_V(11'd10)) kb_display (
        .clk(clk), .data_in({8'd0, keyboard}),
        .vga_h(vga_h), .vga_v(vga_v),
        .bg(3'b001), .pixel_out(kb_display_out), .display_on(kb_display_on)
    );
    
    // program counter debug
    wire [2:0] pc_display_out;
    wire pc_display_on;
    register_display #(.START_H(11'd10), .START_V(11'd20)) pc_display (
        .clk(clk), .data_in(pc),
        .vga_h(vga_h), .vga_v(vga_v),
        .bg(3'b001), .pixel_out(pc_display_out), .display_on(pc_display_on)
    );
    
    // Instruction debug
    wire [2:0] instruction_display_out;
    wire instruction_display_on;
    register_display #(.START_H(11'd10), .START_V(11'd30)) instruction_display (
        .clk(clk), .data_in(instruction),
        .vga_h(vga_h), .vga_v(vga_v),
        .bg(3'b001), .pixel_out(instruction_display_out), .display_on(instruction_display_on)
    );
    
    
    // data_register debug
    wire [2:0] data_register_display_out;
    wire data_register_display_on;
    register_display #(.START_H(11'd10), .START_V(11'd40)) data_register_display (
        .clk(clk), .data_in(data_register),
        .vga_h(vga_h), .vga_v(vga_v),
        .bg(3'b001), .pixel_out(data_register_display_out), .display_on(data_register_display_on)
    );

    

      
    always @ (posedge clk) begin
        // border surrounding the hack screen of 512 x 256 
        // on the 800 x 480 vga screen
        if (vga_h < 11'd144 || vga_h > 11'd655 
        || vga_v < 11'd112 || vga_v > 11'd367) begin
            if (kb_display_on) begin
                out <= kb_display_out;
            end else if (instruction_display_on) begin
                out <= instruction_display_out;
            end else if (data_register_display_on) begin
                out <= data_register_display_out;
            end else if (pc_display_on) begin
                out <= pc_display_out;
            end else begin
                out <= 3'b001;
            end
        end else begin
        // hack screen contents from the screen ram
            if (read_value[pixel_bit]) begin
                out <= 3'b111;
            end else begin
                out <= 3'b000;
            end
        end
    end

endmodule
