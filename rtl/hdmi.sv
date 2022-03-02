`include "svo/svo_defines.vh"

module hdmi(
    input logic clk_i,
    input logic rst_n_i,

    input logic aux_clk_i,

    output logic       tmds_txc_o_p,
    output logic       tmds_txc_o_n,
    output logic [2:0] tmds_txd_o_p,
    output logic [2:0] tmds_txd_o_n,

    output logic [3:0] auto_btn_o
);

localparam SVO_MODE           = "1366x768R";
localparam SVO_FRAMERATE      = 60;
localparam SVO_BITS_PER_PIXEL = 24;
localparam SVO_BITS_PER_RED   = 8;
localparam SVO_BITS_PER_GREEN = 8;
localparam SVO_BITS_PER_BLUE  = 8;
localparam SVO_BITS_PER_ALPHA = 0;

logic [3:0] btn;
assign auto_btn_o = btn;

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

logic [2:0] tmds_d;
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

    .btn(btn),
    .auto_btn(btn),

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

OSER10 tmds_serdes [2:0] (
    .Q(tmds_d),
    .D0(tmds_d0),
    .D1(tmds_d1),
    .D2(tmds_d2),
    .D3(tmds_d3),
    .D4(tmds_d4),
    .D5(tmds_d5),
    .D6(tmds_d6),
    .D7(tmds_d7),
    .D8(tmds_d8),
    .D9(tmds_d9),
    .PCLK(clk_i),
    .FCLK(aux_clk_i),
    .RESET(~rst_n_i)
);

ELVDS_OBUF tmds_bufds [3:0] (
    .I({clk_i, tmds_d}),
    .O({tmds_txc_o_p, tmds_txd_o_p}),
    .OB({tmds_txc_o_n, tmds_txd_o_n})
);

endmodule
