create_clock -name clk_osc -period 37.037 -waveform {0 18.518} [get_ports {clk_i}]

set_false_path -from [get_ports {rst_n_i}]
set_false_path -to [get_ports {tmds_clk_o_p}]
set_false_path -to [get_ports {tmds_clk_o_n}]
set_false_path -to [get_ports {tmds_data_o_p[*]}]
set_false_path -to [get_ports {tmds_data_o_n[*]}]
