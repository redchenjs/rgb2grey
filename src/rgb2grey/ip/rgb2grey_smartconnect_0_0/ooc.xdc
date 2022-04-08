# aclk {FREQ_HZ 80000000 CLK_DOMAIN rgb2grey_processing_system7_0_0_FCLK_CLK1 PHASE 0.0} aclk1 {FREQ_HZ 125000000 CLK_DOMAIN rgb2grey_processing_system7_0_0_FCLK_CLK0 PHASE 0.0}
# Clock Domain: rgb2grey_processing_system7_0_0_FCLK_CLK1
create_clock -name aclk -period 12.500 [get_ports aclk]
# Clock Domain: rgb2grey_processing_system7_0_0_FCLK_CLK0
create_clock -name aclk1 -period 8.000 [get_ports aclk1]
# Generated clocks
