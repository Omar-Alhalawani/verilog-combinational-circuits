// 1-bit full adder — adapted from the SYSC 2310 Lab 4 RTL.
module full_adder (
    input  wire x,
    input  wire y,
    input  wire Cin,
    output wire Sum,
    output wire Cout
);
    assign Sum  = x ^ y ^ Cin;
    assign Cout = (x & y) | (y & Cin) | (x & Cin);
endmodule
