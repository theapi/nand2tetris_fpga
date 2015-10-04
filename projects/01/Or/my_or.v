 /**
 * Or gate:
 * out = 1 if (a == 1 or b == 1)
 *       0 otherwise
 */
 
 module my_or(out, a, b);
 
 output out;
 input a, b;
 
 wire x, y;
 
	not(x, a);
	not(y, b);
	nand(out, x, y);
 
 endmodule
 