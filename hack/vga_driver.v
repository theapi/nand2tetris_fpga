
/*
 * VGA 800x480 screen
 * Black & White
 *
 * The screen I'm using
 * http://www.amazon.co.uk/gp/product/B00IR5VRS4?psc=1&redirect=true&ref_=oh_aui_detailpage_o00_s01
 */
 
module vga_driver
    (
        CLOCK_PIXEL,
        RESET,
        PIXEL,
        PIXEL_H,
        PIXEL_V,
        VGA_RED,
        VGA_GREEN,
        VGA_BLUE,
        VGA_HS,
        VGA_VS
    );
    input CLOCK_PIXEL;
    input RESET;
    input PIXEL; // black (0) or white (1)
    output [10:0] PIXEL_H;
    output [10:0] PIXEL_V;
    output VGA_RED;
    output VGA_GREEN;
    output VGA_BLUE;
    output VGA_HS;
    output VGA_VS;

    /* Internal registers for horizontal signal timing */
    reg [10:0] hor_reg; // to count up to 975
    reg [10:0] hor_pixel; // the next pixel
    reg hor_sync;
    wire hor_max = (hor_reg == 975); // to tell when a line is full

    /* Internal registers for vertical signal timing */
    reg [9:0] ver_reg; // to count up to 527
    reg [10:0] ver_pixel; // the next pixel
    reg ver_sync;
    reg red, green, blue;
    wire ver_max = (ver_reg == 527); // to tell when a line is full


    // Track the pixel count
    always @ (posedge CLOCK_PIXEL or posedge RESET) begin

        if (RESET) begin 
            hor_reg <= 0;
            ver_reg <= 0;
        end
        else if (hor_max) begin
            hor_reg <= 0;

            // end of screen
            if (ver_max) begin
                ver_reg <= 0;
            end else begin
                ver_reg <= ver_reg + 1'b1;
            end
        end else begin
            hor_reg <= hor_reg + 1'b1;
        end

    end
    
    always @ (posedge CLOCK_PIXEL or posedge RESET) begin
    
        if (RESET) begin 
            hor_sync <= 0;
            ver_sync <= 0;
            
            red <= 0;
            green <= 0;
            blue <= 0;
            
            hor_pixel <= 0;
            ver_pixel <= 0;
        end
        else begin

            // Generating the horizontal sync signal 
            if (hor_reg == 840) begin          // video (800) + front porch (40)
                hor_sync <= 1;                 // turn on horizontal sync pulse
            end else if (hor_reg == 928) begin // video (800) + front porch (40) + Sync Pulse (88)
                hor_sync <= 0;                 // turn off horizontal sync pulse
            end
            
            // Generating the vertical sync signal 
            if (ver_reg == 493) begin          // LINES: video (480) +  front porch (13)
                ver_sync <= 1;                 // turn on vertical sync pulse
            end else if (ver_reg == 496) begin // LINES: video (480) + front porch (13) + Sync Pulse (3)
                ver_sync <= 0;                 // turn off vertical sync pulse
            end
                
            // black during the porches
            if (ver_reg > 480 || hor_reg > 800) begin
                red <= 0;
                green <= 0;
                blue <= 0;
                
                if (ver_reg > 480) begin
                    ver_pixel <= 0;
                end 
                if (hor_reg > 800) begin
                    hor_pixel <= 0;
                end 
                
            end
            
            else begin
                hor_pixel <= hor_reg;
                ver_pixel <= ver_reg;
                
                
                // Draw the pixel.
                if (PIXEL) begin
                    // white
                    red <= 1;
                    green <= 1;
                    blue <= 1;
                end 
                else begin
                    // black
                    red <= 0;
                    green <= 0;
                    blue <= 0;
                end
                

            end
        end
    end

    // Send the sync signals to the output.
    assign VGA_HS = hor_sync;
    assign VGA_VS = ver_sync;
 
    assign VGA_RED =  red;
    assign VGA_GREEN = green;
    assign VGA_BLUE = blue;
    
    assign PIXEL_H = hor_pixel;
    assign PIXEL_V = ver_pixel;
    
endmodule
