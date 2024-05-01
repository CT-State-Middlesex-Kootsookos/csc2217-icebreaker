/* Attempt to implement baseball counter. */

`include "debouncer.v"
`include "slow_clock.v"

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

    reg strike_button ;
    reg ball_button ;
    reg clear_button ;

	reg [2:0] ball_counter ;
	reg [1:0] strike_counter ;

    reg CLK_slow;

    slow_clock sc1(CLK, CLK_slow);

    debounce db1(CLK, BTN1, strike_button);
    debounce db2(CLK, BTN2, ball_button);
    debounce db3(CLK, BTN3, clear_button);

    reg inc_strike;
    reg inc_ball;
    reg clear_all;
    
    wire one_button_was_pressed;

    always @(posedge CLK_slow) clear_all = (strike_counter == 3) && (strike_button) || (ball_counter == 7) && (ball_button) || clear_button;
    always @(posedge CLK_slow) inc_strike = (strike_counter < 3) && strike_button;
    always @(posedge CLK_slow) inc_ball = (ball_counter < 7) && ball_button;

    assign one_button_was_pressed = clear_all || inc_strike || inc_ball;

    always @(posedge one_button_was_pressed)
    begin
        if (clear_all)
        begin
            strike_counter <= 0;
            ball_counter <= 0;
        end
        else
            if (inc_strike) 
                strike_counter <= (strike_counter << 1) + 1;
            if (inc_ball)
                ball_counter <= (ball_counter << 1) + 1;
    end

    assign {LED1, LED2, LED3} = ball_counter;
    assign {LED4, LED5} = strike_counter;

endmodule