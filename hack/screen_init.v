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
    reg [13:0] buffer_addr; 
    reg [7:0] counter;
    //reg [17:0] counter_divider;
    reg wren;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin 
            counter <= 0;
        end else begin
            if (counter == 8'd16) begin
                counter <= 0;
            end
            else begin
                counter <= counter + 8'd1;
            end

        end
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin 
            buffer_addr <= 0;
            wren <= 1;
        end else if (buffer_addr == 14'd8192) begin
            buffer_addr <= 0;
            wren <= 0; // write no more
        end
        else if (counter == 8'd15) begin
            buffer_addr <= buffer_addr + 14'd1;
        end
        
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin 
            data <= 0;
        end 
            
        else begin
            if (buffer_addr == 14'd0 || buffer_addr == 14'd31 
             || buffer_addr == 14'd4111
             || buffer_addr == 14'd8160 || buffer_addr == 14'd8191) begin
                //data <= 16'h00_00;
                data <= 16'hFF_FF;
            end else begin
                data <= 16'h00_00;
                //data <= 16'hFF_FF;
            end
        end

        
    end
    
    
    assign load = wren;
    assign address = buffer_addr[12:0];
    assign out = data;
    
endmodule
