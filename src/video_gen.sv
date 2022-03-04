/*
 * video_gen.sv
 *
 *  Created on: 2022-03-03 16:58
 *      Author: Jack Chen <redchenjs@live.com>
 */

`include "svo/svo_defines.vh"

module video_gen(
    input logic clk_i,
    input logic rst_n_i,

    input logic clk_5x_i,

    output logic       tmds_clk_o_p,
    output logic       tmds_clk_o_n,
    output logic [2:0] tmds_data_o_p,
    output logic [2:0] tmds_data_o_n
);

localparam SVO_MODE           = "1366x768R";
localparam SVO_FRAMERATE      = 60;
localparam SVO_BITS_PER_PIXEL = 24;
localparam SVO_BITS_PER_RED   = 8;
localparam SVO_BITS_PER_GREEN = 8;
localparam SVO_BITS_PER_BLUE  = 8;
localparam SVO_BITS_PER_ALPHA = 0;

logic                          s1_axis_tvalid;
logic                          s1_axis_tready;
logic [SVO_BITS_PER_PIXEL-1:0] s1_axis_tdata;
logic                    [0:0] s1_axis_tuser;

logic                          s2_axis_tvalid;
logic                          s2_axis_tready;
logic [SVO_BITS_PER_PIXEL-1:0] s2_axis_tdata;
logic                    [0:0] s2_axis_tuser;

logic                          video_enc_tvalid;
logic                          video_enc_tready;
logic [SVO_BITS_PER_PIXEL-1:0] video_enc_tdata;
logic                    [3:0] video_enc_tuser;

logic [3:0] auto_btn;

logic [2:0] tmds_d0, tmds_d1, tmds_d2, tmds_d3, tmds_d4;
logic [2:0] tmds_d5, tmds_d6, tmds_d7, tmds_d8, tmds_d9;

assign video_enc_tready = 1'b1;

svo_tcard #(`SVO_PASS_PARAMS) svo_tcard(
    .clk(clk_i),
    .resetn(rst_n_i),

    .out_axis_tvalid(s1_axis_tvalid),
    .out_axis_tready(s1_axis_tready),
    .out_axis_tdata(s1_axis_tdata),
    .out_axis_tuser(s1_axis_tuser)
);

svo_pong #(`SVO_PASS_PARAMS) svo_pong(
    .clk(clk_i),
    .resetn(rst_n_i),
    .resetn_game(1'b1),
    .enable(1'b1),

    .btn(auto_btn),
    .auto_btn(auto_btn),

    .in_axis_tvalid(s1_axis_tvalid),
    .in_axis_tready(s1_axis_tready),
    .in_axis_tdata(s1_axis_tdata),
    .in_axis_tuser(s1_axis_tuser),

    .out_axis_tvalid(s2_axis_tvalid),
    .out_axis_tready(s2_axis_tready),
    .out_axis_tdata(s2_axis_tdata),
    .out_axis_tuser(s2_axis_tuser)
);

svo_enc #(`SVO_PASS_PARAMS) svo_enc(
    .clk(clk_i),
    .resetn(rst_n_i),

    .in_axis_tvalid(s2_axis_tvalid),
    .in_axis_tready(s2_axis_tready),
    .in_axis_tdata(s2_axis_tdata),
    .in_axis_tuser(s2_axis_tuser),

    .out_axis_tvalid(video_enc_tvalid),
    .out_axis_tready(video_enc_tready),
    .out_axis_tdata(video_enc_tdata),
    .out_axis_tuser(video_enc_tuser)
);

svo_tmds svo_tmds_0(
    .clk(clk_i),
    .resetn(rst_n_i),
    .de(!video_enc_tuser[3]),
    .ctrl(video_enc_tuser[2:1]),
    .din(video_enc_tdata[23:16]),
    .dout({tmds_d9[0], tmds_d8[0], tmds_d7[0], tmds_d6[0], tmds_d5[0],
           tmds_d4[0], tmds_d3[0], tmds_d2[0], tmds_d1[0], tmds_d0[0]})
);

svo_tmds svo_tmds_1(
    .clk(clk_i),
    .resetn(rst_n_i),
    .de(!video_enc_tuser[3]),
    .ctrl(2'b0),
    .din(video_enc_tdata[15:8]),
    .dout({tmds_d9[1], tmds_d8[1], tmds_d7[1], tmds_d6[1], tmds_d5[1],
           tmds_d4[1], tmds_d3[1], tmds_d2[1], tmds_d1[1], tmds_d0[1]})
);

svo_tmds svo_tmds_2(
    .clk(clk_i),
    .resetn(rst_n_i),
    .de(!video_enc_tuser[3]),
    .ctrl(2'b0),
    .din(video_enc_tdata[7:0]),
    .dout({tmds_d9[2], tmds_d8[2], tmds_d7[2], tmds_d6[2], tmds_d5[2],
           tmds_d4[2], tmds_d3[2], tmds_d2[2], tmds_d1[2], tmds_d0[2]})
);

video_out video_out(
    .clk_i(clk_i),
    .rst_n_i(rst_n_i),

    .clk_5x_i(clk_5x_i),

    .tmds_d0_i(tmds_d0),
    .tmds_d1_i(tmds_d1),
    .tmds_d2_i(tmds_d2),
    .tmds_d3_i(tmds_d3),
    .tmds_d4_i(tmds_d4),
    .tmds_d5_i(tmds_d5),
    .tmds_d6_i(tmds_d6),
    .tmds_d7_i(tmds_d7),
    .tmds_d8_i(tmds_d8),
    .tmds_d9_i(tmds_d9),

    .tmds_clk_o_p(tmds_clk_o_p),
    .tmds_clk_o_n(tmds_clk_o_n),
    .tmds_data_o_p(tmds_data_o_p),
    .tmds_data_o_n(tmds_data_o_n)
);

endmodule
