/**
 * In the Hack platform,
 * the screen is implemented as an 8K 16-bit RAM chip.
 *
 * 256 by 512 black-and-white
 *
 */
 
 module Screen(
    clk,
    in,
    load,
    address,
    out
 );
 
    input clk;             // the system clock
    input [15:0] in;       // what to write
    input load;            // write-enable bit
    input [15:0] address;  // where to read/write
    output [15:0] out;     // Screen value at the given address
    
    reg [15:0] ram[0:8191]; // 8K 16-bit RAM
    reg [15:0]value; 
    
    always @(posedge clk ) begin
        if (load) begin
            ram[address] <= in;
        end else begin
            value <= ram[address];
        end
    end
    
    assign out = value;
    
endmodule
