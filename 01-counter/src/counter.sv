/**
* updown_counter:
* A simple up/down counter with load functionality.
* - Async Reset (Priority 1)
* - Synchronous Load (Priority 2)
* - Enable/Count (Priority 3)
*/
module updown_counter(
    input logic clk,       // Clock input
    input logic rst_n,     // Active-low reset
    input logic load,      // Load enable
    input logic up_down,   // Direction control (1 = up, 0 = down)
    input logic enable,    // Counter enable
    input logic [3:0] d_in,// Input data for loading
    output logic [3:0] count // Counter output
);

    // Sequential Logic
    // "posedge clk" makes it synchronous
    // "negedge rst_n" makes the reset asynchronous
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // 1. Reset Logic (Highest Priority)
            count <= 4'b0000;
        end 
        else if (load) begin
            // 2. Load Logic
            count <= d_in;
        end 
        else if (enable) begin
            // 3. Counting Logic
            if (up_down) 
                count <= count + 1; // Count Up
            else 
                count <= count - 1; // Count Down
        end
        // Implicit "else": if enable is 0, count stays the same.
    end

endmodule


