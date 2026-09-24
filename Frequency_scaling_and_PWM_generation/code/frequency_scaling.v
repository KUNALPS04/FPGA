/******************************************************************************
 * Module Name  : frequency_scaling
 * File Name    : frequency_scaling.v
 *
 * By       : Kunal Patil
 * Date Created : 24-Sep-2026
 *
 * Description  :
 * This module performs clock frequency scaling by dividing the FPGA board's
 * 50 MHz system clock down to a 5 MHz clock using a counter-based clock
 * divider. The generated 5 MHz clock is used as the input clock for the
 * PWM generation module.
 *
 * Inputs:
 *   clk_50MHz  - 50 MHz system clock
 *   reset_n    - Active-low reset
 *
 * Outputs:
 *   clk_5MHz   - Scaled 5 MHz clock
 *
 * Functionality:
 *   - Divides the incoming 50 MHz clock by 10.
 *   - Generates a stable 5 MHz clock for downstream modules.
 *   - Supports asynchronous active-low reset.
 *
 * Target Tool  : Quartus Prime Lite 20.1
 * Language     : Verilog HDL
 ******************************************************************************/

module frequency_scaling (
    input clk_50MHz,
    input reset_n,
    output reg clk_5MHz
);

reg [2:0] count;

always @(posedge clk_50MHz or negedge reset_n) begin
    if (!reset_n) begin
        count    <= 3'd0;
        clk_5MHz <= 1'b0;
    end
    else begin
        if (count == 3'd4) begin
            count <= 3'd0;
        end
        else begin
            count <= count + 3'd1;
        end

        if (count == 3'd0)
            clk_5MHz <= ~clk_5MHz;
    end
end


endmodule

