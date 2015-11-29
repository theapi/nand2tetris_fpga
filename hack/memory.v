
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


    
    wire [13:0] write_address, read_address;
    
    
    //assign write_address = address[13:0];
    //assign read_address = address[13:0];
    
    
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
    
    
    /*
    wire [15:0] ram_a_q;
    reg ram_a_we;
    ram_8 ram_a(
        .q(ram_a_q), // from ram
        .d(in), // to ram
        .write_address(address[13:0]), // where to write in ram
        .read_address(address[13:0]), // where to read from
        .we(ram_a_we), // do a write
        .clk(clk)
    );
    
    wire [15:0] ram_b_q;
    reg ram_b_we;
    ram_le_8 ram_b(
        .q(ram_b_q), // from ram
        .d(in), // to ram
        .write_address(address[13:0] + 14'd8191), // where to write in ram
        .read_address(address[13:0] + 14'd8191), // where to read from
        .we(ram_b_we), // do a write
        .clk(clk)
    );
    */

    always @ (posedge clk) begin
        if (load) begin
            // Writing...
            if (address < 15'd8192) begin
                ram_we <= 1;
                //ram_a_we <= 1;
                //ram_b_we <= 0;
            end else if (address < 15'd16384) begin
                ram_we <= 1;
                //ram_a_we <= 0;
                //ram_b_we <= 1;
            end else begin
                ram_we <= 0;
                //ram_a_we <= 0;
                //ram_b_we <= 0;
            end
        end else begin
            // Reading...
            //ram_a_we <= 0;
            //ram_b_we <= 0;
            ram_we <= 0;
        
            // 110 0000 0000 0000 is the keyboard address.
            if (address[14] == 1 && address[13] == 1) begin
                // Retun the value of the currently pressed key.
                r_out <= keyboard;
            end else if (address < 15'd16384) begin
                r_out <= ram_q;
            /*end else if (address < 15'd8192) begin
                // Main ram a
                r_out <= ram_a_q;
            end else if (address < 15'd16384) begin
                // Main ram b
                r_out <= ram_b_q;*/
            end else begin
                // Read other memory here...
                r_out <= 0;
            end
        end
    end
    
    
    

endmodule
