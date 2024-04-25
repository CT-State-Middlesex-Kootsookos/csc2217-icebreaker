/* Attempt to implement baseball counter. */

`include "debouncer.v"

module top (
    input CLK,
	output LED1,
	output LED2,
	output LED3,
	output LED4,
	output LED5,

	input BTN1,
	input BTN2,
	input BTN3
);

    reg[0:0] strike_button ;
    reg[0:0] ball_button ;
    reg[0:0] clear_button ;

	reg [2:0] ball_counter ;
	reg [1:0] stike_counter ;

    wire clear_all;

    debounce db1(CLK, BTN1, strike_button);
    debounce db2(CLK, BTN2, ball_button);
    debounce db3(CLK, BTN3, clear_button);

    assign clear_all = clear_button || (strike_button && (stike_counter == 3)) || (ball_button && ball_counter == 7);

    always @(posedge strike_button)
    begin
        if (stike_counter == 3 || clear_all == 1)
            stike_counter <= 0;
        else
            stike_counter <= (stike_counter << 1) + 1;
    end

    always @(posedge ball_button)
    begin
        if (ball_counter == 7 || clear_all == 1)
            ball_counter <= 0;
        else
            ball_counter <= (ball_counter << 1) + 1;
    end

    assign {LED1, LED2, LED3} = ball_counter;
    assign {LED4, LED5} = stike_counter;

endmodule