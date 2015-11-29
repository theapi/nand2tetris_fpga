module ram_8(
    output reg [15:0] q,
    input [15:0] d,
    input [13:0] write_address, read_address,
    input we, clk
);
    //(* ramstyle = "M9K" *)
    reg [15:0] mem [8191:0];
    
    always @ (posedge clk) begin
        if (we)
            mem[write_address] <= d;
        q <= mem[read_address]; // q doesn't get d in this clock cycle
    end
    
endmodule
