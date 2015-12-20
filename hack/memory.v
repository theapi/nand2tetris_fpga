
module memory (
    input clk,
    input [15:0] in,
    input [14:0] address,
    input load,
    input [7:0] keyboard,
    output [15:0] out,

    // Screen
    output [12:0] screen_address, // ram address to write the pixel data
    output [15:0] screen_data,    // pixel values for ram address in the buffer
    output        screen_we      // load the screen data into the screen address
);

    reg r_screen_we;
    reg [15:0] r_screen_data;
    assign screen_data    = in;
    assign screen_address = address[12:0];
    assign screen_we      = r_screen_we;

    reg [15:0] r_out = 0;
    assign out = r_out;


    
    wire [13:0] write_address, read_address;

    wire [15:0] ram_q;
    reg ram_we;
    ram_16 ram16(
        .q(ram_q), // from ram
        .d(in), // to ram
        .write_address(address[13:0]), // where to write in ram
        .read_address(address[13:0]), // where to read from
        .we(ram_we), // do a write
        .clk(clk)
    );
    

    
    always @ (posedge clk) begin
        if (load) begin
            // Writing...
            // ram < 15'd16384; screen < 15'd24575
            if (address < 15'd16384) begin
                ram_we <= 1;
            end else if (address < 15'd24575) begin
                r_screen_we <= 1;
                r_screen_data <= in;
            end else begin
                ram_we <= 0;
                r_screen_we <= 0;
            end
        end else begin
        // Reading...
            ram_we <= 0;
            r_screen_we <= 0;
        end
        
            
        
            // 110 0000 0000 0000 is the keyboard address.
            if (address[14] == 1 && address[13] == 1) begin
                // Retun the value of the currently pressed key.
                r_out <= keyboard;
            end else if (address < 15'd16384) begin
                r_out <= ram_q;
            end else if (address < 15'd24575) begin
                r_out <= r_screen_data; // Screen memory is handled by the frame buffer.
            end else begin
                // Read other memory here...
                r_out <= 0;
            end
        
    end
    
    
    

endmodule
