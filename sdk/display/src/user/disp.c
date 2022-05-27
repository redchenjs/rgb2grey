/*
 * disp.c
 *
 *  Created on: 2022-05-21 17:32
 *      Author: Jack Chen <redchenjs@live.com>
 */

#include <stdio.h>
#include <string.h>

#include "xil_types.h"
#include "xil_cache.h"
#include "xparameters.h"

#include "FreeRTOS.h"
#include "task.h"

#include "core/log.h"
#include "user/disp.h"

#define TAG "dispT"

static uint8_t frame[DISP_FRAME_SIZE] __attribute__((section(".video_ram")));

static void print_test_pattern(uint8_t *frame, uint32_t width, uint32_t height, uint32_t stride)
{
    uint32_t color = 0;
    uint32_t start = 0;

    for (uint32_t ycoi = 0; ycoi < height; ycoi++) {
        for (uint32_t xcoi = 0; xcoi < (width * 4); xcoi += 4) {
            if (width * 4 / 7 * 1 > xcoi) {
                color = WHITE;
            } else if (width * 4 / 7 * 2 > xcoi) {
                color = YELLOW;
            } else if (width * 4 / 7 * 3 > xcoi) {
                color = CYAN;
            } else if (width * 4 / 7 * 4 > xcoi) {
                color = GREEN;
            } else if (width * 4 / 7 * 5 > xcoi) {
                color = MAGENTA;
            } else if (width * 4 / 7 * 6 > xcoi) {
                color = RED;
            } else {
                color = BLUE;
            }

            frame[start + xcoi    ] = 0xff & (color >> 16);
            frame[start + xcoi + 1] = 0xff & (color >> 8);
            frame[start + xcoi + 2] = 0xff & (color);
        }

        start += stride;
    }

    Xil_DCacheFlushRange((unsigned int)frame, DISP_FRAME_SIZE);
}

void disp_task(void *pvParameters)
{
    char file_name[17] = {0};
    char file_index = 0;

    DISP_START_ADDR = (uint32_t)frame;
    VGEN_START_ADDR = (uint32_t)frame;

    LOG_I(TAG, "Display Mode: %lux%lu", DISP_VIDEO_MODE & 0xffff, (DISP_VIDEO_MODE >> 16) & 0xffff);
    LOG_I(TAG, "Frame Buffer: 0x%08lX", DISP_START_ADDR);
    LOG_I(TAG, "Video Buffer: 0x%08lX", VGEN_START_ADDR);

    print_test_pattern(frame, DISP_FRAME_WIDTH, DISP_FRAME_HEIGHT, DISP_LINE_STRIDE);

    LOG_I(TAG, "started.");

    while (1) {
        vTaskDelay(10000 / portTICK_PERIOD_MS);

        memset(file_name, 0x00, sizeof(file_name));

        snprintf(file_name, sizeof(file_name), "%s_%u.bmp", "pic", file_index++ % 10);

        VGEN_FNAME_0   = *(uint32_t *)(file_name + 0x00);
        VGEN_FNAME_1   = *(uint32_t *)(file_name + 0x04);
        VGEN_FNAME_2   = *(uint32_t *)(file_name + 0x08);
        VGEN_FNAME_3   = *(uint32_t *)(file_name + 0x0C);
        VGEN_FNAME_LEN = strlen(file_name);
        VGEN_STATUS    = 0x00000000;

        memset(file_name, 0x00, sizeof(file_name));

        *(uint32_t *)(file_name + 0x00) = VGEN_FNAME_0;
        *(uint32_t *)(file_name + 0x04) = VGEN_FNAME_1;
        *(uint32_t *)(file_name + 0x08) = VGEN_FNAME_2;
        *(uint32_t *)(file_name + 0x0C) = VGEN_FNAME_3;

        LOG_I(TAG, "File Name: \"%s\", Length: %lu, Status: 0x%04lX", file_name, VGEN_FNAME_LEN, VGEN_STATUS);
    }
}
