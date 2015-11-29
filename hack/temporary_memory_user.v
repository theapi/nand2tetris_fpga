
/**
 * Read the memory to stop it being optimized away - TEMPORARY.
 */

 module temporary_memory_user(
    input clk,
    input reset,
    
    output load,
    output [14:0] address,
    output [15:0] out
 );

    reg [14:0] r_address;
    reg toggle = 0;
    reg we = 0;
    reg [15:0] data;
    
    assign address = r_address;
    assign out = data;
    assign load = we;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin 
            r_address <= 0;
            data <= 0;
        end else if (toggle) begin
            toggle <= !toggle;
            r_address <= r_address + 15'd1;
            we <= 0;
        end else begin
            we <= 1;
            toggle <= !toggle;
            data <= {1'b0, r_address};
        end
    end
 
endmodule
