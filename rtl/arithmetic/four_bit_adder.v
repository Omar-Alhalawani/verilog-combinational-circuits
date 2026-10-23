// Shared full_adder module is defined in full_adder.v.
module four_bit_adder (
    input  wire [3:0] A,
    input  wire [3:0] B,
    output wire [3:0] Sum,
    output wire       Cout
);
    wire c1, c2, c3;

    full_adder fa0 (.x(A[0]), .y(B[0]), .Cin(1'b0), .Sum(Sum[0]), .Cout(c1));
    full_adder fa1 (.x(A[1]), .y(B[1]), .Cin(c1),   .Sum(Sum[1]), .Cout(c2));
    full_adder fa2 (.x(A[2]), .y(B[2]), .Cin(c2),   .Sum(Sum[2]), .Cout(c3));
    full_adder fa3 (.x(A[3]), .y(B[3]), .Cin(c3),   .Sum(Sum[3]), .Cout(Cout));
endmodule
