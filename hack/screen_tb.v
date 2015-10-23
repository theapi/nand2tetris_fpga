

`timescale 10ns/10ns
module Screen_tb();

    // Declare inputs as regs and outputs as wires
	reg clk;

    reg [15:0] in;      
    reg load;            
    reg [15:0] address;  
    wire [15:0] out;

    Screen U0(
        .clk(clk),
        .in(in),
        .load(load),
        .address(address),
        .out(out)
     );
     
     
    initial begin        
        clk = 0;
        
        #2
        address = 16'h01;
        in = 16'd42;
        load = 1;

        #2
        address = 16'h02;
        in = 16'd23;
        load = 1;

        #2
        address = 16'h01;
        load = 0;

        #2
        address = 16'h01;
        in = 16'd0;
        load = 1;

        #2
        address = 16'h02;
        in = 16'd0;
        load = 1;


	#2
        address = 16'h01;
        in = 16'hFF_FF;
        load = 1;

	#2
        address = 16'h01;
        load = 0;
        
    end
    
     
    always begin
        #1 clk = !clk;
    end
    
    

endmodule
