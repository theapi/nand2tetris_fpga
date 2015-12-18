module register (
    output reg [15:0] q,
    input [15:0] d,
    input we, clk
);

    reg [15:0] mem = 0;
    
    always @ (posedge clk) begin
        if (we) begin 
            mem <= d;
            q <= d;
        end else begin
            q <= mem;
        end
    end
    
endmodule
