/**
 * In the Hack platform,
 * the screen is implemented as an 8K 16-bit RAM chip.
 *
 * 256 by 512 black-and-white
 *
 */
 
 module Screen(
    clk,
    in,
    load,
    address
 );
 
    input clk;             // the system clock
    input [15:0] in;       // what to write
    input load;            // write-enable bit
    input [15:0] address;  // where to read/write

    wire[15:0] q;            // what's being written to ram
    wire[15:0] read_address; // same address as the write
    assign read_address = address;

    // Dedicated module to ensure fpga ram is used rather than logic units.
    vga_ram vgaram(
        .q(q), // from ram
        .d(in), // to ram
        .write_address(address), // where to write in ram
        .read_address(read_address), // where to read from
        .we(load), // do a write
        .clk(clk)
    );
    
endmodule
