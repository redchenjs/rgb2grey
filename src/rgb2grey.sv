/*
 * rgb2grey.sv
 *
 *  Created on: 2022-03-03 16:58
 *      Author: Jack Chen <redchenjs@live.com>
 */

module rgb2grey(
    input logic clk_i,
    input logic rst_n_i,

    input logic       dvp_pclk_i,
    input logic       dvp_hsync_i,
    input logic       dvp_vsync_i,
    input logic [7:0] dvp_data_i,

    inout logic dvp_scl_io,
    inout logic dvp_sda_io,

    output logic dvp_xclk_o,
    output logic dvp_af_vcc_o,
    output logic dvp_af_gnd_o,

    output logic       tmds_clk_o_p,
    output logic       tmds_clk_o_n,
    output logic [2:0] tmds_data_o_p,
    output logic [2:0] tmds_data_o_n,

    output logic led_o
);

logic sys_clk;
logic sys_rst_n;

logic aux_clk;

assign dvp_af_vcc_o = 1'b1;
assign dvp_af_gnd_o = 1'b0;

assign led_o = sys_rst_n;

sys_ctl sys_ctl(
    .clk_i(clk_i),
    .rst_n_i(rst_n_i),

    .sys_clk_o(sys_clk),
    .sys_rst_n_o(sys_rst_n),

    .aux_clk_o(aux_clk)
);

video_gen video_gen(
    .clk_i(sys_clk),
    .rst_n_i(sys_rst_n),

    .clk_5x_i(aux_clk),

    .tmds_clk_o_p(tmds_clk_o_p),
    .tmds_clk_o_n(tmds_clk_o_n),
    .tmds_data_o_p(tmds_data_o_p),
    .tmds_data_o_n(tmds_data_o_n)
);

endmodule
