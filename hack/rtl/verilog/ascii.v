
module ascii (
    input clk,
    input scan_ready,
    input [7:0] scan_code,
    output [7:0] ascii
);

    reg [7:0] r_ascii;
    reg [1:0] scan_ready_edge_detect = 2'b00;
    assign ascii = r_ascii;
    
    //reg keyup = 0;
    reg extended = 0;
    reg shift = 0;
    reg [1:0] caps = 2'b00;
    wire caps_lock;
    
    reg [7:0] code;



    reg [7:0] key_code [2:0];
    reg [1:0] key_mem_index = 2'b00;
    reg [1:0] key_current_index = 2'b00;
    reg key_clear = 0;
    
    reg [7:0] current_code;
    reg [7:0] break_code;
    reg [7:0] state_code;
    reg [2:0] state_reg = 2'b00;
    // state machine parameters
    parameter st_idle   = 3'b000;
    parameter st_code_1   = 3'b001;
    parameter st_code_2   = 3'b010;
    parameter st_code_3   = 3'b011;
    parameter st_break    = 3'b100;
    parameter st_extended = 3'b101;
    parameter st_ready    = 3'b110;

    

    assign caps_lock = caps[0]; // odd number of presses
    
    // posedge of the ps2 clock
    always @(posedge clk) begin
        scan_ready_edge_detect <= {scan_ready_edge_detect[0], scan_ready};
    end      
    

    always @(posedge clk) begin
        case (state_reg) 
            st_idle:
                begin
                    if (scan_ready_edge_detect == 2'b01) begin
                       current_code <= scan_code;
                       state_reg <= st_code_1;
                    end 
                end
            st_code_1:
                begin
                    state_code <= current_code;
                    state_reg <= st_code_2;
                end
            st_code_2:
                begin
                    // break code
                    if (state_code == 8'hf0) begin
                        state_reg <= st_break;
                    end else begin
                        state_reg <= st_code_3;
                    end
                end
            st_code_3:
                begin
                    state_reg <= st_ready;
                end
            st_break:
                begin
                    // key up
                    code <= 8'h00;
                    if (scan_ready_edge_detect == 2'b01) begin
                       state_reg <= st_idle;
                       break_code <= scan_code;
                    end 
                end
            st_extended:
                begin
                
                end
            st_ready:
                begin
                    code <= state_code;
                    state_reg <= st_idle;
                end
            default:
                begin
                
                end
        endcase
        
    end
    
    // Caps lock
    always @(posedge clk) begin
        if (scan_ready_edge_detect == 2'b01 && code == 8'h58) begin
            caps <= caps + 2'b1;
        end
    end
    
    // LEFT SHIFT || RIGHT SHIFT
    always @(posedge clk) begin
        if (code == 8'h12 || code == 8'h59) begin
            shift <= 1;
        end else if (break_code == 8'h12 || break_code == 8'h59) begin
            shift <= 0;
        end
    end
    
    /*
    // Store char codes & remove then when their break code arrives.
    always @(posedge clk) begin
        if (scan_ready_edge_detect == 2'b01) begin
        
            // LEFT SHIFT || RIGHT SHIFT
            if (scan_code == 8'h12 || scan_code == 8'h59) begin
                if (key_clear) begin
                    shift <= 0;
                end else begin
                    shift <= 1;
                end
            end else if (scan_code == 8'hf0) begin // break code
                // Clear the next scan code from the key_code memory.
                key_clear <= 1'b1;
            end else if (key_clear) begin
                // Find the key code in the memory & clear it.
                key_clear <= 1'b0;
                extended <= 1'b0;
                if (key_code[0] == scan_code) begin
                    key_code[0] <= 8'h00;
                    
//                    if (key_current_index == 2'b0) begin
//                        key_current_index <= 2'b10;
//                    end else begin
//                        key_current_index <= key_current_index - 1'b1;
//                    end
                    
                end 
                else if (key_code[1] == scan_code) begin
                    key_code[1] <= 8'h00;
                    
//                    if (key_current_index == 2'b0) begin
//                        key_current_index <= 2'b10;
//                    end else begin
//                        key_current_index <= key_current_index - 1'b1;
//                    end
                    
                end 
                else if (key_code[2] == scan_code) begin
                    key_code[2] <= 8'h00;
                    
//                    if (key_current_index == 2'b0) begin
//                        key_current_index <= 2'b10;
//                    end else begin
//                        key_current_index <= key_current_index - 1'b1;
//                    end
                    
                end
            end else begin
                // Store the key code.
                key_current_index <= key_mem_index;
                if (key_mem_index == 2'b10) begin
                    key_mem_index <= 2'b00;
                end else begin
                    key_mem_index <= key_mem_index + 2'b01;
                end
                key_code[key_mem_index] <= scan_code; 
            end
            
            
            
            
            if (scan_code == 8'he0) begin
                // extended make codes
                extended <= 1'b1;
            end
            
            // Caps lock
            if (code == 8'h58) begin
                caps = caps + 2'b01;
            end
            
        end
    end
    
    always @(posedge clk) begin
        code <= key_code[key_current_index];  
    end
    */


    always @(posedge clk) begin

        if (extended) begin
            //extended <= 0;
            case (code)
            
                // nand2tetris special codes
                8'h6b: r_ascii <= 8'd130; // L ARROW
                8'h75: r_ascii <= 8'd131; // UP ARROW
                8'h74: r_ascii <= 8'd132; // R ARROW
                8'h72: r_ascii <= 8'd133; // DOWN ARROW
                8'h6c: r_ascii <= 8'd134; // HOME
                8'h69: r_ascii <= 8'd135; // END
                8'h7d: r_ascii <= 8'd136; // PAGE UP
                8'h7a: r_ascii <= 8'd137; // PAGE DOWN
                8'h70: r_ascii <= 8'd138; // INSERT
                8'h71: r_ascii <= 8'd139; // DELETE
                
                default: r_ascii <= 8'd0; // null
            endcase
        end else
        if ((shift && !caps_lock) || (caps_lock && !shift)) begin     
            case (code)
            
                8'h29: r_ascii <= 8'd32; // [space]
                8'h16: r_ascii <= 8'd33; // !
                8'h52: r_ascii <= 8'd34; // "
                8'h26: r_ascii <= 8'd35; // #
                8'h25: r_ascii <= 8'd36; // $
                8'h2e: r_ascii <= 8'd37; // %
                8'h3d: r_ascii <= 8'd38; // &
                
                8'h46: r_ascii <= 8'd40; // (
                8'h45: r_ascii <= 8'd41; // )
                8'h3e: r_ascii <= 8'd42; // *
                8'h55: r_ascii <= 8'd43; // +
                
                8'h4c: r_ascii <= 8'd58; // :
            
                8'h41: r_ascii <= 8'd60; // <
                8'h49: r_ascii <= 8'd62; // >
                8'h4a: r_ascii <= 8'd63; // ?
                8'h1e: r_ascii <= 8'd64; // @
                8'h1c: r_ascii <= 8'd65; // A
                8'h32: r_ascii <= 8'd66; // B
                8'h21: r_ascii <= 8'd67; // C
                8'h23: r_ascii <= 8'd68; // D
                8'h24: r_ascii <= 8'd69; // E
                8'h2b: r_ascii <= 8'd70; // F
                8'h34: r_ascii <= 8'd71; // G
                8'h33: r_ascii <= 8'd72; // H
                8'h43: r_ascii <= 8'd73; // I
                8'h3b: r_ascii <= 8'd74; // J
                8'h42: r_ascii <= 8'd75; // K
                8'h4b: r_ascii <= 8'd76; // L
                8'h3a: r_ascii <= 8'd77; // M
                8'h31: r_ascii <= 8'd78; // N
                8'h44: r_ascii <= 8'd79; // O
                8'h4d: r_ascii <= 8'd80; // P
                8'h15: r_ascii <= 8'd81; // Q
                8'h2d: r_ascii <= 8'd82; // R
                8'h1b: r_ascii <= 8'd83; // S
                8'h2c: r_ascii <= 8'd84; // T
                8'h3c: r_ascii <= 8'd85; // U
                8'h2a: r_ascii <= 8'd86; // V
                8'h1d: r_ascii <= 8'd87; // W
                8'h22: r_ascii <= 8'd88; // X
                8'h35: r_ascii <= 8'd89; // Y
                8'h1a: r_ascii <= 8'd90; // Z
                
                8'h36: r_ascii <= 8'd94; // ^
                8'h4e: r_ascii <= 8'd95; // _
                
                8'h54: r_ascii <= 8'd123; // {
                8'h5d: r_ascii <= 8'd124; // |
                8'h5b: r_ascii <= 8'd125; // }
                8'h0e: r_ascii <= 8'd126; // ~
                
                
                default: r_ascii <= 8'd0; // null
            endcase
        end else begin
            case (code)
                8'h0d: r_ascii <= 8'd9;  // [tab]
                //8'h14: r_ascii <=  L CTRL
                //8'h11: r_ascii <=  L ALT
                //8'h7e: r_ascii <=  SCROLL
                //8'h77: r_ascii <=  NUM
                
                
                8'h29: r_ascii <= 8'd32;  // [space]
                8'h52: r_ascii <= 8'd39;  // '
                8'h7c: r_ascii <= 8'd42;  // KP *
                8'h79: r_ascii <= 8'd43;  // KP +
                8'h41: r_ascii <= 8'd44;  // ,
                8'h49: r_ascii <= 8'd46;  // .
                8'h71: r_ascii <= 8'd46;  // KP .
                8'h4e: r_ascii <= 8'd45;  // -
                8'h7b: r_ascii <= 8'd45;  // KP -
                8'h4a: r_ascii <= 8'd47;  // /
                
                8'h45: r_ascii <= 8'd48;  // 0
                8'h70: r_ascii <= 8'd48;  // KP 0
                8'h16: r_ascii <= 8'd49;  // 1
                8'h69: r_ascii <= 8'd49;  // KP 1
                8'h1e: r_ascii <= 8'd50;  // 2
                8'h72: r_ascii <= 8'd50;  // KP 2
                8'h26: r_ascii <= 8'd51;  // 3
                8'h7a: r_ascii <= 8'd51;  // KP 3
                8'h25: r_ascii <= 8'd52;  // 4
                8'h6b: r_ascii <= 8'd52;  // KP 4
                8'h2e: r_ascii <= 8'd53;  // 5
                8'h73: r_ascii <= 8'd53;  // KP 5
                8'h36: r_ascii <= 8'd54;  // 6
                8'h74: r_ascii <= 8'd54;  // KP 6
                8'h3d: r_ascii <= 8'd55;  // 7
                8'h6c: r_ascii <= 8'd55;  // KP 7
                8'h3e: r_ascii <= 8'd56;  // 8
                8'h75: r_ascii <= 8'd56;  // KP 8
                8'h46: r_ascii <= 8'd57;  // 9
                8'h7d: r_ascii <= 8'd57;  // KP 9
                8'h4c: r_ascii <= 8'd59;  // ;
                8'h55: r_ascii <= 8'd61;  // =
                
                8'h54: r_ascii <= 8'd91;  // [
                8'h5d: r_ascii <= 8'd92;  // \
                8'h5b: r_ascii <= 8'd93;  // ]
                8'h0e: r_ascii <= 8'd96;  // `
                
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
        
                
                
                // nand2tetris special codes
                8'h5a: r_ascii <= 8'd128;  // [enter]
                8'h66: r_ascii <= 8'd129;  // [back space]
                8'h76: r_ascii <= 8'd140;  // ESCAPE
                8'h05: r_ascii <= 8'd141;  // F1
                8'h06: r_ascii <= 8'd142;  // F2
                8'h04: r_ascii <= 8'd143;  // F3
                8'h0c: r_ascii <= 8'd144;  // F4
                8'h03: r_ascii <= 8'd145;  // F5
                8'h0b: r_ascii <= 8'd146;  // F6
                8'h83: r_ascii <= 8'd147;  // F7
                8'h0a: r_ascii <= 8'd148;  // F8
                8'h01: r_ascii <= 8'd149;  // F9
                8'h09: r_ascii <= 8'd150;  // F10
                8'h78: r_ascii <= 8'd151;  // F11
                8'h07: r_ascii <= 8'd152;  // F12
                
                
                default: r_ascii <= 8'd0; // null
            endcase
        end
        
    end
    
endmodule
