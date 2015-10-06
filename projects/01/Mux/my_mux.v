/** 
 * Multiplexor:
 * out = a if sel == 0
 *       b otherwise
 */

 module my_mux(out, a, b, sel);
 
   output out;
   input a, b, sel;
 
   wire sel_not, a_out, b_out;
 
   // not SEL to A nand
	not(sel_not, sel);
	nand(a_out, a, sel_not);
	
	// Sel straight to B
	nand(b_out, b, sel);
	
	// Nand them together to get the output
	nand(out, a_out, b_out);
 
 endmodule
 