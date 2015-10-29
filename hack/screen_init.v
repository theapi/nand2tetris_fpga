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
    output [12:0] address; // ram address to write the pixel data
    output [15:0] out;     // pixel values for ram address in the buffer


    reg [15:0] data;   
    reg [12:0] buffer_addr; 
    reg [17:0] counter;
    reg [17:0] counter_divider;
    reg wren;
    
 
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin 
            data <= 0;
            counter <= 0;
            wren <= 1;
        end else begin
            if (buffer_addr == 13'd8191) begin
                counter <= 0;
                wren <= 0; // write no more
            end
            else begin
                // 32 address registers per line (512 / 16 = 32)
                counter <= counter + 18'd1;
                
                // prevent assignment truncation warnings
                // by performing the calculation into a 
                // temporary variable of the same size as the counter
                counter_divider <= counter / 18'd16;
                // then truncate explicitly
                buffer_addr <= counter_divider[12:0]; 
                data <= 16'hFF_FF;
                wren <= 1;
            end

        end
    end
    
    
    assign load = wren;
    assign address = buffer_addr;
    assign out = data;
    
endmodule
