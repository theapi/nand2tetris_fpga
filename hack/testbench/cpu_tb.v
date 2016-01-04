

`timescale 10ns/10ns
module cpu_tb();
   
	// Declare inputs as regs and outputs as wires
	reg clk, reset;
    reg [15:0] inM;
    reg [15:0] instruction;

	wire [15:0] outM;
    wire writeM;
    wire [14:0] addressM;
    wire [14:0] pc;


    cpu #(.SPEED(32'd2)) cpu_DUT(
        .clk(clk),
        .reset(reset),
        .inM(inM),
        .instruction(instruction),
        .outM(outM),
        .writeM(writeM),
        .addressM(addressM),
        .pc(pc)
    );
    

	// Initialize all variables
	initial begin    
    
    
    $monitor ("%d %b %b %d %b %d %d %d %t", 
                inM, instruction, reset, outM, writeM, addressM, pc, cpu_DUT.DRegister, $time);

        clk = 1;
        reset = 0;
        inM = 0;
  
#1 reset = 1;  
#1 reset = 0;

#2 instruction = 16'b0011000000111001; // In the tests, #2 instructions are set on the negative edge (0+ / tock) sigh
#6 assert_cpu(16'd0, 16'b0011000000111001, 1'b0, 16'dx, 1'b0, 16'd12345, 16'd1, 16'd0);

#2 instruction = 16'b1110110000010000;
#6 assert_cpu(16'd0, 16'b1110110000010000, 1'b0, 16'dx, 1'b0, 16'd12345, 16'd2, 16'd12345);

#2 instruction = 16'b0101101110100000;
#6 assert_cpu(16'd0, 16'b0101101110100000, 1'b0, 16'dx, 1'b0, 16'd23456, 16'd3, 16'd12345);

#2 instruction = 16'b1110000111010000;
#6 assert_cpu(16'd0, 16'b1110000111010000, 1'b0, 16'dx, 1'b0, 16'd23456, 16'd4, 16'd11111);

#2 instruction = 16'b0000001111101000;
#6 assert_cpu(16'd0, 16'b0000001111101000, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd5, 16'd11111);

#2 instruction = 16'b1110001100001000;
#6 assert_cpu(16'd0, 16'b1110001100001000, 1'b0, 16'd11111, 1'b1, 16'd1000, 16'd6, 16'd11111);

#2 instruction = 16'b0000001111101001;
#6 assert_cpu(16'd0, 16'b0000001111101001, 1'b0, 16'dx, 1'b0, 16'd1001, 16'd7, 16'd11111);

#2 instruction = 16'b1110001110011000;
#6 assert_cpu(16'd0, 16'b1110001110011000, 1'b0, 16'd11109, 1'b1, 16'd1001, 16'd8, 16'd11110);

#2 instruction = 16'b0000001111101000;
#6 assert_cpu(16'd0, 16'b0000001111101000, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd9, 16'd11110);


inM = 16'd11111;

#2 instruction = 16'b1111010011010000;
#6 assert_cpu(16'd11111, 16'b1111010011010000, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd10, -16'd1);

#2 instruction = 16'b0000000000001110;  // @14
#6 assert_cpu(16'd11111, 16'b0000000000001110, 1'b0, 16'dx, 1'b0, 16'd14, 16'd11, -16'd1);

#2 instruction = 16'b1110001100000100; // D;jlt
#6 assert_cpu(16'd11111, 16'b1110001100000100, 1'b0, 16'dx, 1'b0, 16'd14, 16'd14, -16'd1);

#2 instruction = 16'b0000001111100111;
#6 assert_cpu(16'd11111, 16'b0000001111100111, 1'b0, 16'dx, 1'b0, 16'd999, 16'd15, -16'd1);

#2 instruction = 16'b1110110111100000;
#6 assert_cpu(16'd11111, 16'b1110110111100000, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd16, -16'd1);

#2 instruction = 16'b1110001100001000;
#6 assert_cpu(16'd11111, 16'b1110001100001000, 1'b0, -16'd1, 1'b1, 16'd1000, 16'd17, -16'd1);

#2 instruction = 16'b0000000000010101;
#6 assert_cpu(16'd11111, 16'b0000000000010101, 1'b0, 16'dx, 1'b0, 16'd21, 16'd18, -16'd1);

#2 instruction = 16'b1110011111000010;
#6 assert_cpu(16'd11111, 16'b1110011111000010, 1'b0, 16'dx, 1'b0, 16'd21, 16'd21, -16'd1);

#2 instruction = 16'b0000000000000010;
#6 assert_cpu(16'd11111, 16'b0000000000000010, 1'b0, 16'dx, 1'b0, 16'd2, 16'd22, -16'd1);

#2 instruction = 16'b1110000010010000;
#6 assert_cpu(16'd11111, 16'b1110000010010000, 1'b0, 16'dx, 1'b0, 16'd2, 16'd23, 16'd1);

#2 instruction = 16'b0000001111101000;
#6 assert_cpu(16'd11111, 16'b0000001111101000, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd24, 16'd1);

#2 instruction = 16'b1110111010010000;
#6 assert_cpu(16'd11111, 16'b1110111010010000, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd25, -16'd1);

#2 instruction = 16'b1110001100000001;
#6 assert_cpu(16'd11111, 16'b1110001100000001, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd26, -16'd1);

#2 instruction = 16'b1110001100000010;
#6 assert_cpu(16'd11111, 16'b1110001100000010, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd27, -16'd1);

#2 instruction = 16'b1110001100000011;
#6 assert_cpu(16'd11111, 16'b1110001100000011, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd28, -16'd1);

#2 instruction = 16'b1110001100000100;
#6 assert_cpu(16'd11111, 16'b1110001100000100, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1000, -16'd1);

#2 instruction = 16'b1110001100000101;
#6 assert_cpu(16'd11111, 16'b1110001100000101, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1000, -16'd1);

#2 instruction = 16'b1110001100000110;
#6 assert_cpu(16'd11111, 16'b1110001100000110, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1000, -16'd1);

#2 instruction = 16'b1110001100000111;
#6 assert_cpu(16'd11111, 16'b1110001100000111, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1000, -16'd1);

#2 instruction = 16'b1110101010010000;
#6 assert_cpu(16'd11111, 16'b1110101010010000, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1001, 16'd0);

#2 instruction = 16'b1110001100000001;
#6 assert_cpu(16'd11111, 16'b1110001100000001, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1002, 16'd0);

#2 instruction = 16'b1110001100000010;
#6 assert_cpu(16'd11111, 16'b1110001100000010, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1000, 16'd0);

#2 instruction = 16'b1110001100000011;
#6 assert_cpu(16'd11111, 16'b1110001100000011, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1000, 16'd0);

#2 instruction = 16'b1110001100000100;
#6 assert_cpu(16'd11111, 16'b1110001100000100, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1001, 16'd0);

#2 instruction = 16'b1110001100000101;
#6 assert_cpu(16'd11111, 16'b1110001100000101, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1002, 16'd0);

#2 instruction = 16'b1110001100000110;
#6 assert_cpu(16'd11111, 16'b1110001100000110, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1000, 16'd0);

#2 instruction = 16'b1110001100000111;
#6 assert_cpu(16'd11111, 16'b1110001100000111, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1000, 16'd0);

#2 instruction = 16'b1110111111010000;
#6 assert_cpu(16'd11111, 16'b1110111111010000, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1001, 16'd1);

#2 instruction = 16'b1110001100000001;
#6 assert_cpu(16'd11111, 16'b1110001100000001, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1000, 16'd1);

#2 instruction = 16'b1110001100000010;
#6 assert_cpu(16'd11111, 16'b1110001100000010, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1001, 16'd1);

#2 instruction = 16'b1110001100000011;
#6 assert_cpu(16'd11111, 16'b1110001100000011, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1000, 16'd1);

#2 instruction = 16'b1110001100000100;
#6 assert_cpu(16'd11111, 16'b1110001100000100, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1001, 16'd1);

#2 instruction = 16'b1110001100000101;
#6 assert_cpu(16'd11111, 16'b1110001100000101, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1000, 16'd1);

#2 instruction = 16'b1110001100000110;
#6 assert_cpu(16'd11111, 16'b1110001100000110, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1001, 16'd1);

#2 instruction = 16'b1110001100000111;
#6 assert_cpu(16'd11111, 16'b1110001100000111, 1'b0, 16'dx, 1'b0, 16'd1000, 16'd1000, 16'd1);

reset = 1;
#6 assert_cpu(16'd11111, 16'b1110001100000111, 1'b1, 16'dx, 1'b0, 16'd1000, 16'd0, 16'd1);

#2 instruction = 16'b0111111111111111;
reset = 0;
#6 assert_cpu(16'd11111, 16'b0111111111111111, 1'b0, 16'dx, 1'b0, 16'd32767, 16'd1, 16'd1);

  
	end

    always begin
        #1 clk = !clk;
    end
	

task assert_cpu;
    input [15:0] i_inM;
    input [15:0] i_instruction;
    input i_reset;
    input [15:0] i_outM;
    input i_writeM;
    input [14:0] i_addressM;
    input [14:0] i_pc;
    input [15:0] i_DRegister;
    
    begin
        if (
            outM != i_outM
            || writeM != i_writeM
            || pc != i_pc
            || addressM != i_addressM
            || cpu_DUT.DRegister != i_DRegister) begin
            
            $display ("%d %b %b %d %b %d %d %d : assert failed", 
                inM, instruction, reset, outM, writeM, addressM, pc, cpu_DUT.DRegister);
            $display ("%d %b %b %d %b %d %d %d <- should be this", 
                i_inM, i_instruction, i_reset, i_outM, i_writeM, i_addressM, i_pc, i_DRegister);
        end
    end
endtask

task assert;
    input [15:0] x, y;
    begin
        if(x != y)
          $display( "%t      ---------- assert failed %d != %d\n", $time, x, y );
    end
endtask
    
endmodule
