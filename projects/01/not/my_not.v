
// By convention outputs come first.
// using my_ prefix as this already exists as a primitive.

/**
 * Not gate:
 * out = not in
 */
module my_not (out, in);

output out;
input in;

// nand2tetris
// Nand(a = in, b = in, out = out);

// Verilog
// nand (out, in, in);
assign out = !(in & in);

endmodule
