module alu(
    input  logic [31:0] a,             // First operand
    input  logic [31:0] b,             // Second operand
    input  logic [2:0]  alucontrol,    // ALU control signals
    output logic [31:0] result,        // ALU result
    output logic [3:0]  flags          // Status flags: [3] Overflow, [2] Carry out, [1] Negative, [0] Zero
);

    // Internal signals
    logic [31:0] condinvb, sum;        // Intermediate values
    logic        v, c, n, z;           // Flag signals: overflow, carry out, negative, zero
    logic        cout;                 // Carry out of adder
    logic        isAddSub;             // True if operation is addition or subtraction

    // Determine if the operation is addition or subtraction
    assign isAddSub = (alucontrol[1] == 1'b0);

    // Compute the result of addition or subtraction
    assign condinvb = alucontrol[0] ? ~b : b; 
    assign {cout, sum} = a + condinvb + alucontrol[0]; 

    // Compute the result based on the ALU control signals
    always_comb 
    case (alucontrol)
        3'b000: result = sum;                  // add
        3'b001: result = sum;                  // subtract
        3'b010: result = a & b;                // and
        3'b011: result = a | b;                // or
        3'b101: result = (a < b) ? 32'b1 : 32'b0; // slt
        default: result = 32'bx;               // undefined
    endcase 

    // Compute the flags
    assign z = (result == 32'b0);          // Zero flag
    assign n = result[31];                 // Negative flag
    assign c = (alucontrol[0] ? ~cout : cout); // Carry out flag
    assign v = (a[31] == b[31]) && (sum[31] != a[31]); // Overflow flag

    // Assign flags to the output
    assign flags = {v, c, n, z}; 

endmodule

