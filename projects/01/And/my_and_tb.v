`include "my_and.v"

`timescale 1ns/1ns
module my_and_tb();

// Declare inputs as regs and outputs as wires
reg a, b;
wire out;

// Initialize all variables
initial begin        
  $monitor ("a=%b b=%b out%b", 
	    a, b, out);	

  a=0;
  b=0;
  
  #10 a=1;
  #10 b=1;
  #10 a=0;
  #10 b=0;
  #10 a=1;
  #10 b=1;

  #10 $finish;      // Terminate simulation

end

my_and DUT (out, a, b);

endmodule
