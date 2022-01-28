set_property -dict { PACKAGE_PIN R4    IOSTANDARD LVCMOS33 } [get_ports { clk }];
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS25 } [get_ports { led[0] }];
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS25 } [get_ports { led[1] }];
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS25 } [get_ports { led[2] }];
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS25 } [get_ports { led[3] }];
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS25 } [get_ports { led[4] }];
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS25 } [get_ports { led[5] }];
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS25 } [get_ports { led[6] }];
set_property -dict { PACKAGE_PIN Y13   IOSTANDARD LVCMOS25 } [get_ports { led[7] }];
set_property -dict { PACKAGE_PIN B22 IOSTANDARD LVCMOS12 } [get_ports { reset }];
set_property -dict { PACKAGE_PIN D22 IOSTANDARD LVCMOS12 } [get_ports { buttons[0] }];
set_property -dict { PACKAGE_PIN C22 IOSTANDARD LVCMOS12 } [get_ports { buttons[3] }];
set_property -dict { PACKAGE_PIN D14 IOSTANDARD LVCMOS12 } [get_ports { buttons[1] }];
set_property -dict { PACKAGE_PIN F15 IOSTANDARD LVCMOS12 } [get_ports { buttons[2] }];
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]