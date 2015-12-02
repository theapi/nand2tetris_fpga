

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

        #2
        scan_ready = 1;
        scan_code = 8'h1c;
        
        #10
        scan_ready = 0;
        
        // Break code (key up)
        #10
        scan_ready = 1;
        scan_code = 8'hf0;
        #4
        scan_ready = 0;
        #4
        scan_ready = 1;
        scan_code = 8'h1c;
        #4
        scan_ready = 0;
        
        
        #10
        scan_ready = 1;
        scan_code = 8'h32;
        // Break code (key up)
        #10
        scan_ready = 1;
        scan_code = 8'hf0;
        #4
        scan_ready = 0;
        #4
        scan_ready = 1;
        scan_code = 8'h32;
        #4
        scan_ready = 0;


	end

    always begin
        #1 clk = !clk;
    end
	
endmodule
