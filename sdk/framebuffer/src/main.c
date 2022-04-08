#include <stdio.h>
#include <stdint.h>
#include <string.h>

#include "xil_types.h"
#include "xil_cache.h"
#include "xil_printf.h"

#include "platform.h"
#include "xparameters.h"

#define DISP_START_ADDR *(volatile uint32_t *)(0x43000000)
#define DISP_VIDEO_MODE *(volatile uint32_t *)(0x43000004)

#define DISP_FRAME_WIDTH  (1920)
#define DISP_FRAME_HEIGHT (1080)
#define DISP_FRAME_SIZE   (DISP_FRAME_WIDTH * DISP_FRAME_HEIGHT * 4)
#define DISP_LINE_STRIDE  (DISP_FRAME_WIDTH * 4)

#define WHITE	(0xffffff)
#define BLACK	(0x000000)
#define BLUE	(0xff0000)
#define GREEN	(0x00ff00)
#define RED		(0x0000ff)
#define CYAN	(0xffff00)
#define YELLOW	(0x00ffff)
#define MAGENTA	(0xff00ff)

uint8_t frame[DISP_FRAME_SIZE] __attribute__((section(".framebuffer")));

void print_test_pattern(uint8_t *frame, uint32_t width, uint32_t height, uint32_t stride)
{
	uint32_t color = 0;
	uint32_t start = 0;

	for (u32 ycoi = 0; ycoi < height; ycoi++) {
		for (u32 xcoi = 0; xcoi < (width * 4); xcoi += 4) {
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

int main(void)
{
    init_platform();

    DISP_START_ADDR = (uint32_t)frame;

    printf("Display Mode: %lux%lu\r\n", DISP_VIDEO_MODE & 0xffff, (DISP_VIDEO_MODE >> 16) & 0xffff);
    printf("Frame Buffer: 0x%08lX\r\n", DISP_START_ADDR);

	print_test_pattern(frame, DISP_FRAME_WIDTH, DISP_FRAME_HEIGHT, DISP_LINE_STRIDE);

	return 0;
}
