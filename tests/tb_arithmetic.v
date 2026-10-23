\`timescale 1ns/1ps
// Exhaustive, self-checking arithmetic tests: 16 * 16 operand pairs per DUT.
module tb_arithmetic;
    reg  [3:0] A, B;
    wire [3:0] add_sum, sub_sum;
    wire       add_cout, sub_cout;
    reg  [4:0] expected_add, expected_sub;
    integer a_idx, b_idx;
    integer checks;

    four_bit_adder dut_adder (
        .A(A), .B(B), .Sum(add_sum), .Cout(add_cout)
    );
    four_bit_subtractor dut_subtractor (
        .A(A), .B(B), .Sum(sub_sum), .Cout(sub_cout)
    );

    initial begin
        checks = 0;
        for (a_idx = 0; a_idx < 16; a_idx = a_idx + 1) begin
            for (b_idx = 0; b_idx < 16; b_idx = b_idx + 1) begin
                A = a_idx;
                B = b_idx;
                #1;

                expected_add = {1'b0, A} + {1'b0, B};
                // Five bits retain the carry-out of A + (~B & 4'hF) + 1.
                expected_sub = {1'b0, A} + {1'b0, ~B} + 5'd1;

                if ({add_cout, add_sum} !== expected_add)
                    $fatal(1, "ADD A=%0d B=%0d got %b_%b expected %b",
                        A, B, add_cout, add_sum, expected_add);
                if ({sub_cout, sub_sum} !== expected_sub)
                    $fatal(1, "SUB A=%0d B=%0d got %b_%b expected %b",
                        A, B, sub_cout, sub_sum, expected_sub);

                checks = checks + 2;
            end
        end
        $display("PASS arithmetic: %0d checks across 256 operand pairs.", checks);
        $finish;
    end
endmodule
