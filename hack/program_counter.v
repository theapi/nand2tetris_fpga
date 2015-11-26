
/**
 * Selects the needed program instruction
 */

 module program_counter(
    input clk,
    input reset,
    input inc,
    input load,
    input [12:0] in,
    output [12:0] out
 );

    reg [12:0] r_out;
    
    assign out = r_out;
    
    // NB not the real implementation yet!
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin 
            r_out <= 0;
        end else begin
            r_out <= r_out + 12'd1;
        end
    end
 
endmodule
