/******************************************************************************
 * Module Name  : pwm_generator
 * Author       : Kunal Patil
 * Date Created : 24-Sep-2026
 *
 * Description  :
 * This module generates a 500 Hz clock and a Pulse Width Modulation (PWM)
 * signal using the scaled 5 MHz clock as its input. The PWM duty cycle is
 * controlled by the pulse_width input using a counter-and-compare method.
 *
 * Inputs:
 *   clk_5MHz     - Scaled 5 MHz clock
 *   reset_n      - Active-low reset
 *   pulse_width  - 5-bit duty cycle control input
 *
 * Outputs:
 *   clk_500Hz    - Generated 500 Hz clock
 *   pwm_signal   - PWM output signal
 *
 * Functionality:
 *   - Divides the 5 MHz clock to generate a 500 Hz timing reference.
 *   - Generates a PWM waveform with configurable duty cycle.
 *   - Uses counter-based PWM generation.
 *   - Supports asynchronous active-low reset.
 *
 * Target Tool  : Quartus Prime Lite 20.1
 * Language     : Verilog HDL
 ******************************************************************************/

module pwm_generator(
    input clk_5MHz,
    input reset_n,
    input [4:0] pulse_width,
    output reg clk_500Hz, pwm_signal
);

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE //////////////////
reg [13:0] period_cnt;   // 0 to 9999

always @(posedge clk_5MHz or negedge reset_n) begin
    if (!reset_n) begin
        period_cnt <= 14'd0;
        clk_500Hz  <= 1'b0;
        pwm_signal <= 1'b0;
    end
    else begin

        // 500 Hz period counter
        if (period_cnt == 14'd9999)
            period_cnt <= 14'd0;
        else
            period_cnt <= period_cnt + 14'd1;

        // 500 Hz clock (50% duty cycle)
        if (period_cnt < 14'd5000)
            clk_500Hz <= 1'b1;
        else
            clk_500Hz <= 1'b0;

        // PWM generation
        if (period_cnt < (pulse_width * 10'd500))
            pwm_signal <= 1'b1;
        else
            pwm_signal <= 1'b0;

    end
end
//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule

