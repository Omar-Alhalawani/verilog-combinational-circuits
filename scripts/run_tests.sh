#!/usr/bin/env bash
# Run the two self-checking testbenches with Icarus Verilog.
set -euo pipefail
cd "$(dirname "$0")/.."

command -v iverilog >/dev/null 2>&1 || { echo "Install Icarus Verilog (iverilog) first." >&2; exit 1; }
command -v vvp >/dev/null 2>&1 || { echo "Missing vvp runtime." >&2; exit 1; }

mkdir -p build

iverilog -g2012 -s tb_arithmetic -o build/arithmetic.vvp \
    rtl/arithmetic/*.v tests/tb_arithmetic.v
vvp build/arithmetic.vvp

iverilog -g2012 -s tb_multiplexers -o build/multiplexers.vvp \
    rtl/multiplexers/*.v tests/tb_multiplexers.v
vvp build/multiplexers.vvp

echo "All testbench groups completed."
