

`timescale 10ns/10ns

module data_int(
    input clk,
    input [15:0] in,
    input [14:0] address,
    input load,
    output [15:0] out
);

endmodule

module core_tb();
   
	// Declare inputs as regs and outputs as wires
	reg clk, reset;
    wire [15:0] inM;
    reg [15:0] instruction;
    
    reg [7:0] keyboard;

	wire [15:0] outM;
    wire writeM;
    wire [14:0] addressM;
    
    wire [14:0] pc;
    
    wire [12:0] screen_address;
    wire [15:0] screen_data;
    wire screen_we;
    
    wire [15:0] areg;
    wire [15:0] dreg;
    
    wire [15:0] q;

    instruction_memory instruction_memory (
        .clk(clk),
        .read_address(pc),
        .q(q),
        .d(16'b0),
        .write_address(15'b0),
        .we(1'b0)
    );

    cpu cpu(
        .clk(clk),
        .reset(reset),
        .inM(inM),
        .instruction(instruction),
        .outM(outM),
        .writeM(writeM),
        .addressM(addressM),
        .pc(pc),
        .areg(areg),
        .dreg(dreg)
    );
    
    data_int(
        .clk(clk),
        .in(dinit_in),
        .address(dinit_address),
        .load(dinit_load),
        .out(dinit_out)
    );

    memory data_memory (
        .clk(clk),
        .in(outM),
        .address(addressM),
        .load(writeM),
        .keyboard(keyboard),
        .out(inM),
        .screen_address(screen_address),
        .screen_data(screen_data),
        .screen_we(screen_we)
    );
    

	// Initialize all variables
	initial begin    
    
    
    
    
    $monitor ("%d %b %b %d %b %d %d %d %d %d %d %d %b %t", 
                inM, instruction, reset, outM, writeM, addressM, pc, cpu.DRegister, dreg, areg, screen_address, screen_data, screen_we,  $time);

        clk = 1;
        reset = 0;
  
#1 reset = 1;  
#1 reset = 0;

//#2 
//addressM = 15'b0;
//writeM = 1'b1;


  
	end

    always begin
        #1 clk = !clk;
    end
	
    
endmodule
