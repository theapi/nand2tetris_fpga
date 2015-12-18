/**
 * The Hack CPU (Central Processing unit), consisting of an ALU,
 * two registers named A and D, and a program counter named PC.
 * The CPU is designed to fetch and execute instructions written in 
 * the Hack machine language. 
 
 * In particular, functions as follows:
 * Executes the inputted instruction according to the Hack machine 
 * language specification. 
 * The D and A in the language specification
 * refer to CPU-resident registers, 
 * while M refers to the external memory location addressed by A,
 * i.e. to Memory[A]. 
 * The inM input holds the value of this location. 
 *
 * If the current instruction needs 
 * to write a value to M, the value is placed in outM, the address 
 * of the target location is placed in the addressM output, and the 
 * writeM control bit is asserted. (When writeM==0, any value may 
 * appear in outM). 
 * The outM and writeM outputs are combinational: 
 * they are affected instantaneously by the execution of the current 
 * instruction. The addressM and pc outputs are clocked: although they 
 * are affected by the execution of the current instruction, they commit 
 * to their new values only in the next time step. If reset==1 then the 
 * CPU jumps to address 0 (i.e. pc is set to 0 in next time step) rather 
 * than to the address resulting from executing the current instruction. 
 *
 *
 *  IN  inM[16],         // M value input  (M = contents of RAM[A])
 *      instruction[16], // Instruction for execution
 *      reset;           // Signals whether to re-start the current
 *                       // program (reset==1) or continue executing
 *                       // the current program (reset==0).
 *
 *  OUT outM[16],        // M value output
 *      writeM,          // Write to M? 
 *      addressM[15],    // Address in data memory (of M)
 *      pc[15];          // address of next instruction
 */

module cpu (
    input clk,
    input reset,
    input [15:0] instruction,
    input [15:0] inM,

    output [15:0] outM,
    
    output [14:0] addressM,
    output writeM,
    output [14:0] pc,
    
    
    output [15:0] areg,
    output [15:0] dreg
);

    
    reg [14:0] r_addressM = 1'b0;
    reg r_writeM;
    
    reg pc_inc = 1;
    reg pc_load = 0;
    reg [15:0] pc_in = 0;
    wire [15:0] pc_out;
    
    reg [15:0] alu_y;
    wire [15:0] alu_out;
    wire alu_zr, alu_ng;

    assign pc = pc_out[14:0];
    
    assign outM = alu_out; 
    assign writeM = r_writeM;
    assign addressM = r_addressM;
    
    
    reg [15:0] DRegister = 16'b0;
    reg [15:0] ARegister = 16'b0;
    assign dreg = DRegister;
    assign areg = ARegister;
  

    program_counter program_counter_inst (
        .clk(clk),
        .reset(reset),
        .inc(pc_inc),
        .load(pc_load),
        .in(pc_in),
        .out(pc_out)
    );
    

    alu alu_inst(
        .x(DRegister),
        .y(alu_y),
        .zx(instruction[11]),
        .nx(instruction[10]),
        .zy(instruction[9]),
        .ny(instruction[8]),
        .f(instruction[7]),
        .no(instruction[6]),
        .out(alu_out),
        .zr(alu_zr),
        .ng(alu_ng)
    );
    
    always @(*) begin
        pc_in = 16'b0;
        pc_load = 1'b0;
        r_writeM = 1'b0;
        alu_y = ARegister;
        r_addressM = ARegister[14:0];

        if (reset) begin
            pc_in = 16'b0;
            pc_load = 1'b0;
            r_writeM = 1'b0;
        end else if (instruction[15] == 1) begin  // C instruction
        
            // Alu_y input: If bit[12], the "a" bit is 1 then use M (inM) otherwise use A register content.
            if (instruction[12] == 1) begin
                alu_y = inM;
            end 

            // if d3 (instruction[3]) == 1 then write to M
            if (instruction[3] == 1) begin
                r_writeM = 1'b1;    
            end
        
            // Jump instructions
            case (instruction[2:0])
                3'b001: // JGT
                    begin
                        if (!alu_ng && !alu_zr) begin // alu_out > 0
                            pc_in = ARegister;
                            pc_load = 1'b1;
                        end
                    end
                3'b010: // JEQ
                    begin
                        if (alu_zr) begin // alu_out == 0
                            pc_in = ARegister;
                            pc_load = 1'b1;
                        end
                    end
                3'b011: // JGE
                    begin
                        if (!alu_ng || alu_zr) begin // alu_out >= 0
                            pc_in = ARegister;
                            pc_load = 1'b1;
                        end
                    end
                3'b100: // JLT
                    begin
                        if (alu_ng) begin // alu_out < 0
                            pc_in = ARegister;
                            pc_load = 1'b1;
                        end
                    end
                3'b101: // JNE
                    begin
                        if (!alu_zr) begin //alu_out != 0
                            pc_in = ARegister;
                            pc_load = 1'b1;
                        end
                    end
                3'b110: // JLE
                    begin
                        if (alu_ng || alu_zr) begin // alu_out = 0
                            pc_in = ARegister;
                            pc_load = 1'b1;
                        end
                    end
                3'b111: // JMP
                    begin
                        pc_in = ARegister;
                        pc_load = 1'b1;
                    end
                default: pc_load = 1'b0;
            endcase
        end
        
        
        
    end
    
    always @(posedge clk) begin
        // Need 2 clock cycles per instruction due to the registers needing a clock cycle
        // and the registers can be changed in each instruction.
        pc_inc <= !pc_inc;
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            
        end else begin
            
            // A instruction
            if (instruction[15] == 0) begin
                ARegister <= {1'b0, instruction[14:0]};
                //pc_load <= 1'b0;
                //r_writeM <= 1'b0;
            end
            // C instruction
            else begin
                
                
                // The registers can only be set on the second clock cycle.
                if (pc_inc) begin
                    if (instruction[5] == 1) begin
                        ARegister <= alu_out;
                    end

                    // If bit[4] "d2" is 1 then store ALU out (outM) in the D register
                    if (instruction[4] == 1) begin
                        DRegister <= alu_out;
                    end
                end
                
            end
            
            
        end

    end


endmodule
