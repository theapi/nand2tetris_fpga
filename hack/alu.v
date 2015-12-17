/**
 * The ALU (Arithmetic Logic Unit).
 * Computes one of the following functions:
 * x+y, x-y, y-x, 0, 1, -1, x, y, -x, -y, !x, !y,
 * x+1, y+1, x-1, y-1, x&y, x|y on two 16-bit inputs, 
 * according to 6 input bits denoted zx,nx,zy,ny,f,no.
 * In addition, the ALU computes two 1-bit outputs:
 * if the ALU output == 0, zr is set to 1; otherwise zr is set to 0;
 * if the ALU output < 0, ng is set to 1; otherwise ng is set to 0.
 *
 *
 * Implementation: the ALU logic manipulates the x and y inputs
 * and operates on the resulting values, as follows:
 * if (zx == 1) set x = 0        // 16-bit constant
 * if (nx == 1) set x = !x       // bitwise not
 * if (zy == 1) set y = 0        // 16-bit constant
 * if (ny == 1) set y = !y       // bitwise not
 * if (f == 1)  set out = x + y  // integer 2's complement addition
 * if (f == 0)  set out = x & y  // bitwise and
 * if (no == 1) set out = !out   // bitwise not
 * if (out == 0) set zr = 1
 * if (out < 0) set ng = 1
 *
 *
 *    IN  
 *       x[16], y[16],  // 16-bit inputs        
 *       zx, // zero the x input?
 *       nx, // negate the x input?
 *       zy, // zero the y input?
 *       ny, // negate the y input?
 *       f,  // compute out = x + y (if 1) or x & y (if 0)
 *       no; // negate the out output?
 *
 *   OUT 
 *       out[16], // 16-bit output
 *       zr, // 1 if (out == 0), 0 otherwise
 *       ng; // 1 if (out < 0),  0 otherwise
 *
 *
 */

module alu (
    input [15:0] x,
    input [15:0] y,
    input zx, nx, zy, ny, f, no,
    
    output [15:0] out,
    output zr,
    output ng
);

    reg [15:0] r_x;
    reg [15:0] r_y;
    reg [15:0] r_out;
    reg r_zr;
    reg r_ng;
    
    always @ (*) begin
        r_x = (zx == 1) ? 0 : x;      // if (zx == 1) set x = 0 
        r_x = (nx == 1) ? ~r_x : r_x; // if (nx == 1) set x = !x
        
        r_y = (zy == 1) ? 0 : y;      // if (zy == 1) set y = 0
        r_y = (ny == 1) ? ~r_y : r_y; // if (ny == 1) set y = !y
        
        r_out = (f == 1) ? r_x + r_y : r_x & r_y; // if (f == 1)  set out = x + y else set out = x & y
        r_out = (no == 1) ? ~r_out : r_out;       // if (no == 1) set out = !out
        
        r_zr = (r_out == 0) ? 1 : 0;    // if (out == 0) set zr = 1
        r_ng = (r_out[15] == 1) ? 1 : 0;     // if (out < 0) set ng = 1
        
    end
    
    assign out = r_out;
    assign zr = r_zr;
    assign ng = r_ng;
    

endmodule
