

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


// Compute 1
#2
zx = 1;
nx = 1;
zy = 1;
ny = 1;
f  = 1;
no = 1;
#2 assert(out, 16'd1);

// Compute -1
#2
zx =1;
nx =1;
zy =1;
ny =0;
f  =1;
no =0;
#2 assert(out, -16'd1);

// Compute x
#2
 zx =0;
 nx =0;
 zy =1;
 ny =1;
 f  =0;
 no =0;
#2 assert(out, 16'd0);

// Compute y
#2
 zx =1;
 nx =1;
 zy =0;
 ny =0;
 f  =0;
 no =0;
#2 assert(out, 16'b1111111111111111);


// Compute !x
#2
 zx =0;
 nx =0;
 zy =1;
 ny =1;
 f  =0;
 no =1;
#2 assert(out, 16'b1111111111111111);


// Compute !y
#2
 zx =1;
 nx =1;
 zy =0;
 ny =0;
 f  =0;
 no =1;
#2 assert(out, 16'b0000000000000000);



// Compute -x
#2
 zx =0;
 nx =0;
 zy =1;
 ny =1;
 f  =1;
 no =1;
#2 assert(out, 16'b0000000000000000);


// Compute -y
#2
 zx =1;
 nx =1;
 zy =0;
 ny =0;
 f  =1;
 no =1;
#2 assert(out, 16'b0000000000000001);


// Compute x + 1
#2
 zx =0;
 nx =1;
 zy =1;
 ny =1;
 f  =1;
 no =1;
#2 assert(out, 16'b0000000000000001);


// Compute y + 1
#2
 zx =1;
 nx =1;
 zy =0;
 ny =1;
 f  =1;
 no =1;
#2 assert(out, 16'b0000000000000000);


// Compute x - 1
#2
 zx =0;
 nx =0;
 zy =1;
 ny =1;
 f  =1;
 no =0;
#2 assert(out, 16'b1111111111111111);


// Compute y - 1
#2
 zx =1;
 nx =1;
 zy =0;
 ny =0;
 f  =1;
 no =0;
#2 assert(out, 16'b1111111111111110);


// Compute x + y
#2
 zx =0;
 nx =0;
 zy =0;
 ny =0;
 f  =1;
 no =0;
#2 assert(out, 16'b1111111111111111);


// Compute x - y
#2
 zx =0;
 nx =1;
 zy =0;
 ny =0;
 f  =1;
 no =1;
#2 assert(out, 16'b0000000000000001);


// Compute y - x
#2
 zx =0;
 nx =0;
 zy =0;
 ny =1;
 f  =1;
 no =1;
#2 assert(out, 16'b1111111111111111);


// Compute x & y
#2
 zx =0;
 nx =0;
 zy =0;
 ny =0;
 f  =0;
 no =0;
#2 assert(out, 16'b0000000000000000);


// Compute x | y
#2
 zx =0;
 nx =1;
 zy =0;
 ny =1;
 f  =0;
 no =1;
#2 assert(out, 16'b1111111111111111);


x = 16'B000000000010001;  // x = 17
y = 16'B000000000000011;  // y =  3


// Compute 0
#2
 zx =1;
 nx =0;
 zy =1;
 ny =0;
 f  =1;
 no =0;
#2 assert(out, 16'b0000000000000000);


// Compute 1
#2
 zx =1;
 nx =1;
 zy =1;
 ny =1;
 f  =1;
 no =1;
#2 assert(out, 16'b0000000000000001);


// Compute -1
#2
 zx =1;
 nx =1;
 zy =1;
 ny =0;
 f  =1;
 no =0;
#2 assert(out, 16'b1111111111111111 );


// Compute x
#2
 zx =0;
 nx =0;
 zy =1;
 ny =1;
 f  =0;
 no =0;
#2 assert(out, 16'b0000000000010001);


// Compute y
#2
 zx =1;
 nx =1;
 zy =0;
 ny =0;
 f  =0;
 no =0;
#2 assert(out, 16'b0000000000000011 );


// Compute !x
#2
 zx =0;
 nx =0;
 zy =1;
 ny =1;
 f  =0;
 no =1;
#2 assert(out, 16'b1111111111101110 );


// Compute !y
#2
 zx =1;
 nx =1;
 zy =0;
 ny =0;
 f  =0;
 no =1;
#2 assert(out, 16'b1111111111111100 );


// Compute -x
#2
 zx =0;
 nx =0;
 zy =1;
 ny =1;
 f  =1;
 no =1;
#2 assert(out, 16'b1111111111101111 );


// Compute -y
#2
 zx =1;
 nx =1;
 zy =0;
 ny =0;
 f  =1;
 no =1;
#2 assert(out, 16'b1111111111111101  );


// Compute x + 1
#2
 zx =0;
 nx =1;
 zy =1;
 ny =1;
 f  =1;
 no =1;
#2 assert(out, 16'b0000000000010010  );


// Compute y + 1
#2
 zx =1;
 nx =1;
 zy =0;
 ny =1;
 f  =1;
 no =1;
#2 assert(out, 16'b0000000000000100  );


// Compute x - 1
#2
 zx =0;
 nx =0;
 zy =1;
 ny =1;
 f  =1;
 no =0;
#2 assert(out, 16'b0000000000010000  );


// Compute y - 1
#2
 zx =1;
 nx =1;
 zy =0;
 ny =0;
 f  =1;
 no =0;
#2 assert(out, 16'b0000000000000010  );


// Compute x + y
#2
 zx =0;
 nx =0;
 zy =0;
 ny =0;
 f  =1;
 no =0;
#2 assert(out, 16'b0000000000010100  );


// Compute x - y
#2
 zx =0;
 nx =1;
 zy =0;
 ny =0;
 f  =1;
 no =1;
#2 assert(out, 16'b0000000000001110  );


// Compute y - x
#2
 zx =0;
 nx =0;
 zy =0;
 ny =1;
 f  =1;
 no =1;
#2 assert(out, 16'b1111111111110010  );


// Compute x & y
#2
 zx =0;
 nx =0;
 zy =0;
 ny =0;
 f  =0;
 no =0;
#2 assert(out, 16'b0000000000000001  );


// Compute x | y
#2
 zx =0;
 nx =1;
 zy =0;
 ny =1;
 f  =0;
 no =1;
#2 assert(out, 16'b0000000000010011  );




 
	end


task assert;
 input [15:0] x, y;
begin
if(x != y)
  $display( "%t      ---------- assert failed %b != %b\n", $time, x, y );
end
endtask

endmodule
