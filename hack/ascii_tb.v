

`timescale 10ns/10ns
module ascii_tb();
   
	// Declare inputs as regs and outputs as wires
	reg clk;
    reg scan_ready;
    reg [7:0] scan_code;

	wire [7:0] ascii;

    
    
    ascii ascii_DUT(
        .clk(clk),
        .scan_ready(scan_ready),
        .scan_code(scan_code),
        .ascii(ascii)
    );
    

	// Initialize all variables
	initial begin        

        clk = 1;
        scan_ready = 0;

        #2
        scan_ready = 1;
        scan_code = 8'h1c;
        #10
        scan_ready = 0;
        #10
        scan_ready = 1;
        scan_code = 8'hf0;  // Break code (key up)
        #10
        scan_ready = 0;
        #10
        scan_ready = 1;
        scan_code = 8'h1c; // scan code repeated after break code
        #10
        scan_ready = 0;
        // ascii: a
        
        
        #10
        scan_ready = 1;
        scan_code = 8'h32;
        #10
        scan_ready = 0;
        #10
        scan_ready = 1;
        scan_code = 8'hf0; // Break code (key up)
        #10
        scan_ready = 0;
        #10
        scan_ready = 1;
        scan_code = 8'h32; // scan code repeated after break code
        #10
        scan_ready = 0;
        // ascii: b


        #10
        scan_ready = 1;
        scan_code = 8'h32;
        #10
        scan_ready = 0;
        #10
        scan_ready = 1;
        scan_code = 8'hf0; // Break code (key up)
        #10
        scan_ready = 0;
        #10
        scan_ready = 1;
        scan_code = 8'h32; // scan code repeated after break code
        #10
        scan_ready = 0;
        // ascii: b

        
        // Caps lock on
        #10
        scan_ready = 1;
        scan_code = 8'h58;
        #10
        scan_ready = 0;
        #10
        scan_ready = 1;
        scan_code = 8'hf0; // Break code (key up)
        #10
        scan_ready = 0;
        #10
        scan_ready = 1;
        scan_code = 8'h58; // scan code repeated after break code
        #10
        scan_ready = 0;
        // ascii: b
        
        
        // Caps lock still on
        #10
        scan_ready = 1;
        scan_code = 8'h32;
        #10
        scan_ready = 0;
        #10
        scan_ready = 1;
        scan_code = 8'hf0; // Break code (key up)
        #10
        scan_ready = 0;
        #10
        scan_ready = 1;
        scan_code = 8'h32; // scan code repeated after break code
        #10
        scan_ready = 0;
        // ascii: B
        
        
        // Shift aswell as caps lock
        #10
        scan_ready = 1;
        scan_code = 8'h12;
        #10
        scan_ready = 0;
        
        #10
        scan_ready = 1;
        scan_code = 8'h32;
        #10
        scan_ready = 0;
        #10
        scan_ready = 1;
        scan_code = 8'hf0; // Break code (key up)
        #10
        scan_ready = 0;
        #10
        scan_ready = 1;
        scan_code = 8'h32; // scan code repeated after break code
        #10
        scan_ready = 0;
        // ascii: b
        
        
        // Shift off
        #10
        scan_ready = 1;
        scan_code = 8'hf0; // Break code (key up)
        #10
        scan_ready = 0;
        #10
        scan_ready = 1;
        scan_code = 8'h12; // scan code repeated after break code
        #10
        scan_ready = 0;
        // ascii: B
        
        
        // Caps lock off
        #50
        scan_ready = 1;
        scan_code = 8'h58;
        #10
        scan_ready = 0;
        #10
        scan_ready = 1;
        scan_code = 8'hf0; // Break code (key up)
        #10
        scan_ready = 0;
        #10
        scan_ready = 1;
        scan_code = 8'h58; // scan code repeated after break code
        #10
        scan_ready = 0;
        // ascii: b
        
        
        // c
        #30
        scan_ready = 1;
        scan_code = 8'h21;
        #10
        scan_ready = 0;
        #10
        scan_ready = 1;
        scan_code = 8'hf0; // Break code (key up)
        #10
        scan_ready = 0;
        #10
        scan_ready = 1;
        scan_code = 8'h21; // scan code repeated after break code
        #10
        scan_ready = 0;
        // ascii: c
        
	end

    always begin
        #1 clk = !clk;
    end
	
endmodule
