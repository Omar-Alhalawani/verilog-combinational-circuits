\`timescale 1ns/1ps
// Exhaustive 2:1, 4:1, and MUX-based function checks.
module tb_multiplexers;
    reg  I0, I1, select2;
    wire y2;
    reg  [3:0] data4;
    reg  [1:0] select4;
    wire y4;
    reg  x, y, z;
    wire f;
    reg  expected;
    integer i, j, checks;

    mux_2to1 dut_mux2 (.I0(I0), .I1(I1), .sel(select2), .y(y2));
    mux_4to1 dut_mux4 (
        .d0(data4[0]), .d1(data4[1]),
        .d2(data4[2]), .d3(data4[3]),
        .sel(select4), .y(y4)
    );
    func dut_function (.x(x), .y(y), .z(z), .f(f));

    initial begin
        checks = 0;

        // 2^3 = 8 input combinations for the 2:1 MUX.
        for (i = 0; i < 8; i = i + 1) begin
            {select2, I1, I0} = i;
            #1;
            expected = select2 ? I1 : I0;
            if (y2 !== expected)
                $fatal(1, "2:1 MUX sel=%b I1=%b I0=%b got=%b expected=%b",
                    select2, I1, I0, y2, expected);
            checks = checks + 1;
        end

        // All 16 data patterns and 4 select settings for the 4:1 MUX.
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                data4   = i;
                select4 = j;
                #1;
                expected = data4[select4];
                if (y4 !== expected)
                    $fatal(1, "4:1 MUX d=%b sel=%b got=%b expected=%b",
                        data4, select4, y4, expected);
                checks = checks + 1;
            end
        end

        // Independent sum-of-products expression for the three-input
        // function: f = y(x+z) + (~x)z.
        for (i = 0; i < 8; i = i + 1) begin
            {x, y, z} = i;
            #1;
            expected = (y & (x | z)) | ((~x) & z);
            if (f !== expected)
                $fatal(1, "MUX function x=%b y=%b z=%b got=%b expected=%b",
                    x, y, z, f, expected);
            checks = checks + 1;
        end

        $display("PASS multiplexers: %0d exhaustive checks.", checks);
        $finish;
    end
endmodule
