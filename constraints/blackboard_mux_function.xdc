# Blackboard Rev B FPGA — three-variable MUX function.
# Intended top module: func.
# unrelated clock/unused ports removed.

set_property -dict { PACKAGE_PIN R16 IOSTANDARD LVCMOS33 } [get_ports {x}]
set_property -dict { PACKAGE_PIN U20 IOSTANDARD LVCMOS33 } [get_ports {y}]
set_property -dict { PACKAGE_PIN R17 IOSTANDARD LVCMOS33 } [get_ports {z}]
set_property -dict { PACKAGE_PIN N20 IOSTANDARD LVCMOS33 } [get_ports {f}]
