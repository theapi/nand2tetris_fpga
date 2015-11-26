
module ascii (
    input scan_ready,
    input [7:0] scan_code,
    output [7:0] ascii
);

    // @todo: shift, alt etc
    
    reg [7:0] r_ascii;
    assign ascii = r_ascii;
    
    reg keyup = 0;


    always @(posedge scan_ready) begin
       
        if (scan_code == 8'hf0) begin
            keyup <= 1;
        end else begin
            if (keyup) begin
                keyup <= 0;
                r_ascii <= 8'd0;
            end else 
            case (scan_code)
            
                8'h29: r_ascii <= 8'd32;  // [space]
                
                8'h45: r_ascii <= 8'd48;  // 0
                8'h16: r_ascii <= 8'd49;  // 1
                8'h1e: r_ascii <= 8'd50;  // 2
                8'h26: r_ascii <= 8'd51;  // 3
                8'h25: r_ascii <= 8'd52;  // 4
                8'h2e: r_ascii <= 8'd53;  // 5
                8'h36: r_ascii <= 8'd54;  // 6
                8'h3d: r_ascii <= 8'd55;  // 7
                8'h3e: r_ascii <= 8'd56;  // 8
                8'h46: r_ascii <= 8'd57;  // 9
                
                8'h1c: r_ascii <= 8'd97;  // a
                8'h32: r_ascii <= 8'd98;  // b
                8'h21: r_ascii <= 8'd99;  // c
                8'h23: r_ascii <= 8'd100; // d
                8'h24: r_ascii <= 8'd101; // e
                8'h2b: r_ascii <= 8'd102; // f
                8'h34: r_ascii <= 8'd103; // g
                8'h33: r_ascii <= 8'd104; // h
                8'h43: r_ascii <= 8'd105; // i
                8'h3b: r_ascii <= 8'd106; // j
                8'h42: r_ascii <= 8'd107; // k
                8'h4b: r_ascii <= 8'd108; // l
                8'h3a: r_ascii <= 8'd109; // m
                8'h31: r_ascii <= 8'd110; // n
                8'h44: r_ascii <= 8'd111; // o
                8'h4d: r_ascii <= 8'd112; // p
                8'h15: r_ascii <= 8'd113; // q
                8'h2d: r_ascii <= 8'd114; // r
                8'h1b: r_ascii <= 8'd115; // s
                8'h2c: r_ascii <= 8'd116; // t
                8'h3c: r_ascii <= 8'd117; // u
                8'h2a: r_ascii <= 8'd118; // v
                8'h1d: r_ascii <= 8'd119; // w
                8'h22: r_ascii <= 8'd120; // x
                8'h35: r_ascii <= 8'd121; // y
                8'h1a: r_ascii <= 8'd122; // z
                
                default: r_ascii <= 8'd0; // nothing
            endcase
        end

    end
    
endmodule
