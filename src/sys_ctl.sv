/*
 * sys_ctl.sv
 *
 *  Created on: 2020-05-07 09:58
 *      Author: Jack Chen <redchenjs@live.com>
 */

module sys_ctl(
    input logic clk_i,
    input logic rst_n_i,

    output logic sys_clk_o,
    output logic sys_rst_n_o,

    output logic aux_clk_o
);

logic pll_locked;

pll pll(
    .clkin(clk_i),
    .reset(~rst_n_i),
    .clkout(aux_clk_o),
    .lock(pll_locked)
);

clkdiv clkdiv(
    .clkout(sys_clk_o),
    .hclkin(aux_clk_o),
    .resetn(rst_n_i & pll_locked)
);

assign sys_rst_n_o = rst_n_i & pll_locked;

endmodule
