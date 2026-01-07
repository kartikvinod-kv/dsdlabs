// Code your design here
/**
* updown_counter:
* A simple up/down counter with load functionality.
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
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Asynchronous Reset: Set count to 0 immediately
            count <= 4'b0000;
        end 
        else if (load) begin
            // Load: Overwrite count with input data
            count <= d_in;
        end 
        else if (enable) begin
            // Enable is high, so we count
            if (up_down) 
                count <= count + 1; // Count Up
            else 
                count <= count - 1; // Count Down
        end
        // If enable is 0, implicit "else" keeps the value of count stable
    end

endmodule
