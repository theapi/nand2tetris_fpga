/**
 *  Exclusive-or gate:
 *  out = not (a == b)
 */
 
 module my_xor(out, a, b);
 
	output out;
	input a, b;
 
	wire x, y, z;
 
   nand(x, a, b);
	
	nand(y, a, x);
	nand(z, b, x);
	
	nand(out, y, z);
 
 endmodule
 