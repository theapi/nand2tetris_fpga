
/**
 * Read the memory to stop it being optimized away - TEMPORARY.
 */

 module temporary_memory_user(
    input clk,
    input reset,
    input [15:0] d,
    output load,
    output [14:0] address,
    output [7:0] out
 );

    reg [14:0] r_address;
    
    assign address = r_address;
    assign out = d[7:0];
    assign load = 0;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin 
            r_address <= 0;
        end else begin
            r_address <= r_address + 15'd1;
        end
    end
 
endmodule
