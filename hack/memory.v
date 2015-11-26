
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

    always @ (posedge clk) begin
        if (load) begin
            // Set memory stuff here...
        end else begin
            // 110 0000 0000 0000 is the keboard address.
            if (address[14] == 1 && address[13] == 1) begin
                // Retun the value of the cuurently pressed key.
                r_out <= keyboard;
            end else begin
                // Read other memory here...
            end
        end
    end

endmodule
