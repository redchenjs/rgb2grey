/*
 * disp.c
 *
 *  Created on: 2022-05-21 17:32
 *      Author: Jack Chen <redchenjs@live.com>
 */

#include "xil_types.h"
#include "xil_cache.h"
#include "xparameters.h"

#include "FreeRTOS.h"
#include "task.h"

#include "core/log.h"
#include "user/disp.h"

#define TAG "dispT"

static uint8_t frame[DISP_FRAME_SIZE] __attribute__((section(".video_ram")));

static void disp_print_test_pattern(uint8_t *frame, uint32_t width, uint32_t height, uint32_t stride)
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
	DISP_START_ADDR = (uint32_t)frame;
	VGEN_START_ADDR = (uint32_t)frame;

	OS_LOGI(TAG, "Display Mode: %lux%lu", DISP_VIDEO_MODE & 0xffff, (DISP_VIDEO_MODE >> 16) & 0xffff);
	OS_LOGI(TAG, "Frame Buffer: 0x%08lX", DISP_START_ADDR);
	OS_LOGI(TAG, "Video Buffer: 0x%08lX", VGEN_START_ADDR);

	disp_print_test_pattern(frame, DISP_FRAME_WIDTH, DISP_FRAME_HEIGHT, DISP_LINE_STRIDE);

	OS_LOGI(TAG, "started.");

	while (1) {
		vTaskDelay(pdMS_TO_TICKS(1000UL));
	}
}
