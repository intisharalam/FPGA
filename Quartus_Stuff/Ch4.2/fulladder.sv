module fulladder (
    input logic a, b, cin,
    output logic s, cout
);

    logic p, g;
    
    // Propagate and Generate signals
    assign p = a ^ b;
    assign g = a & b;
    
    // Sum and Carry Out
    assign s = p ^ cin;
    assign cout = g | (p & cin);

endmodule
