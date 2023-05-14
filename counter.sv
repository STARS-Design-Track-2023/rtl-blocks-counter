module counter(
    input clk,
    input nrst,
    input enable_i,
    input wrap_i,
    input [7:0] max_i,
    output reg [7:0] count_o,
    output reg atmax_o
);

    timeunit 1ns;
    timeprecision 1ns;

    // Write your code here!

endmodule
