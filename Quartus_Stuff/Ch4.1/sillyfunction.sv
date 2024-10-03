module sillyfunction(
    input logic a, b, c,
    output logic [6:0] y
);
    logic y_bit;
    
    // Calculate y as a single bit first
    assign y_bit = (~a & ~b & ~c) |
                   (a & ~b & ~c) |
                   (a & ~b & c);

    // Convert y_bit to the 7-segment display encoding
    always_comb begin
        if (y_bit)
            y = 7'b1111001; // 1 on 7-segment display
        else
            y = 7'b1000000; // 0 on 7-segment display
    end
endmodule
