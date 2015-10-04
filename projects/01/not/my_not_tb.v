`include "my_not.v"

`timescale 1ns/1ns
module my_not_tb();

// Declare inputs as regs and outputs as wires
reg in;
wire out;

// Initialize all variables
initial begin        
  $monitor ("in=%b out%b", 
	    in, out);	

  in=0;
  
  #10 in=1;
  #10 in=0;
  #10 in=0;
  #10 in=1;

  #10 $finish;      // Terminate simulation

end

my_not DUT (out, in);

endmodule
