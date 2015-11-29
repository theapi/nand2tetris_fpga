
/**
 * Selects the needed program instruction
 only upto 16K for now :(
 */

 module program_counter(
    input clk,
    input reset,
    input inc,
    input load,
    input [13:0] in,
    output [13:0] out
 );

    reg [13:0] r_out;
    
    assign out = r_out;
    
    // NB not the real implementation yet!
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin 
            r_out <= 0;
        end else begin
            r_out <= r_out + 14'd1;
        end
    end
 
endmodule
