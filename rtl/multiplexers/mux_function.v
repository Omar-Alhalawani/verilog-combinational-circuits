// Three-input Boolean function implemented using a hierarchical 4:1 MUX.
// For select {y,z}: 00 -> 0, 01 -> ~x, 10 -> x, 11 -> 1.
module func (
    input  wire x,
    input  wire y,
    input  wire z,
    output wire f
);
    mux_4to1 ins1 (
        .d0(1'b0),
        .d1(~x),
        .d2(x),
        .d3(1'b1),
        .sel({y, z}),
        .y(f)
    );
endmodule
