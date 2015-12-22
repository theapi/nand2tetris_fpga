
/*
 * clock for the cpu
 */
module clock_cpu (
    input clk,
    output clk_cpu
);

    reg r_clk = 0;
    reg [31:0] counter = 32'd0; 
    
    assign clk_cpu = r_clk;

    always @(posedge clk) begin
        if (counter == 32'd2500000) begin
            r_clk <= ~r_clk;
            counter <= 32'd0; 
        end else begin
            counter <= counter + 32'd1; 
        end
        
    end
 
    
endmodule
