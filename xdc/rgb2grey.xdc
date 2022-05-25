set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports {BTN[1]}]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {BTN[0]}]

set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {LED[3]}]
set_property -dict {PACKAGE_PIN H20 IOSTANDARD LVCMOS33} [get_ports {LED[2]}]
set_property -dict {PACKAGE_PIN L19 IOSTANDARD LVCMOS33} [get_ports {LED[1]}]
set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVCMOS33} [get_ports {LED[0]}]

set_property -dict {PACKAGE_PIN B19 IOSTANDARD TMDS_33} [get_ports TMDS_clk_p]
set_property -dict {PACKAGE_PIN D19 IOSTANDARD TMDS_33} [get_ports {TMDS_data_p[2]}]
set_property -dict {PACKAGE_PIN C20 IOSTANDARD TMDS_33} [get_ports {TMDS_data_p[1]}]
set_property -dict {PACKAGE_PIN E17 IOSTANDARD TMDS_33} [get_ports {TMDS_data_p[0]}]

set_property -dict {PACKAGE_PIN F19 IOSTANDARD LVCMOS33} [get_ports SDIO_clk]
set_property -dict {PACKAGE_PIN G19 IOSTANDARD LVCMOS33} [get_ports SDIO_cmd]
set_property -dict {PACKAGE_PIN G20 IOSTANDARD LVCMOS33} [get_ports {SDIO_data[3]}]
set_property -dict {PACKAGE_PIN G18 IOSTANDARD LVCMOS33} [get_ports {SDIO_data[2]}]
set_property -dict {PACKAGE_PIN J20 IOSTANDARD LVCMOS33} [get_ports {SDIO_data[1]}]
set_property -dict {PACKAGE_PIN L20 IOSTANDARD LVCMOS33} [get_ports {SDIO_data[0]}]
