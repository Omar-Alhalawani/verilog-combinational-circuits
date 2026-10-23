// Implemented using explicit Boolean expressions.
module mux_2to1 (
    input  wire I0,
    input  wire I1,
    input  wire sel,
    output wire y
);
    wire sel_not, and_I0, and_I1;

    assign sel_not = ~sel;
    assign and_I0  = sel_not & I0;
    assign and_I1  = sel & I1;
    assign y       = and_I0 | and_I1;
endmodule
