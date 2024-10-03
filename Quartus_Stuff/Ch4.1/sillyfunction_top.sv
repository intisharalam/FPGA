module sillyfunction_top (
    input logic [2:0] SW,
    output logic [6:0] HEX0
);

    sillyfunction SF0 (
        .y(HEX0), 
        .a(SW[0]), 
        .b(SW[1]),
        .c(SW[2])
    );

endmodule
