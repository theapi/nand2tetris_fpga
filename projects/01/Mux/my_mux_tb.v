
`timescale 1ns/1ns
module my_mux_tb();

	// Declare inputs as regs and outputs as wires
	reg a, b, sel;
	wire out;

	// Initialize all variables
	initial begin        
	  $monitor ("a=%b b=%b sel=%b out%b", 
			 a, b, sel, out);	

	  a = 0;
	  b = 0;
	  sel = 0;
	  
	  #10
	  sel = 1;
	  
	  #10
	  a = 0;
	  b = 1;
	  sel = 0;
	  
	  #10
	  sel = 1;
	  
	  #10
	  a = 1;
	  b = 0;
	  sel = 0;
	  
	  #10
	  sel = 1;
	  
	  #10
	  a = 1;
	  b = 1;
	  sel = 0;
	  
	  #10
	  sel = 1;

	  #10 
	  $finish;      // Terminate simulation

	end

	my_mux DUT (out, a, b, sel);
	
endmodule
