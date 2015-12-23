

`timescale 10ns/10ns


module core_tb();
   
	// Declare inputs as regs and outputs as wires
	reg clk, reset;
    wire [15:0] inM;
    wire [15:0] instruction;
    
    reg [7:0] keyboard;

    
	wire [15:0] outM;
    wire writeM;
    wire [14:0] addressM;
    
    wire [14:0] pc;
    
    wire [12:0] screen_read_address;
    wire [15:0] read_value;
    wire screen_we;
    
    wire [15:0] areg;
    wire [15:0] dreg;
    
    wire [15:0] q;
    
    reg [15:0] im_d;
    reg [14:0] im_address;
    reg im_we;

    instruction_memory instruction_memory (
        .clk(clk),
        .read_address(pc),
        .q(instruction),
        .d(im_d),
        .write_address(im_address),
        .we(im_we)
    );

    cpu #(.SPEED(32'd2)) cpu(
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

    memory data_memory (
        .clk(clk),
        .in(outM),
        .screen_read_address(screen_read_address),
        .address(addressM),
        .load(writeM),
        .keyboard(keyboard),
        .out(inM),
        //.screen_address(screen_address),
        //.screen_data(screen_data),
        //.screen_we(screen_we)
        .read_value(read_value)
    );
    

	// Initialize all variables
	initial begin    

    $monitor ("%d %b %b %b %b %d %d %d %d %d %t", 
                inM, instruction, reset, outM, writeM, addressM, pc, cpu.DRegister,
                dreg, areg,  $time);

        clk = 1;
        reset = 1;

/*
// Load the program
#2
im_address = 15'd0;
im_d = 16'b0000000000000010; // @2
im_we = 1;
#2
im_address = 15'd1;
im_d = 16'b1110110000010000; // D=A
#2
im_address = 15'd2;
im_d = 16'b0000000000010111;
#2
im_address = 15'd3;
im_d = 16'b1110001100000110;
#2
im_address = 15'd4;
im_d = 16'b0000000000010000;

#2
im_we = 0;
*/

#2 
im_we = 1;
reset = 1;

#2
im_address = 15'd0;
im_d = 16'b0000000000000010; // @2 (changed from original to not get the height from ram)

#2
im_address = 15'd1;
im_d = 16'b1110110000010000; // D=A (changed from original to not get the height from ram)

#2
im_address = 15'd2;
im_d = 16'b0000000000010111;

#2
im_address = 15'd3;
im_d = 16'b1110001100000110;

#2
im_address = 15'd4;
im_d = 16'b0000000000010000;

#2
im_address = 15'd5;
im_d = 16'b1110001100001000;

#2
im_address = 15'd6;
im_d = 16'b0100000000000000;

#2
im_address = 15'd7;
im_d = 16'b1110110000010000;

#2
im_address = 15'd8;
im_d = 16'b0000000000010001;

#2
im_address = 15'd9;
im_d = 16'b1110001100001000;

#2
im_address = 15'd10;
im_d = 16'b0000000000010001;

#2
im_address = 15'd11;
im_d = 16'b1111110000100000;

#2
im_address = 15'd12;
im_d = 16'b1110111010001000;

#2
im_address = 15'd13;
im_d = 16'b0000000000010001;

#2
im_address = 15'd14;
im_d = 16'b1111110000010000;

#2
im_address = 15'd15;
im_d = 16'b0000000000100000;

#2
im_address = 15'd16;
im_d = 16'b1110000010010000;

#2
im_address = 15'd17;
im_d = 16'b0000000000010001;

#2
im_address = 15'd18;
im_d = 16'b1110001100001000;

#2
im_address = 15'd19;
im_d = 16'b0000000000010000;

#2
im_address = 15'd20;
im_d = 16'b1111110010011000;

#2
im_address = 15'd21;
im_d = 16'b0000000000001010;

#2
im_address = 15'd22;
im_d = 16'b1110001100000001;

#2
im_address = 15'd23;
im_d = 16'b0000000000010111;

#2
im_address = 15'd24;
im_d = 16'b1110101010000111;

#2 im_we = 0;
 
#2 reset = 0;
#2 reset = 1;
#2 reset = 0;
  
	end

    always begin
        #1 clk = !clk;
    end
	
    
endmodule
