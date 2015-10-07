/**
 * Adds two 16-bit values.
 * The most significant carry bit is ignored.
 */
 
module add16(out, a, b);

	input [15:0] a;
	input [15:0] b;
	output [15:0] out;
	
	assign out = a + b;

endmodule
