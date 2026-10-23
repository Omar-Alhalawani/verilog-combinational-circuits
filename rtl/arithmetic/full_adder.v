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
