

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

$display("x, y, zx, nx, zy, ny, f, no, out, zr, ng");


x = 16'B0000000000000000;
y = 16'B1111111111111111;

// Compute 0 
zx = 1;
nx = 0;
zy = 1;
ny = 0;
f = 1;
no = 0;
#2 assert_alu(16'b0000000000000000, 1'b1, 1'b0);


// Compute 1 
zx = 1;
nx = 1;
zy = 1;
ny = 1;
f = 1;
no = 1;
#2 assert_alu(16'b0000000000000001, 1'b0, 1'b0);


// Compute -1 
zx = 1;
nx = 1;
zy = 1;
ny = 0;
f = 1;
no = 0;
#2 assert_alu(16'b1111111111111111, 1'b0, 1'b1);


// Compute x 
zx = 0;
nx = 0;
zy = 1;
ny = 1;
f = 0;
no = 0;
#2 assert_alu(16'b0000000000000000, 1'b1, 1'b0);


// Compute y 
zx = 1;
nx = 1;
zy = 0;
ny = 0;
f = 0;
no = 0;
#2 assert_alu(16'b1111111111111111, 1'b0, 1'b1);


// Compute !x 
zx = 0;
nx = 0;
zy = 1;
ny = 1;
f = 0;
no = 1;
#2 assert_alu(16'b1111111111111111, 1'b0, 1'b1);


// Compute !y 
zx = 1;
nx = 1;
zy = 0;
ny = 0;
f = 0;
no = 1;
#2 assert_alu(16'b0000000000000000, 1'b1, 1'b0);


// Compute -x 
zx = 0;
nx = 0;
zy = 1;
ny = 1;
f = 1;
no = 1;
#2 assert_alu(16'b0000000000000000, 1'b1, 1'b0);


// Compute -y 
zx = 1;
nx = 1;
zy = 0;
ny = 0;
f = 1;
no = 1;
#2 assert_alu(16'b0000000000000001, 1'b0, 1'b0);


// Compute x + 1 
zx = 0;
nx = 1;
zy = 1;
ny = 1;
f = 1;
no = 1;
#2 assert_alu(16'b0000000000000001, 1'b0, 1'b0);


// Compute y + 1 
zx = 1;
nx = 1;
zy = 0;
ny = 1;
f = 1;
no = 1;
#2 assert_alu(16'b0000000000000000, 1'b1, 1'b0);


// Compute x - 1 
zx = 0;
nx = 0;
zy = 1;
ny = 1;
f = 1;
no = 0;
#2 assert_alu(16'b1111111111111111, 1'b0, 1'b1);


// Compute y - 1 
zx = 1;
nx = 1;
zy = 0;
ny = 0;
f = 1;
no = 0;
#2 assert_alu(16'b1111111111111110, 1'b0, 1'b1);


// Compute x + y 
zx = 0;
nx = 0;
zy = 0;
ny = 0;
f = 1;
no = 0;
#2 assert_alu(16'b1111111111111111, 1'b0, 1'b1);


// Compute x - y 
zx = 0;
nx = 1;
zy = 0;
ny = 0;
f = 1;
no = 1;
#2 assert_alu(16'b0000000000000001, 1'b0, 1'b0);


// Compute y - x 
zx = 0;
nx = 0;
zy = 0;
ny = 1;
f = 1;
no = 1;
#2 assert_alu(16'b1111111111111111, 1'b0, 1'b1);


// Compute x & y 
zx = 0;
nx = 0;
zy = 0;
ny = 0;
f = 0;
no = 0;
#2 assert_alu(16'b0000000000000000, 1'b1, 1'b0);


// Compute x | y 
zx = 0;
nx = 1;
zy = 0;
ny = 1;
f = 0;
no = 1;
#2 assert_alu(16'b1111111111111111, 1'b0, 1'b1);

x = 16'B000000000010001;
y = 16'B000000000000011;

// Compute 0 
zx = 1;
nx = 0;
zy = 1;
ny = 0;
f = 1;
no = 0;
#2 assert_alu(16'b0000000000000000, 1'b1, 1'b0);


// Compute 1 
zx = 1;
nx = 1;
zy = 1;
ny = 1;
f = 1;
no = 1;
#2 assert_alu(16'b0000000000000001, 1'b0, 1'b0);


// Compute -1 
zx = 1;
nx = 1;
zy = 1;
ny = 0;
f = 1;
no = 0;
#2 assert_alu(16'b1111111111111111, 1'b0, 1'b1);


// Compute x 
zx = 0;
nx = 0;
zy = 1;
ny = 1;
f = 0;
no = 0;
#2 assert_alu(16'b0000000000010001, 1'b0, 1'b0);


// Compute y 
zx = 1;
nx = 1;
zy = 0;
ny = 0;
f = 0;
no = 0;
#2 assert_alu(16'b0000000000000011, 1'b0, 1'b0);


// Compute !x 
zx = 0;
nx = 0;
zy = 1;
ny = 1;
f = 0;
no = 1;
#2 assert_alu(16'b1111111111101110, 1'b0, 1'b1);


// Compute !y 
zx = 1;
nx = 1;
zy = 0;
ny = 0;
f = 0;
no = 1;
#2 assert_alu(16'b1111111111111100, 1'b0, 1'b1);


// Compute -x 
zx = 0;
nx = 0;
zy = 1;
ny = 1;
f = 1;
no = 1;
#2 assert_alu(16'b1111111111101111, 1'b0, 1'b1);


// Compute -y 
zx = 1;
nx = 1;
zy = 0;
ny = 0;
f = 1;
no = 1;
#2 assert_alu(16'b1111111111111101, 1'b0, 1'b1);


// Compute x + 1 
zx = 0;
nx = 1;
zy = 1;
ny = 1;
f = 1;
no = 1;
#2 assert_alu(16'b0000000000010010, 1'b0, 1'b0);


// Compute y + 1 
zx = 1;
nx = 1;
zy = 0;
ny = 1;
f = 1;
no = 1;
#2 assert_alu(16'b0000000000000100, 1'b0, 1'b0);


// Compute x - 1 
zx = 0;
nx = 0;
zy = 1;
ny = 1;
f = 1;
no = 0;
#2 assert_alu(16'b0000000000010000, 1'b0, 1'b0);


// Compute y - 1 
zx = 1;
nx = 1;
zy = 0;
ny = 0;
f = 1;
no = 0;
#2 assert_alu(16'b0000000000000010, 1'b0, 1'b0);


// Compute x + y 
zx = 0;
nx = 0;
zy = 0;
ny = 0;
f = 1;
no = 0;
#2 assert_alu(16'b0000000000010100, 1'b0, 1'b0);


// Compute x - y 
zx = 0;
nx = 1;
zy = 0;
ny = 0;
f = 1;
no = 1;
#2 assert_alu(16'b0000000000001110, 1'b0, 1'b0);


// Compute y - x 
zx = 0;
nx = 0;
zy = 0;
ny = 1;
f = 1;
no = 1;
#2 assert_alu(16'b1111111111110010, 1'b0, 1'b1);


// Compute x & y 
zx = 0;
nx = 0;
zy = 0;
ny = 0;
f = 0;
no = 0;
#2 assert_alu(16'b0000000000000001, 1'b0, 1'b0);


// Compute x | y 
zx = 0;
nx = 1;
zy = 0;
ny = 1;
f = 0;
no = 1;
#2 assert_alu(16'b0000000000010011, 1'b0, 1'b0);

 
	end

task assert_alu;
    input [15:0] i_out;
    input i_zr, i_ng;
    
    begin
        if (out != i_out
            || zr != i_zr
            || ng != i_ng) begin
            
            $display ("%b %b %b : assert failed", 
                out, zr, ng);
            $display ("%b %b %b <- should be this", 
                i_out, i_zr, i_ng);
        end
    end
endtask
    
    
task assert;
 input [15:0] x, y;
begin
if(x != y)
  $display( "%t      ---------- assert failed %b != %b\n", $time, x, y );
end
endtask

endmodule
