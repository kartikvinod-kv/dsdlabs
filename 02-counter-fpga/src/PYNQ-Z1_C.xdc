## Buttons
# Map 'clkpulse' to Button 0 (D19)
set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS33 } [get_ports { clkpulse }];

# Map 'rst' to Button 1 (D20)
set_property -dict { PACKAGE_PIN D20   IOSTANDARD LVCMOS33 } [get_ports { rst }];

## Switches
# Map 'sw0' to Switch 0 (M20)
set_property -dict { PACKAGE_PIN M20   IOSTANDARD LVCMOS33 } [get_ports { sw0 }];

## LEDs
# Map 'led' vector to the 4 board LEDs
set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33 } [get_ports { led[0] }];
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { led[1] }];
set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { led[2] }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { led[3] }];
