

module sdram(

    //////////// CLOCK //////////
    CLOCK_50,

    //////////// OUTPUT //////////
    q,

    //////////// RESET //////////
    RESET,

    //////////// SDRAM //////////
    DRAM_ADDR,
    DRAM_BA,
    DRAM_CAS_N,
    DRAM_CKE,
    DRAM_CLK,
    DRAM_CS_N,
    DRAM_DQ,
    DRAM_DQM,
    DRAM_RAS_N,
    DRAM_WE_N,
    
    write_address,
    read_address,
    d,
    write_en
);

//=======================================================
//  PARAMETER declarations
//=======================================================


//=======================================================
//  PORT declarations
//=======================================================

    //////////// CLOCK //////////
    input               CLOCK_50;


    output       [15:0]  q;

    //////////// RESET //////////
    input               RESET;

    //////////// SDRAM //////////
    output      [12:0]  DRAM_ADDR;
    output       [1:0]  DRAM_BA;
    output              DRAM_CAS_N;
    output              DRAM_CKE;
    output              DRAM_CLK;
    output              DRAM_CS_N;
    inout       [15:0]  DRAM_DQ;
    output       [1:0]  DRAM_DQM;
    output              DRAM_RAS_N;
    output              DRAM_WE_N;

    input       [12:0]  write_address;
    input       [12:0]  read_address;
    input       [15:0]  d;
    input               write_en;

//=======================================================
//  REG/WIRE declarations
//=======================================================


//////////// AVALON CONNECTOR //////////

    // Read
    wire [31:0] read_base;
    wire        read_go;
    wire        read_buffer;
    wire        read_done;
    wire        read_early_done;
    wire        read_data_available;
    wire [15:0] output_data;

    reg [31:0]  r_read_address;
    reg         r_read_en;
    reg         r_read_buffer;

    // Write
    wire [31:0] write_base;
    wire        write_go;
    wire        write_buffer;
    wire        write_buffer_full;
    wire        write_done;
    wire [15:0] input_data;

    reg [31:0]  r_write_address = 32'b0;
    reg         r_write_en = 1'b0;
    reg         r_write_buffer;
    reg [15:0]  r_input_data;

    reg [31:0]  counter = 32'b0;
    reg [15:0]  r_q = 16'b0;

//=======================================================
//  Structural coding
//=======================================================


    qsys u0(
        .clk_clk(CLOCK_50),
        .reset_reset_n(1'b1),

        .sdram_clock_c0_clk(DRAM_CLK),
        .sdram_clock_areset_conduit_export(1'b0),

        .sdram_wire_addr(DRAM_ADDR),
        .sdram_wire_ba(DRAM_BA),
        .sdram_wire_cas_n(DRAM_CAS_N),
        .sdram_wire_cke(DRAM_CKE),
        .sdram_wire_cs_n(DRAM_CS_N),
        .sdram_wire_dq(DRAM_DQ),
        .sdram_wire_dqm(DRAM_DQM),
        .sdram_wire_ras_n(DRAM_RAS_N),
        .sdram_wire_we_n(DRAM_WE_N),

        .sdram_read_control_fixed_location  (1'b1), // do not auto increment address
        .sdram_read_control_read_base       (read_base),
        .sdram_read_control_read_length     (32'd2), // 16 bit word
        .sdram_read_control_go              (read_go),
        .sdram_read_control_done            (read_done),
        .sdram_read_control_early_done      (read_early_done),
        .sdram_read_user_read_buffer        (read_buffer),
        .sdram_read_user_buffer_output_data (output_data),
        .sdram_read_user_data_available     (read_data_available),

        .sdram_write_user_write_buffer      (write_buffer),
        .sdram_write_user_buffer_input_data (input_data),
        .sdram_write_user_buffer_full       (write_buffer_full),
        .sdram_write_control_fixed_location (1'b1), // do not auto increment address
        .sdram_write_control_write_base     (write_base),
        .sdram_write_control_write_length   (32'd2),  // 16 bit word
        .sdram_write_control_go             (write_go),
        .sdram_write_control_done           (write_done)
    );

    assign read_base    = r_read_address;
    assign read_go      = r_read_en;
    assign read_buffer  = r_read_buffer;

    assign write_buffer = r_write_buffer;
    assign input_data   = r_input_data;
    assign write_base   = r_write_address;
    assign write_go     = r_write_en;

    assign q = r_q;
    
    always @(posedge CLOCK_50) begin
        if (counter == 32'd500000) begin
            //counter <= 32'd0;
            // stop
        end else begin
            counter <= counter + 32'b1;
        end
    end

    
/*
    // Write
    always @(posedge CLOCK_50) begin
        if (counter == 32'd2) begin
            // Write data.
            r_write_address <= 32'd0;
            
            //r_input_data <= 16'b1100_1100_1100_1100;
            //r_input_data <= 16'b1010_1010_1010_1010;
            //r_input_data <= 16'b1111_0000_1110_1101;
            //r_input_data <= 16'b1111_1111_0000_0000;
            r_input_data <= 16'b0000_0000_0000_0000;
            r_write_buffer <= 1'b1;
            r_write_en <= 1'b1;
        end else begin
            // Ensure the request only lasts one clock cycle.
            r_write_buffer <= 1'b0;
            r_write_en <= 1'b0;
        end
        
    end

    // Read
    always @(posedge CLOCK_50) begin
        if (counter == 32'd3) begin
            // Send the read command.
            r_read_address <= 32'd0;
            r_read_en <= 1'b1;
        end else begin
            // Ensure the request only lasts one clock cycle.
            r_read_en <= 1'b0;
        end
    end


*/
    
    always @(posedge CLOCK_50) begin
//        if (counter < 32'd500000) begin
//            if (r_write_en) begin
//                r_write_buffer <= 1'b0;
//                r_write_en = 1'b0;
//            end else if (write_done && !write_buffer_full) begin
//                r_write_address <= r_write_address + 1'b1;
//                r_input_data <= 16'b0;
//                r_write_buffer <= 1'b1;
//                r_write_en = 1'b1;
//            end
//            
//        end else begin
            //r_write_en = 1'b0;
            if (write_en) begin
                r_write_address <= write_address;
                r_input_data <= d;
                r_write_buffer <= 1'b1;
                r_write_en = 1'b1;
            end else begin
                r_write_buffer <= 1'b0;
                r_write_en = 1'b0;
            end
            
        //end
    end
    
    // Read
    always @(posedge CLOCK_50) begin
        if (counter < 32'd50000) begin
            r_read_en <= 1'b0;
        end else begin
            if (!write_en) begin
                r_read_address <= read_address;
                r_read_en <= 1'b1;
            end else begin
                r_read_en <= 1'b0;
            end
        end
    end
    
 
    
    always @(posedge CLOCK_50) begin
        if (read_data_available) begin
            r_q <= output_data;
            r_read_buffer <= 1'b1;
        end else begin
            r_read_buffer <= 1'b0;
        end
    end


endmodule
