 module register_display(

    input [15:0] data_in,  // the value of the register to show
    
	 input [10:0] position_h, // where this should appear on the screen
    input [10:0] position_v,
    input [10:0] vga_h, // the current vertical pixel count being displayed
    input [10:0] vga_v, // the current horizontal pixel count being displayed
    input [2:0] bg, // the colour of the background pixel
    output [2:0] pixel_out,    // The requested  pixel value at vga_h x vga_v
    output display_on
 );
 
   reg [2:0] out = 0;
   assign pixel_out = out;
   reg on = 0;
   assign display_on = on;
 
 
	always @ (*) begin
      on = 1'b0;
      out = bg;
      if (vga_v > position_v + 11'd10 && vga_v < position_v + 11'd16) begin
         if (vga_h > position_h + 11'd10 && vga_h < position_h + 11'd86) begin
            on = 1'b1;
             if (vga_h > position_h + 11'd10 && vga_h < position_h + 11'd16) begin
                 out = data_in[7] ? 3'b100 : 3'b000;
             end else if (vga_h > position_h + 11'd20 && vga_h < position_h + 11'd26) begin
                 out = data_in[6] ? 3'b100 : 3'b000;
             end else if (vga_h > position_h + 11'd30 && vga_h < position_h + 11'd36) begin
                 out = data_in[5] ? 3'b100 : 3'b000;
             end else if (vga_h > position_h + 11'd40 && vga_h < position_h + 11'd46) begin
                 out = data_in[4] ? 3'b100 : 3'b000;
             end else if (vga_h > position_h + 11'd50 && vga_h < position_h + 11'd56) begin
                 out = data_in[3] ? 3'b100 : 3'b000;
             end else if (vga_h > position_h + 11'd60 && vga_h < position_h + 11'd66) begin
                 out = data_in[2] ? 3'b100 : 3'b000;
             end else if (vga_h > position_h + 11'd70 && vga_h < position_h + 11'd76) begin
                 out = data_in[1] ? 3'b100 : 3'b000;
             end else if (vga_h > position_h + 11'd80 && vga_h < position_h + 11'd86) begin
                 out = data_in[0] ? 3'b100 : 3'b000;
             end
                 
         end 
      end
      
      
	end
 
 endmodule
 