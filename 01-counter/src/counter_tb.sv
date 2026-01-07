`timescale 1ns / 1ps

module counter_tb();
    // Signal Declarations
    logic clk;
    logic rst_n;
    logic load;
    logic up_down;
    logic enable;
    logic [3:0] d_in;
    logic [3:0] count;
    logic test_passed;

    // Clock Generation (100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Instantiate the Device Under Test (DUT)
    updown_counter dut(
        .clk(clk),
        .rst_n(rst_n),
        .load(load),
        .up_down(up_down),
        .enable(enable),
        .d_in(d_in),
        .count(count)
    );

    // Test Procedure
    initial begin
        // Initialize Inputs
        test_passed = 1'b1;
        rst_n = 0;
        load = 0;
        up_down = 1;
        enable = 0;
        d_in = 4'h0;
        
        // Wait 20ns and release reset
        #20;
        rst_n = 1;

        // -------------------------------------------------
        // Test Case 1: Load value (Expect 7)
        // -------------------------------------------------
        d_in = 4'h7;
        load = 1;
        #10; // Wait 1 clock cycle
        load = 0;
        if (count !== 4'h7) begin
            $display("Test 1 Failed: Load operation. Got %h", count);
            test_passed = 1'b0;
        end

        // -------------------------------------------------
        // Test Case 2: Count up (Expect B)
        // -------------------------------------------------
        enable = 1;
        up_down = 1;
        #40;  // 4 clock cycles -> 7 + 4 = 11 (B)
        if (count !== 4'hB) begin
            $display("Test 2 Failed: Count up. Expected B, got %h", count);
            test_passed = 1'b0;
        end

        // -------------------------------------------------
        // Test Case 3: Count down (Expect 8)
        // -------------------------------------------------
        up_down = 0;
        #30;  // 3 clock cycles -> 11 - 3 = 8
        if (count !== 4'h8) begin
            $display("Test 3 Failed: Count down. Expected 8, got %h", count);
            test_passed = 1'b0;
        end

        // -------------------------------------------------
        // Test Case 4: Disable counter (Expect 8)
        // -------------------------------------------------
        enable = 0;
        #20;
        if (count !== 4'h8) begin
            $display("Test 4 Failed: Counter changed while disabled");
            test_passed = 1'b0;
        end

        // -------------------------------------------------
        // Test Case 5: Reset during operation (Expect 0)
        // -------------------------------------------------
        enable = 1; 
        #20;        // Let it count randomly
        rst_n = 0;  // Hit Reset
        #10;
        if (count !== 4'h0) begin
            $display("Test 5 Failed: Reset did not clear counter");
            test_passed = 1'b0;
        end
        rst_n = 1;  // Release Reset

        // -------------------------------------------------
        // Test Case 6: Load while counting (Priority Check)
        // -------------------------------------------------
        enable = 1;
        d_in = 4'hC; // Load 12
        load = 1;
        #10;         
        load = 0;    
        if (count !== 4'hC) begin
             $display("Test 6 Failed: Load should override counting");
             test_passed = 1'b0;
        end

        // -------------------------------------------------
        // Test Case 7: Disable while counting (Hold Check)
        // -------------------------------------------------
        // Current is C (12). Let's count down one step to B (11)
        up_down = 0; 
        #10;         // Count is now B
        enable = 0;  // STOP
        #30;         // Wait
        if (count !== 4'hB) begin
             $display("Test 7 Failed: Counter did not hold value");
             test_passed = 1'b0;
        end

        // Final Report
        $display("--------------------------------");
        if (test_passed) begin
            $display("All tests passed!");
        end else begin
            $display("Some tests failed.");
        end
        $display("--------------------------------");

        $finish;
    end
endmodule
