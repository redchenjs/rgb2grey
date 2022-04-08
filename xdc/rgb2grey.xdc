set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS33} [get_ports {BTN[1]}]
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS33} [get_ports {BTN[0]}]

set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports {LED[3]}]
set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports {LED[2]}]
set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports {LED[1]}]
set_property -dict {PACKAGE_PIN T12 IOSTANDARD LVCMOS33} [get_ports {LED[0]}]

set_property -dict {PACKAGE_PIN H16 IOSTANDARD TMDS_33} [get_ports TMDS_clk_p]
set_property -dict {PACKAGE_PIN B19 IOSTANDARD TMDS_33} [get_ports {TMDS_data_p[2]}]
set_property -dict {PACKAGE_PIN C20 IOSTANDARD TMDS_33} [get_ports {TMDS_data_p[1]}]
set_property -dict {PACKAGE_PIN D19 IOSTANDARD TMDS_33} [get_ports {TMDS_data_p[0]}]

set_property -dict {PACKAGE_PIN T20 IOSTANDARD LVCMOS33} [get_ports SDIO_cmd]
set_property -dict {PACKAGE_PIN U20 IOSTANDARD LVCMOS33} [get_ports SDIO_clk]
set_property -dict {PACKAGE_PIN V20 IOSTANDARD LVCMOS33} [get_ports {SDIO_data[3]}]
set_property -dict {PACKAGE_PIN W20 IOSTANDARD LVCMOS33} [get_ports {SDIO_data[2]}]
set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports {SDIO_data[1]}]
set_property -dict {PACKAGE_PIN P20 IOSTANDARD LVCMOS33} [get_ports {SDIO_data[0]}]
