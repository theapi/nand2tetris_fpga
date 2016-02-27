module vga_controller(
    input reset,
    input sys_clk,
    input vga_clk,
    input [23:0] pixel,
    output blank_n,
    output HS,
    output VS,
    output [10:0] next_pixel_h,
    output [10:0] next_pixel_v,
    output [31:0] next_pixel_addr,
    output [7:0] red,
    output [7:0] green,  
    output [7:0] blue
);

    reg [7:0] r_red;
    reg [7:0] r_green;
    reg [7:0] r_blue;
    

    vga_sync_generator vga_sync(
        .reset(reset),
        .vga_clk(vga_clk),
        .blank_n(blank_n),
        .next_pixel_h(next_pixel_h),
        .next_pixel_v(next_pixel_v),
        .next_pixel_addr(next_pixel_addr),
        .HS(HS),
        .VS(VS)
    );

    
    always@(posedge vga_clk) begin
        // Only set pixel colours when in the visible display area.
        if (blank_n) begin
            // Draw the pixel.
            r_red   <= pixel[23:16];
            r_green <= pixel[15:8];
            r_blue  <= pixel[7:0];
        end else begin
            r_red   <= 8'h0;
            r_green <= 8'h0;
            r_blue  <= 8'h0;
        end
    end
    
    assign red   = r_red;
    assign green = r_green;
    assign blue  = r_blue;
    
    
endmodule
    