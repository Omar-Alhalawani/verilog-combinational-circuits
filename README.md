# Verilog Combinational Circuits

**FPGA & Digital Logic | Verilog HDL | Hierarchical RTL | Ripple-Carry Arithmetic | Multiplexers**

A collection of combinational digital-circuit implementations developed from my **SYSC 2310 — Introduction to Digital Systems** lab work at Carleton University. The original Vivado exercises have been organized into reusable Verilog modules, with shared submodules, FPGA constraints for the **Blackboard Rev B** development board, and added self-checking simulation testbenches.

The emphasis is on understanding how larger digital systems are built from **small, composable hardware blocks**, rather than relying only on the Verilog arithmetic or conditional operators.

## Circuit overview

| Circuit | Design | Key concept |
| --- | --- | --- |
| **1-bit full adder** | Gate-level Boolean equations for sum and carry | Combinational logic and carry generation |
| **4-bit ripple-carry adder** | Four cascaded full adders | Hierarchical design and carry propagation |
| **4-bit subtractor** | Four cascaded full adders, complemented B, initial carry-in of 1 | Two's-complement arithmetic and borrow handling |
| **2:1 multiplexer** | NOT, AND, and OR Boolean equations | Data selection |
| **4:1 multiplexer** | Three interconnected 2:1 multiplexers | Hierarchical selection networks |
| **MUX-based Boolean function** | A 4:1 MUX implements a three-variable truth table | Logic synthesis using data inputs and selection lines |

## Architecture

### Ripple-carry arithmetic

~~~text
          A[3:0]                          B[3:0]
              \                             /
               \    ADD: B   SUB: invert B /
                \             |           /
                 v            v          v
              +------+  +------+  +------+  +------+
Cin = 0 / 1 ->| FA0  |->| FA1  |->| FA2  |->| FA3  |-> Cout
              +------+  +------+  +------+  +------+
                 |         |         |         |
              Sum[0]    Sum[1]    Sum[2]    Sum[3]
~~~

The full adder implements:

\`Sum = x ^ y ^ Cin\`  
\`Cout = (x & y) | (y & Cin) | (x & Cin)\`

- **Addition** uses \`Cin = 0\` in the least significant stage, producing a 4-bit result and carry-out.
- **Subtraction** computes \`A + (~B) + 1\`. The four result bits represent \`A - B\` **modulo 16**.
- For subtraction, \`Cout = 1\` indicates **no unsigned borrow**; \`Cout = 0\` indicates a borrow occurred. This is not a signed-overflow flag.

### Multiplexer hierarchy

~~~text
I0 --+                 d0 --+             +------+
     +-- 2:1 MUX -- y      +-- 2:1 MUX --+      |
I1 --+                     d1 --+          |      |
       sel                                  + 2:1 +-- y
                           d2 --+          | MUX  |
                                +-- 2:1 MUX +      |
                           d3 --+             +------+
                               sel[0]          sel[1]
~~~

The \`func\` module uses a 4:1 multiplexer, selected by \`{y,z}\`, with data inputs \`0\`, \`~x\`, \`x\`, and \`1\`. Its truth table is therefore:

| \`y z\` | \`f\` |
| --- | --- |
| \`00\` | \`0\` |
| \`01\` | \`~x\` |
| \`10\` | \`x\` |
| \`11\` | \`1\` |

## Repository structure

~~~text
rtl/
  arithmetic/
    full_adder.v
    four_bit_adder.v
    four_bit_subtractor.v
  multiplexers/
    mux_2to1.v
    mux_4to1.v
    mux_function.v
constraints/
  blackboard_arithmetic.xdc
  blackboard_mux_2to1.xdc
  blackboard_mux_function.xdc
tests/
  tb_arithmetic.v
  tb_multiplexers.v
scripts/
  run_tests.sh
~~~

All modules are in separate files so they can be compiled together **without duplicate module declarations**. The original lab files defined the full adder and 2:1 mux more than once; those shared blocks are now declared exactly once. The original logic has been preserved, with minor width/format cleanups.

## Simulate with Icarus Verilog

From the repository root, with **Icarus Verilog** (\`iverilog\`, \`vvp\`) installed:

~~~bash
bash scripts/run_tests.sh
~~~

Or run each group manually:

~~~bash
mkdir -p build
iverilog -g2012 -s tb_arithmetic -o build/arithmetic.vvp \
  rtl/arithmetic/*.v tests/tb_arithmetic.v
vvp build/arithmetic.vvp

iverilog -g2012 -s tb_multiplexers -o build/multiplexers.vvp \
  rtl/multiplexers/*.v tests/tb_multiplexers.v
vvp build/multiplexers.vvp
~~~

The new testbenches check **all 256 possible pairs of 4-bit operands** for both add and subtract, all combinations for the 2:1 and 4:1 multiplexers, and all eight inputs of the MUX-based Boolean function. They use \`$fatal\` to flag a mismatch rather than asking the reader to visually inspect waveforms.

**Verification scope:** testbench source is included. No simulator logs or measured FPGA timing reports are presented as verified results here; rerun the tests in your local toolchain.

## Use in Xilinx Vivado / Blackboard Rev B

1. Create a Vivado **RTL project** for the Blackboard Rev B's target device.
2. Add the source files for the circuit you want to implement.
3. Select its top-level module: \`four_bit_adder\`, \`four_bit_subtractor\`, \`mux_2to1\`, or \`func\`.
4. Add the **matching** XDC file from \`constraints/\`. Do **not** enable multiple alternative XDCs at the same time.
5. Review the FPGA part number, I/O voltage standards, pin mapping, and board revision before generating a bitstream.
6. Synthesize, implement, and program your board, then inspect switch/LED behavior.

The arithmetic XDC maps \`A\` and \`B\` to eight switches, \`Sum[3:0]\` to four LEDs, and \`Cout\` to the board's \`T19\` LED output. In subtractor mode, \`Sum\` is the difference and \`Cout\` is **no-borrow**. The mux XDCs map their specific inputs and output to switches and an LED. Constraints were trimmed from the archived lab versions to include **only ports declared in the corresponding RTL top module**.

The standalone \`mux_4to1\` is simulated as a reusable module; a separate board-specific mapping for all of its inputs is not included.

## Design considerations

- These are **combinational** blocks; there are no clocks, flip-flops, or state machines in this repository.
- Ripple-carry addition is simple and composable, but carry propagation across stages contributes to its critical-path delay.
- Four-bit arithmetic wraps around on overflow; consult the \`Cout\` bit for **unsigned** addition carry / subtraction no-borrow.
- The included RTL and tests are educational examples, not a claimed production-ready IP core.
- The board constraints target **Blackboard Rev B**, not a ZedBoard or other FPGA. Always confirm the board's actual pinout before use.

## Origin

Based on original student-created Verilog source and pin mappings from **SYSC 2310 Labs 4 and 5**. Testbenches, repository structure, and this documentation were subsequently prepared for reproducibility. Instructor-authored course lab manuals are **not distributed** here.

**Author:** Omar Alhalawani · [GitHub profile](https://github.com/Omar-Alhalawani)
