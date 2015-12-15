

`timescale 10ns/10ns
module alu_tb();
   
	// Declare inputs as regs and outputs as wires
	
    reg [15:0] x;
    reg [15:0] y;
    reg zx, nx, zy, ny, f, no;

    wire [15:0] out;
    wire zr, ng;

    alu alu_DUT(
        .x(x),
        .y(y),
        .zx(zx),
        .nx(nx),
        .zy(zy),
        .ny(ny),
        .f(f),
        .no(no),
        .out(out),
        .zr(zr),
        .ng(ng)
    );
    

	// Initialize all variables
	initial begin        
$monitor ("%b %b %b %b %b %b %b %b %b %b %b", 
	  x, y, zx, nx, zy, ny, f, no, out, zr, ng);
 
x = 16'B0000000000000000;  // x = 0
y = 16'B1111111111111111;  // y = -1

// Compute 0
#2
zx = 1;
nx = 0;
zy = 1;
ny = 0;
f = 1;
no = 0;     
#2 assert(out, 16'd0);     
        
	end


task assert;
 input [15:0] x, y;
begin
if(x != y)
  $display( "%t      ---------- assert failed %d != %d\n", $time, x, y );
end
endtask

endmodule
