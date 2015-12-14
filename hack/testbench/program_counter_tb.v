

`timescale 10ns/10ns
module program_counter_tb();
   
	// Declare inputs as regs and outputs as wires
	reg clk, reset, inc, load;
    reg [15:0] in;

	wire [15:0] out;

    
    
    program_counter program_counter_DUT(
        .clk(clk),
        .reset(reset),
        .inc(inc),
        .load(load),
        .in(in),
        .out(out)
    );
    

	// Initialize all variables
	initial begin        

        clk = 0;
        reset = 0;
        inc = 0;
        load = 0;
        

        #2
        reset = 1;
        #2
        reset = 0;
        
        #2
        inc = 1;
             

        #2
if (out != 16'd1) begin
	$display("out != 16'd1");
end
        
        in = -16'd32123;
        #2
        load = 1;
        #2
        load = 0;
        
        #4
        in = 16'd12345;
        load = 1;
        inc = 0;
        
        #2
        reset = 1;
        
        #2
        reset = 0;
        inc = 1;
        
        #2
        reset = 1;
        
        #2
        reset = 0;
        load = 0;
        
        #2
        reset = 1;
        
        #2
        reset = 0;
        in = 0;
        load = 1;
        
        #2
        load = 0;
        inc = 1;
        
        #2
        in = 16'd22222;
        reset = 1;
        inc = 0;
        
        
        

        
	end

    always begin
        #1 clk = !clk;
    end
	
endmodule
