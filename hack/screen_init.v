/**
 * Fill the screen ram with initial values.
 */

 module screen_init(
    clk,
    reset,
    address,
    out,
    load
 );
 
    input clk;
    input reset;
    output load; 
    output [15:0] address; // ram address to write the pixel data
    output [15:0] out;     // pixel values for ram address in the buffer


    reg [15:0] data;   
    reg [15:0] buffer_addr; 
    reg [32:0] counter;
    reg wren;
    
 
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin 
            data <= 0;
            counter <= 0;
            wren <= 1;
        end else begin
            //if (counter == 131072) begin //  512 x 256 
            if (buffer_addr == 8192) begin
                counter <= 0;
                wren <= 0; // write no more
            end
            else begin
                counter <= counter + 1;
                // 32 address registers per line (512 / 16 = 32)
                buffer_addr <= counter / 16;
                data <= 16'hFF_FF;
            end

        end
    end
    
    
    assign load = wren;
    assign address = buffer_addr;
    assign out = data;
    
endmodule
