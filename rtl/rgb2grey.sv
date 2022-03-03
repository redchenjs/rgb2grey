/*
 * rgb2grey.sv
 *
 *  Created on: 2022-03-03 16:58
 *      Author: Jack Chen <redchenjs@live.com>
 */

module rgb2grey(
    input logic clk_i,
    input logic rst_n_i,

    output logic       tmds_txc_o_p,
    output logic       tmds_txc_o_n,
    output logic [2:0] tmds_txd_o_p,
    output logic [2:0] tmds_txd_o_n,

    output logic [5:0] led_n_o
);

logic sys_clk;
logic sys_rst_n;

logic aux_clk;

sys_ctl sys_ctl(
    .clk_i(clk_i),
    .rst_n_i(rst_n_i),

    .sys_clk_o(sys_clk),
    .sys_rst_n_o(sys_rst_n),

    .aux_clk_o(aux_clk)
);

hdmi_gen hdmi_gen(
    .clk_i(sys_clk),
    .rst_n_i(sys_rst_n),

    .clk_5x_i(aux_clk),

    .tmds_txc_o_p(tmds_txc_o_p),
    .tmds_txc_o_n(tmds_txc_o_n),
    .tmds_txd_o_p(tmds_txd_o_p),
    .tmds_txd_o_n(tmds_txd_o_n),

    .auto_btn_o(led_n_o)
);

endmodule
