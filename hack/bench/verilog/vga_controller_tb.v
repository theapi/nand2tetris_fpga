`timescale 10ns/10ns


module vga_controller_tb();

    // Declare inputs as regs and outputs as wires
    reg VGA_CLK;
    reg sys_clk;
    reg RESET;
    wire [7:0] VGA_R;
    wire [7:0] VGA_G;
    wire [7:0] VGA_B;
    wire VGA_HS;
    wire VGA_VS;
    wire VGA_BLANK_N;

    
    vga_controller vga_ins(
        .reset(RESET),
        .sys_clk(sys_clk),
        .vga_clk(VGA_CLK),
        .blank_n(VGA_BLANK_N),
        .HS(VGA_HS),
        .VS(VGA_VS),
        .red(VGA_R),
        .green(VGA_G),
        .blue(VGA_B)
    );
    
    initial begin
        RESET = 0;
        VGA_CLK = 0;
        
        #2
        RESET = 1;
        
        #2
        RESET = 0;

    
    end
    

    always begin
        #1 VGA_CLK = !VGA_CLK;
    end
 
endmodule
