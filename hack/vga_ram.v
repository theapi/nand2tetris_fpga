
/*
 * Example 12-14: Single-Clock Synchronous RAM with Old Data Read‐During‐Write Behavior
 *
 * Quartus II handbook
 * https://www.altera.com/content/dam/altera-www/global/en_US/pdfs/literature/hb/qts/quartusii_handbook.pdf
 *
 */
 
module vga_ram(
    output reg [15:0] q,
    input [15:0] d,
    input [12:0] write_address, read_address,
    input we, clk
);
    // 512 x 256 black-and-white ( / 16 = 8192)
    (* ramstyle = "M9K" *)
    reg [15:0] mem [8191:0] /* synthesis ram_init_file = "screen.mif" */; // 8K 16-bit RAM
    
    always @ (posedge clk) begin
        if (we)
            mem[write_address] <= d;
        q <= mem[read_address]; // q doesn't get d in this clock cycle
    end
    
endmodule
