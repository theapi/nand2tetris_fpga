
module memory (
    input clk,
    input [15:0] in,
    input [14:0] address,
    input load,
    input [7:0] keyboard,
    output [15:0] out

);

    reg [15:0] r_out = 0;
    assign out = r_out;


    
    wire [12:0] write_address, read_address;
    wire [15:0] ram_q;
    reg ram_we;
    
    assign write_address = address[12:0];
    assign read_address = address[12:0];
    
    ram_16 ram16(
        .q(ram_q), // from ram
        .d(in), // to ram
        .write_address(write_address), // where to write in ram
        .read_address(read_address), // where to read from
        .we(ram_we), // do a write
        .clk(clk)
    );

    always @ (posedge clk) begin
        if (load) begin
            // Writing...
        end else begin
            // Reading...
            ram_we <= 0;
        
            // 110 0000 0000 0000 is the keyboard address.
            if (address[14] == 1 && address[13] == 1) begin
                // Retun the value of the currently pressed key.
                r_out <= keyboard;
            end else if (address < 15'd16384) begin
                // Main ram
                r_out <= ram_q;
            end else begin
                // Read other memory here...
                r_out <= 0;
            end
        end
    end
    
    
    

endmodule
