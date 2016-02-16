/**
 * Decodes the ps2 data into scan codes. 
 *
 * The ps2 protocol is here http://www.computer-engineering.org/ps2protocol/
 */
 
 
module ps2decoder (
    input reset,
    input i_clock,
    input i_data,
    output scan_ready,
    output [7:0] scan_code
);

    reg [7:0] r_scan_code;
    reg [3:0] state_reg;
    reg ready;


    assign scan_code = r_scan_code;
    assign scan_ready = ready;

    // i_clock is goes low 15us after the data is set.
    always @(negedge i_clock or posedge reset) begin
        if (reset) begin 
            state_reg <= 4'b0;
            r_scan_code <= 8'b0;
        end 
        else begin 
            
            case (state_reg)
            4'd0: // 1 start bit.  This is always 0.
                begin
                    state_reg <= state_reg + 1'b1;
                    ready <= 1'b0;
                end
            4'd9: // 1 parity bit (odd parity).
                begin
                    if (!i_data == ^r_scan_code) begin 
                        ready <= 1'b1;
                    end else begin
                        ready <= 1'b0;
                    end
                    state_reg <= state_reg + 1'b1;
                end
            4'd10: // 1 stop bit.  This is always 1.
                begin
                    state_reg <= 4'b0;
                    ready <= 1'b0;
                end
            default: // 8 data bits, least significant bit first.
                begin
                    //r_scan_code <= {r_scan_code[6:0], i_data};
                    r_scan_code[state_reg - 1] <= i_data;
                    state_reg <= state_reg + 1'b1;
                    ready <= 1'b0;
                end
            endcase
        end
    end

    
endmodule
