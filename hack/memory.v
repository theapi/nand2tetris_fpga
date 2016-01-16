
module memory (
    input clk,
    input [15:0] in,
    input [14:0] address,
    input [12:0] screen_read_address,
    input load,
    input [7:0] keyboard,
    output [15:0] out,

    // Screen
    //output [12:0] screen_address, // ram address to write the pixel data
    //output [15:0] screen_data,    // pixel values for ram address in the buffer
    //output        screen_we,      // load the screen data into the screen address
    output [15:0] read_value,
    
    
    //////////// SDRAM //////////
    output      [12:0]  DRAM_ADDR,
    output       [1:0]  DRAM_BA,
    output              DRAM_CAS_N,
    output              DRAM_CKE,
    output              DRAM_CLK,
    output              DRAM_CS_N,
    inout       [15:0]  DRAM_DQ,
    output       [1:0]  DRAM_DQM,
    output              DRAM_RAS_N,
    output              DRAM_WE_N,
    
    output ready
);

    reg [31:0]  timer = 32'b0;
    reg r_ready = 1'b0;
    assign ready = r_ready; // Set to ready when memory is initialised.

    reg r_screen_we;
    reg [14:0] r_screen_address;
    reg [15:0] r_screen_data;
    //assign screen_data    = r_screen_data;
    //assign screen_data    = in;
    //assign screen_address = r_screen_address[12:0];
    //assign screen_address = address[12:0];
    //assign screen_we      = r_screen_we;
    //assign screen_we      = 1'b1;

    reg [15:0] r_out = 16'b0;
    assign out = r_out;

    reg [15:0] r_in;
    
    reg[15:0] r_mem_ram;
    
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
    
    
    // Screen ram
    vga_ram vgaram(
        .q(read_value), // from ram
        .d(in), // to ram
        .write_address(address[12:0]), // where to write in ram
        .read_address(screen_read_address), // where to read from
        .we(r_screen_we), // do a write
        .clk(clk)
    );
    
    
/*
    sdram sdram_inst(
        .CLOCK_50(clk) ,	// input  CLOCK_50_sig
        .q(read_value) ,	// output [15:0] q_sig
        .RESET(1'b0) ,	// input  RESET_sig
        .DRAM_ADDR(DRAM_ADDR) ,	// output [12:0] DRAM_ADDR_sig
        .DRAM_BA(DRAM_BA) ,	// output [1:0] DRAM_BA_sig
        .DRAM_CAS_N(DRAM_CAS_N) ,	// output  DRAM_CAS_N_sig
        .DRAM_CKE(DRAM_CKE) ,	// output  DRAM_CKE_sig
        .DRAM_CLK(DRAM_CLK) ,	// output  DRAM_CLK_sig
        .DRAM_CS_N(DRAM_CS_N) ,	// output  DRAM_CS_N_sig
        .DRAM_DQ(DRAM_DQ) ,	// inout [15:0] DRAM_DQ_sig
        .DRAM_DQM(DRAM_DQM) ,	// output [1:0] DRAM_DQM_sig
        .DRAM_RAS_N(DRAM_RAS_N) ,	// output  DRAM_RAS_N_sig
        .DRAM_WE_N(DRAM_WE_N), 	// output  DRAM_WE_N_sig
        
        .write_address(address), // where to write in ram
        .read_address(screen_read_address),
        //.d(16'b0),
        .d(in),
        .write_en(r_screen_we)
    );
*/

    always @(posedge clk) begin
        if (timer == 32'd25000000) begin
            // ready
            r_ready <= 1'b1;
        end else begin
            timer <= timer + 32'b1;
        end
    end
 
    
    always @(*) begin
        if (address < 15'd16384) begin
            r_out = ram_q;
        end else begin
            r_out = read_value;
        end
    end
    
    always @ (posedge clk) begin
        ram_we = 1'b0;
        if (load) begin
            if (address < 15'd16384) begin
                ram_we = 1'b1;
            end
        end
        
    end
    
    
    always @ (posedge clk) begin
        r_screen_we = 1'b0;
        if (load) begin
            if (address >= 15'd16384) begin
                r_screen_we = 1'b1;
            end
        end
        
    end
    
    /*
     always @ (posedge clk) begin
//        r_screen_we = 1'b0;
//        r_screen_data = 1'b0;
//        r_screen_address = 1'b0;
         
        if (load) begin
            if (address < 15'd16384) begin
                //r_screen_we <= 1'b0;
            end else if (address < 15'd24575) begin
                //r_screen_we <= 1'b1;
                //r_screen_address <= address - 15'd16384;
                r_screen_data <= in;
            end
            
        end
        
    end
    */
    
    /*
    always @ (posedge clk) begin
//        r_screen_we = 1'b0;
//        r_screen_data = 1'b0;
//        r_screen_address = 1'b0;
         
        if (load) begin
            if (address < 15'd16384) begin
                r_screen_we <= 1'b0;
            end else if (address < 15'd24575) begin
                r_screen_we <= 1'b1;
                //r_screen_address <= address - 15'd16384;
                r_screen_address <= address;
                r_screen_data <= in;
            end
            
        end else begin
            r_screen_we <= 1'b0;
        end
        
    end
    */
    
    /*
        always @ (posedge clk) begin
        ram_we = 1'b0;
        r_screen_we = 1'b0;
        r_screen_data = 1'b0;
        r_screen_address = 1'b0;
         
        if (load) begin
            if (address < 15'd16384) begin
                ram_we = 1'b1;
                r_screen_we = 1'b0;
            end else if (address < 15'd24575) begin
                ram_we = 1'b0;
                r_screen_we = 1'b1;
                r_screen_address = address[12:0] - 15'd16384;
                r_screen_we = 1'b1;
                r_screen_data = in;
            end
            
        end
        
    end
    */
    
    always @ (posedge clk) begin
        if (load) begin
            if (address < 15'd16384) begin 
                //r_in = in;
                //r_screen_we <= 1'b0;
            end else if (address < 15'd24575) begin 
                //r_screen_data <= in;
                                
            end
        end
    end
    
    

endmodule
