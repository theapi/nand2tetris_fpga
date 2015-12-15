

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


    cpu cpu_DUT(
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

        clk = 1;
        reset = 0;
        inM = 0;
        instruction = 16'B0011000000111001; // @12345
        
/*
set instruction %B0011000000111001, // @12345
|1   |     0|0011000000111001|  0  |      0|   0   |12345|    1|      0 |
*/ 
        #4 
        assert_cpu(16'd0, 16'b0011000000111001, 1'b0, 16'd0, 1'b0, 16'd12345, 16'd1 , 16'd0);
        instruction = 16'B1110110000010000; // D=A
        

/*
set instruction %B1110110000010000, // D=A
|2   |     0|1110110000010000|  0  |  12345|   0   |12345|    2|  12345 |
*/
        #4 assert_cpu(16'd0, 16'b1110110000010000, 1'b0, 16'd12345, 1'b0, 16'd12345, 16'd2, 16'd12345);
        
	end

    always begin
        #1 clk = !clk;
        //if (clk) line_num = line_num + 1'b1;
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
        if (inM != i_inM 
            || instruction != i_instruction
            || reset != i_reset
            || outM != i_outM
            || writeM != i_writeM
            || pc != i_pc
            || addressM != i_addressM
            || cpu_DUT.DRegister != i_DRegister) begin
            $display ("%d %b %b %d %b %d %d %d : assert failed", 
                i_inM, i_instruction, i_reset, i_outM, i_writeM, i_addressM, i_pc, i_DRegister);
            $display ("%d %b %b %d %b %d %d %d <- should be this", 
                inM, instruction, reset, outM, writeM, addressM, pc, cpu_DUT.DRegister);
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
