module ram_16(
    output reg [15:0] q,
    input [15:0] d,
    input [13:0] write_address, read_address,
    input we, clk
);
    //(* ramstyle = "M9K" *)
    reg [15:0] mem [16383:0] /* synthesis ram_init_file = "mif/ram_16.mif" */; // 16K 16-bit RAM
    //reg [15:0] mem [16383:0]; // 16K 16-bit RAM -- NOT M9K
    
    always @ (posedge clk) begin
        if (we)
            mem[write_address] = d;
        q = mem[read_address]; // q does get d in this clock cycle
    end
    
endmodule
