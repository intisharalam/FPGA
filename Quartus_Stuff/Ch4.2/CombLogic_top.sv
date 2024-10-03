module CombLogic_top (
    input logic [9:0] SW,
    output logic [6:0] HEX0,
	 output logic [6:0] HEX1,
	 output logic [6:0] HEX2,
	 output logic [6:0] HEX3,
	 output logic [6:0] HEX4
);

    // Split SW into 4-bit A and B
    logic [3:0] A, B;
    logic Cin;
    logic [3:0] S;
    logic Cout;

    assign A = SW[3:0];
    assign B = SW[7:4];
    assign Cin = SW[9:8]; // Set Cin to 0 for this example, or you can use a switch to set it dynamically

    // Full Adder Instances for each bit
    logic [3:0] carry;
    genvar i;

    generate
        for (i = 0; i < 4; i++) begin : full_adder_block
            if (i == 0) begin
                fulladder fa (
                    .a(A[i]),
                    .b(B[i]),
                    .cin(Cin),
                    .s(S[i]),
                    .cout(carry[i])
                );
            end else begin
                fulladder fa (
                    .a(A[i]),
                    .b(B[i]),
                    .cin(carry[i-1]),
                    .s(S[i]),
                    .cout(carry[i])
                );
            end
        end
    endgenerate

    assign Cout = carry[3];

    // Instantiate seven-segment display modules for A, B, Cin, Sum, and Cout
    hexto7segment HEX_A (
        .binary_in(A),
        .seg(HEX0)
    );

    hexto7segment HEX_B (
        .binary_in(B),
        .seg(HEX1)
    );

    hexto7segment HEX_Cin (
        .binary_in({3'b000, Cin}),  // Display Cin (single bit)
        .seg(HEX2)
    );

    hexto7segment HEX_S (
        .binary_in(S),
        .seg(HEX3)
    );

    hexto7segment HEX_Cout (
        .binary_in({3'b000, Cout}),  // Display Cout (single bit)
        .seg(HEX4)
    );

/*
	// Inverter with display
	logic tmp;
	inv I0 (
	.y(tmp),
	.a(SW[0])
	);
	
	hexto7segment SEX0(
	.binary_in(tmp),
	.seg(HEX0)
	);
*/




endmodule
