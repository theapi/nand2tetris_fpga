
/**
 * Selects the needed program instruction.
 *
 * IN in[16],load,inc,reset;
 *   OUT out[16];
 *
 */


 module program_counter(
    input clk,
    input reset,
    input inc,
    input load,
    input [15:0] in,
    output [15:0] out
 );

    reg [15:0] r_out;
    
    assign out = r_out;
   
 /**  
  * A 16-bit counter with load and reset control bits.
  * if      (reset[t] == 1) out[t+1] = 0
  * else if (load[t] == 1)  out[t+1] = in[t]
  * else if (inc[t] == 1)   out[t+1] = out[t] + 1  (integer addition)
  * else                    out[t+1] = out[t]
  *
  */ 
    always @(posedge clk or posedge reset) begin
        if (reset) begin 
            // set to zero
            r_out <= 0;
        end else if (load) begin
            // set the counter to the given number
            r_out <= in;
        end else if (inc) begin
            // increment
            r_out <= r_out + 16'd1;
        end else begin
            // r_out remains the same
        end
        
    end
 
endmodule
