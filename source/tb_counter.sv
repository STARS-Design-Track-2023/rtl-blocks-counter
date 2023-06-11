/*
    Module name: tb_counter
    Description: A testbench for the counter task
*/

// 
// Feel free to mess around with the testbench!
//

`timescale 1ms/100us

module tb_counter ();

    /////////////////////
    // Testbench Setup //
    /////////////////////

    localparam time CLOCK_PERIOD = 10;
    localparam RESET_ACTIVE = 0;
    localparam RESET_INACTIVE = 1;

    // Testbench Parameters
    integer tb_test_number = 0;
    string tb_test_name = "PLACEHOLDER"; 

    // Signals for 3 DUTs of size 2, 4 and 8
    logic tb_clk, tb_nrst, tb_enable, tb_clear, tb_wrap, 
    tb_at_max_2, tb_at_max_4, tb_at_max_8;

    logic [2:0] tb_max_2, tb_count_2;
    logic [4:0] tb_max_4, tb_count_4;
    logic [8:0] tb_max_8, tb_count_8;

    // iverilog waveform generation
    initial begin
        $dumpfile ("dump.vcd");
        $dumpvars;
    end

    ////////////////////////
    // Testbenching tasks //
    ////////////////////////

    // reset_dut: Does a quick reset
    task reset_dut;
        begin
            tb_nrst = RESET_ACTIVE;

            @(posedge tb_clk);
            @(negedge tb_clk);

            tb_nrst = RESET_INACTIVE;
        end
    endtask

    // set_inputs_low, sets all DUT inputs low
    task set_inputs_low;
        begin
            @(negedge tb_clk);
            
            tb_enable = 0;
            tb_clear = 0;
            tb_wrap = 0;
            tb_max_2 = 0;
            tb_max_4 = 0;
            tb_max_8 = 0;
        end
    endtask

    // clock, waits N clock cycles
    task clock(
        input integer N
    );
        begin
            for (integer i = 0; i < N; i = i + 1) begin
                @(posedge tb_clk);
            end
        end
    endtask

    // check_2, checks the size 2 DUT's outputs
    

    //////////
    // DUTs //
    //////////

    counter #(.N(2)) DUT_2 
    (
        .clk(tb_clk),
        .nrst(tb_nrst),
        .enable(tb_enable),
        .clear(tb_clear),
        .wrap(tb_wrap),
        .max(tb_max_2),

        .count(tb_count_2),
        .at_max(tb_at_max_2)
    );

    counter #(.N(4)) DUT_4 
    (
        .clk(tb_clk),
        .nrst(tb_nrst),
        .enable(tb_enable),
        .clear(tb_clear),
        .wrap(tb_wrap),
        .max(tb_max_4),

        .count(tb_count_4),
        .at_max(tb_at_max_4)
    );

    counter #(.N(8)) DUT_8 
    (
        .clk(tb_clk),
        .nrst(tb_nrst),
        .enable(tb_enable),
        .clear(tb_clear),
        .wrap(tb_wrap),
        .max(tb_max_8),

        .count(tb_count_8),
        .at_max(tb_at_max_8)
    );

    // Clocking
    always begin
        tb_clk = 1;
        #(CLOCK_PERIOD / 2);
        tb_clk = 0;
        #(CLOCK_PERIOD / 2);
    end

    initial begin

        ////////////////////////////
        // Test 1: Power on reset //
        ////////////////////////////

        tb_test_number = tb_test_number + 1;
        tb_test_name = "Power on Reset";

        #(0.1);
        tb_nrst = RESET_ACTIVE;
        @(negedge tb_clk);
        tb_nrst = RESET_INACTIVE;

        $finish;
    end


endmodule
