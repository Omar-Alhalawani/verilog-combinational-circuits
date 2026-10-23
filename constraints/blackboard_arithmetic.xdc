# Blackboard Rev B FPGA — shared 4-bit adder / subtractor mapping.
# Valid for top modules four_bit_adder and four_bit_subtractor,
# both exposing A[3:0], B[3:0], Sum[3:0], Cout.
# Adapted from the original SYSC 2310 Lab 4 Vivado constraints.
# Confirm pinout and FPGA revision before use.

# Switches SW0–SW3 -> A; SW4–SW7 -> B
set_property -dict { PACKAGE_PIN R17 IOSTANDARD LVCMOS33 } [get_ports {A[0]}]
set_property -dict { PACKAGE_PIN U20 IOSTANDARD LVCMOS33 } [get_ports {A[1]}]
set_property -dict { PACKAGE_PIN R16 IOSTANDARD LVCMOS33 } [get_ports {A[2]}]
set_property -dict { PACKAGE_PIN N16 IOSTANDARD LVCMOS33 } [get_ports {A[3]}]
set_property -dict { PACKAGE_PIN R14 IOSTANDARD LVCMOS33 } [get_ports {B[0]}]
set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports {B[1]}]
set_property -dict { PACKAGE_PIN L15 IOSTANDARD LVCMOS33 } [get_ports {B[2]}]
set_property -dict { PACKAGE_PIN M15 IOSTANDARD LVCMOS33 } [get_ports {B[3]}]

# LD0–LD3 -> Sum; T19 -> Cout (RGB LD4 green channel per board master)
set_property -dict { PACKAGE_PIN N20 IOSTANDARD LVCMOS33 } [get_ports {Sum[0]}]
set_property -dict { PACKAGE_PIN P20 IOSTANDARD LVCMOS33 } [get_ports {Sum[1]}]
set_property -dict { PACKAGE_PIN R19 IOSTANDARD LVCMOS33 } [get_ports {Sum[2]}]
set_property -dict { PACKAGE_PIN T20 IOSTANDARD LVCMOS33 } [get_ports {Sum[3]}]
set_property -dict { PACKAGE_PIN T19 IOSTANDARD LVCMOS33 } [get_ports {Cout}]
