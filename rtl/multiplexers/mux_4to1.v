// 4-to-1 multiplexer constructed from three shared 2:1 MUX stages.
// Source adapted from SYSC 2310 Lab 5, Experiment 2.
module mux_4to1 (
    input  wire d0,
    input  wire d1,
    input  wire d2,
    input  wire d3,
    input  wire [1:0] sel,
    output wire y
);
    wire s0, s1;

    mux_2to1 mux1 (.I0(d0), .I1(d1), .sel(sel[0]), .y(s0));
    mux_2to1 mux2 (.I0(d2), .I1(d3), .sel(sel[0]), .y(s1));
    mux_2to1 mux3 (.I0(s0), .I1(s1), .sel(sel[1]), .y(y));
endmodule
