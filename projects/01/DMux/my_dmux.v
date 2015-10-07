/**
 * Demultiplexor:
 * {a, b} = {in, 0} if sel == 0
 *          {0, in} if sel == 1
 */

module my_dmux(a, b, in, sel);
 
	output a, b;
	input in, sel;
	 
	wire sel_not;
 
	// Get the inverted version of sel too.
	not(sel_not, sel);
	
	// Send "in" to the selected output.
	and(a, in, sel_not);
	and(b, in, sel);
 
endmodule
 