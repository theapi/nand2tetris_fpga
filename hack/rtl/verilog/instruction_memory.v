
/**
 *  8K (not 32K need to learn how to use the sdram) 16-bit RAM where the the program to run is stored. 
 * It's a ROM in nand2tetris.
 */
 
module instruction_memory(
    output reg [15:0] q,
    input [15:0] d,
    input [14:0] write_address, read_address,
    input we, clk
);
    //(* ramstyle = "M9K" *)
    //reg [15:0] mem [32767:0] /* synthesis ram_init_file = "program.mif" */; // 32K 16-bit RAM
    
    // 32k is too much for internal ram on cyclone IV
    //reg [15:0] mem [16383:0] /* synthesis ram_init_file = "program.mif" */; // 16K 16-bit RAM
    
    // 8K 16-bit RAM
    //reg [15:0] mem [8191:0] /* synthesis ram_init_file = "programs/Rect.mif" */; 
    reg [15:0] mem [8191:0] /* synthesis ram_init_file = "programs/Fill.mif" */;
    
    always @ (posedge clk) begin
        if (we)
            mem[write_address] <= d;
        q <= mem[read_address]; // q doesn't get d in this clock cycle
    end
    
endmodule
