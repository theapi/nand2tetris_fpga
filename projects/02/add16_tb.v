//`include "add16.v"

`timescale 1ns/1ns
module add16_tb();
   
	// Declare inputs as regs and outputs as wires
	reg [15:0] a;
	reg [15:0] b;
	wire [15:0] out;

	// Initialize all variables
	initial begin        
	  $monitor ("a=%b b=%b out=%b", 
			 a, b, out);	

	  a = 16'b0000000000000000;
	  b = 16'b0000000000000000;

	  #10
if (out != 16'b0000000000000000) begin
	$display("    ^^^ ---FAIL--- ^^^");
end
	  a = 16'b0000000000000000;
	  b = 16'b1111111111111111;
	  
	  #10
if (out != 16'b1111111111111111) begin
	$display("    ^^^ ---FAIL--- ^^^");
end
	  //a = 16'd2;
	  //b = 16'd2;
	  a = 16'b1111111111111111;
	  b = 16'b1111111111111111;

	  #10
if (out != 16'b1111111111111110) begin
	$display("    ^^^ ---FAIL--- ^^^");
end
	  a = 16'b1010101010101010;
	  b = 16'b0101010101010101;

	  #10
if (out != 16'b1111111111111111) begin
	$display("    ^^^ ---FAIL--- ^^^");
end
	  a = 16'b0011110011000011;
	  b = 16'b0000111111110000;

	  #10
if (out != 16'b0100110010110011) begin
	$display("    ^^^ ---FAIL--- ^^^");
end
	  a = 16'b0001001000110100;
	  b = 16'b1001100001110110;

	  #10 
if (out != 16'b1010101010101010) begin
	$display("    ^^^ ---FAIL--- ^^^");
end


	  $finish;      // Terminate simulation

	end

	add16 DUT (out, a, b);
	
endmodule
