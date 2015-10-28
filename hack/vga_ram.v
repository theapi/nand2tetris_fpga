
/*
 * Example 12-13: Verilog HDL Single-Clock Simple Dual-Port Synchronous RAM 
 * with New Data Read-During-Write Behavior
 *
 * Quartus II handbook
 * https://www.altera.com/content/dam/altera-www/global/en_US/pdfs/literature/hb/qts/quartusii_handbook.pdf
 *
 */
 
module vga_ram(
    output reg [15:0] q,
    input [15:0] d,
    input [15:0] write_address, read_address,
    input we, clk
);
    // 512 x 256 black-and-white ( / 16 = 8192)
    reg [15:0] mem [8192:0]; // 8K 16-bit RAM
    
    
    // 800x480 ( / 16 = 24000)
    //reg [15:0] mem [24000:0];
    
    /*
    // initialize ram as per quartusii_handbook.pdf
    integer i;
    initial begin
        for (i = 0; i < 4000; i = i + 1)
            mem[i] = i[15:0];
        for (i = 4000; i < 8193; i = i + 1)
            mem[i] = i[15:0];
    end
    */
    
    
    always @ (posedge clk) begin
        if (we)
            mem[write_address] = d;
        q = mem[read_address]; // q does get d in this clock cycle if we is high
    end
    
endmodule
