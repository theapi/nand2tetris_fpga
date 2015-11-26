
module leds (
    input [7:0] count,
    output led_0,
    output led_1,
    output led_2,
    output led_3,
    output led_4,
    output led_5,
    output led_6,
    output led_7
);

    assign led_0 = count[0];
    assign led_1 = count[1];
    assign led_2 = count[2];
    assign led_3 = count[3];
    assign led_4 = count[4];
    assign led_5 = count[5];
    assign led_6 = count[6];
    assign led_7 = count[7];
    
endmodule
