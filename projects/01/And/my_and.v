/**
 * And gate: 
 * out = 1 if (a == 1 and b == 1)
 *       0 otherwise
 */
 
 module my_and (out, a, b);
 
 output out;
 input a, b;
 
 wire x;
 
 nand(x, a, b);
 not(out, x);
 
 endmodule
 