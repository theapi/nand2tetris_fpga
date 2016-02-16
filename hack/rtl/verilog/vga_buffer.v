module vga_buffer (
    output reg [14:0] q,
    input [14:0] d,
    input clk, pixel_clk
);

    reg [14:0] mem = 0;
    reg [15:0] delay = 16'd0;
    
    always @ (posedge clk) begin
        if (delay == 16'd8192) begin
            mem <= d;
        end else begin
            delay <= delay + 16'b1;
        end
    end
    
    
    always @ (posedge pixel_clk) begin
        q <= mem;
    end
    
endmodule
