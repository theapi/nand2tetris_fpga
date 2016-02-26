module vga_controller(
    input reset,
    input sys_clk,
    input vga_clk,
    output blank_n,
    output HS,
    output VS,
    output [7:0] red,
    output [7:0] green,  
    output [7:0] blue
);

    wire [10:0] pixel_h;
    wire [10:0] pixel_v;
    reg [7:0] r_red;
    reg [7:0] r_green;
    reg [7:0] r_blue;
    
    wire [31:0] next_pixel_addr;

    vga_sync_generator vga_sync(
        .reset(reset),
        .vga_clk(vga_clk),
        .blank_n(blank_n),
        .next_pixel_h(pixel_h),
        .next_pixel_v(pixel_v),
        .next_pixel_addr(next_pixel_addr),
        .HS(HS),
        .VS(VS)
    );

    
    always@(posedge vga_clk) begin
        // Only set pixel colours when in the visible display area.
        if (blank_n) begin
            // Draw a single square.
            if (pixel_h >= 100 && pixel_h <= 200 && pixel_v >= 100 && pixel_v <= 200) begin
                // #FF4500
                r_red   <= 8'hFF;
                r_green <= 8'h45;
                r_blue  <= 8'h0;
            end 
            else begin
                // #228B22
                r_red   <= 8'h22;
                r_green <= 8'h8B;
                r_blue  <= 8'h22;
            end
        end
    end
    
    assign red   = r_red;
    assign green = r_green;
    assign blue  = r_blue;
    
    
endmodule
    