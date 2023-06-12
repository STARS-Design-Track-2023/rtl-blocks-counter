/*
module name: counter
description: Counts to a flexible amount. Has strobe at max and controls for wrapping, enable, and clear.
*/

module counter
#(
    parameter N = 4 // Size of counter (i.e. number of bits at the output). Maximum count is 2^N - 1
)
(
    input logic clk,            // Clock
    input logic nrst,           // Asyncronous active low reset
    input logic enable,         // Enable
    input logic clear,          // Synchronous active high clear 
    input logic wrap,           // 0: no wrap at max, 1: wrap to 0 at max
    input logic [N - 1:0] max,      // Max number of count (inclusive)
    output logic [N - 1:0] count,   // Current count
    output logic at_max         // 1 when counter is at max, otherwise 0
);

    // Write your code here!

    // EXAMPLE CODE, TODO: REMOVE BEFORE COMITTING

    logic [N - 1:0] next_count;

    always_ff @( posedge clk, negedge nrst ) begin : COUNTER_REGISTER_LOGIC
        if (~nrst) begin
            count <= 0; 
        end
        else begin
            count <= next_count;
        end
    end

    always_comb begin : NEXT_COUNT_LOGIC
        if (~clear) begin
            if (enable) begin
                if (count < max) begin 
                    next_count = count + 1;
                end
                else begin
                    if(~wrap)
                        next_count = count;
                    else 
                        next_count = 0;
                end
            end
            else begin // Unenabled logic
                next_count = count;
            end
        end
        else begin // Clear logic
            next_count = 0;
        end
    end

    // Strobe at max logic
    assign at_max = (count == max) ? 1'b1 : 1'b0;

endmodule
