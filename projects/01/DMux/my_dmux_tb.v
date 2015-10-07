
`timescale 1ns/1ns
module my_dmux_tb();
   
	// Declare inputs as regs and outputs as wires
	reg in, sel;
	wire a, b;

	// Initialize all variables
	initial begin        
	  $monitor ("a=%b b=%b sel=%b in%b", 
			 a, b, sel, in);	

	  in = 0;
	  sel = 0;
	  
	  #10
	  sel = 1;
	  
	  #10
	  in = 1;
	  sel = 0;
	  
	  #10
	  sel = 1;

	  #10 
	  $finish;      // Terminate simulation

	end

	my_dmux DUT (a, b, in, sel);
	
endmodule
