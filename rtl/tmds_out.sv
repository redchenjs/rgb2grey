/*
 * tmds_out.sv
 *
 *  Created on: 2022-03-03 15:55
 *      Author: Jack Chen <redchenjs@live.com>
 */

module tmds_out(
    input logic clk_i,
    input logic rst_n_i,

    input logic clk_5x_i,

    input logic [2:0] tmds_d0_i,
    input logic [2:0] tmds_d1_i,
    input logic [2:0] tmds_d2_i,
    input logic [2:0] tmds_d3_i,
    input logic [2:0] tmds_d4_i,
    input logic [2:0] tmds_d5_i,
    input logic [2:0] tmds_d6_i,
    input logic [2:0] tmds_d7_i,
    input logic [2:0] tmds_d8_i,
    input logic [2:0] tmds_d9_i,

    output logic       tmds_txc_o_p,
    output logic       tmds_txc_o_n,
    output logic [2:0] tmds_txd_o_p,
    output logic [2:0] tmds_txd_o_n
);

logic [2:0] tmds_data;

OSER10 OSERDES [2:0] (
    .Q(tmds_data),
    .D0(tmds_d0_i),
    .D1(tmds_d1_i),
    .D2(tmds_d2_i),
    .D3(tmds_d3_i),
    .D4(tmds_d4_i),
    .D5(tmds_d5_i),
    .D6(tmds_d6_i),
    .D7(tmds_d7_i),
    .D8(tmds_d8_i),
    .D9(tmds_d9_i),
    .PCLK(clk_i),
    .FCLK(clk_5x_i),
    .RESET(~rst_n_i)
);

ELVDS_OBUF OBUFDS [3:0] (
    .I({clk_i, tmds_data}),
    .O({tmds_txc_o_p, tmds_txd_o_p}),
    .OB({tmds_txc_o_n, tmds_txd_o_n})
);

endmodule
