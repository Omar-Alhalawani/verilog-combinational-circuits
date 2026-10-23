# Blackboard Rev B FPGA — 2:1 multiplexer.
# Intended top module: mux_2to1.
# unrelated clock/unused ports removed.

set_property -dict { PACKAGE_PIN R17 IOSTANDARD LVCMOS33 } [get_ports {I0}]
set_property -dict { PACKAGE_PIN U20 IOSTANDARD LVCMOS33 } [get_ports {I1}]
set_property -dict { PACKAGE_PIN R16 IOSTANDARD LVCMOS33 } [get_ports {sel}]
set_property -dict { PACKAGE_PIN N20 IOSTANDARD LVCMOS33 } [get_ports {y}]
