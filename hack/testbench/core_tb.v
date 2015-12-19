

`timescale 10ns/10ns

module data_mux(
    input clk,
    input sel,
    
    input [15:0] a_in,
    input [14:0] a_address,
    input a_we,
    
    input [15:0] b_in,
    input [14:0] b_address,
    input b_we,
    
    output [15:0] out,
    output write,
    output [14:0] address
);

    reg [15:0] r_out;
    reg r_write;
    reg [14:0] r_address;

    assign out = r_out;
    assign write = r_write;
    assign address = r_address;
            
    always @ (posedge clk) begin
        if (sel) begin
            r_out <= a_in; 
            r_write <= a_we;
            r_address <= a_address;
        end else begin
            r_out <= b_in; 
            r_write <= b_we;
            r_address <= b_address;
        end
    end

endmodule

module core_tb();
   
	// Declare inputs as regs and outputs as wires
	reg clk, reset;
    wire [15:0] inM;
    wire [15:0] instruction;
    
    reg [7:0] keyboard;

    reg [14:0] dinit_address;
    reg dinit_load;
    reg [15:0] dinit_in;
    wire [15:0] dm_in;
    wire [14:0] dm_address;
    wire dm_load;
    reg dm_sel;
    
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

    /*
    cpu cpu(
        .clk(clk),
        .reset(reset),
        .inM(inM),
        .instruction(instruction),
        .outM(dm_in),
        .writeM(dm_load),
        .addressM(dm_address),
        .pc(pc),
        .areg(areg),
        .dreg(dreg)
    );
    
    data_mux data_mux(
        .clk(clk),
        .sel(dm_sel),
        
        .a_in(dinit_in),
        .a_address(dinit_address),
        .a_we(dinit_load),
        
        .b_in(dm_in),
        .b_address(dm_address),
        .b_we(dm_load),
        
        .out(outM),
        .write(writeM),
        .address(addressM)
    );
 */
 
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

    $monitor ("%d %b %b %b %b %d %d %d %d %d %d %d %b %t", 
                inM, instruction, reset, outM, writeM, addressM, pc, cpu.DRegister,
                dreg, areg, screen_address, screen_data, screen_we,  $time);

        clk = 1;
        reset = 0;

// Initialize memory
/*
#2 
dm_sel = 1;
dinit_address = 15'd0;
dinit_in = 15'd2;
dinit_load = 1'b1;

#2
dm_sel = 0;
dinit_load = 1'b0;
*/

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

  
	end

    always begin
        #1 clk = !clk;
    end
	
    
endmodule
