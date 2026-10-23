// 4-bit ripple-carry subtractor — adapted from SYSC 2310 Lab 4.
// A - B = A + ~B + 1, using the shared full_adder module.
// Cout = 1 when no unsigned borrow occurs; 0 when A < B.
module four_bit_subtractor (
    input  wire [3:0] A,
    input  wire [3:0] B,
    output wire [3:0] Sum,
    output wire       Cout
);
    wire [3:0] B_complement;
    wire c1, c2, c3;

    assign B_complement = ~B;

    full_adder fa0 (.x(A[0]), .y(B_complement[0]), .Cin(1'b1), .Sum(Sum[0]), .Cout(c1));
    full_adder fa1 (.x(A[1]), .y(B_complement[1]), .Cin(c1),   .Sum(Sum[1]), .Cout(c2));
    full_adder fa2 (.x(A[2]), .y(B_complement[2]), .Cin(c2),   .Sum(Sum[2]), .Cout(c3));
    full_adder fa3 (.x(A[3]), .y(B_complement[3]), .Cin(c3),   .Sum(Sum[3]), .Cout(Cout));
endmodule
