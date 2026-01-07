module counter (
    input logic clkpulse,       // Clock input
    input logic rst,         // Active low reset
    input  logic       sw0,       // NEW: Mapped to Slide Switch 0
    output logic [3:0] led // 4-bit counter output
);

    always_ff @(posedge clkpulse or posedge rst) begin
        if (rst) begin
            led <= 4'b0000; // Reset counter to 0
        end else begin
            if (sw0) begin
                led <= led - 1; // Decreament counter
            end else begin
                led <= led + 1; // Increment counter
            end
        end
    end

endmodule
