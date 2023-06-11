/*
module name: counter
description: Counts to a flexible amount. Has strobe at max and controls for wrapping, enable, and clear.
*/

module counter
#(
    parameter N = 8 // Size of counter, maximum count is 2^N
)
(
    input logic clk,            // Clock
    input logic nrst,           // Asyncronous active low reset
    input logic enable,         // Enable
    input logic clear,          // Synchronous active high clear 
    input logic wrap,           // 0: no wrap at max, 1: wrap to 0 at max
    input logic [N:0] max,      // Max number of count (inclusive)
    output logic [N:0] count,   // Current count
    output logic at_max         // 1 when counter is at max, otherwise 0
);

    // Write your code here!

endmodule
