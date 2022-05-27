/*
 * disp.h
 *
 *  Created on: 2022-05-21 17:33
 *      Author: Jack Chen <redchenjs@live.com>
 */

#ifndef INC_USER_DISP_H_
#define INC_USER_DISP_H_

#define WHITE   (0xffffff)
#define BLACK   (0x000000)
#define BLUE    (0xff0000)
#define GREEN   (0x00ff00)
#define RED     (0x0000ff)
#define CYAN    (0xffff00)
#define YELLOW  (0x00ffff)
#define MAGENTA (0xff00ff)

#define DISP_START_ADDR *(volatile uint32_t *)(0x43C00000)
#define DISP_VIDEO_MODE *(volatile uint32_t *)(0x43C00004)

#define VGEN_START_ADDR *(volatile uint32_t *)(0x43C10000)
#define VGEN_FNAME_0    *(volatile uint32_t *)(0x43C10004)
#define VGEN_FNAME_1    *(volatile uint32_t *)(0x43C10008)
#define VGEN_FNAME_2    *(volatile uint32_t *)(0x43C1000C)
#define VGEN_FNAME_3    *(volatile uint32_t *)(0x43C10010)
#define VGEN_FNAME_LEN  *(volatile uint32_t *)(0x43C10014)
#define VGEN_STATUS     *(volatile uint32_t *)(0x43C10018)

#define DISP_FRAME_WIDTH  (1920)
#define DISP_FRAME_HEIGHT (1080)
#define DISP_FRAME_SIZE   (DISP_FRAME_WIDTH * DISP_FRAME_HEIGHT * 4)
#define DISP_LINE_STRIDE  (DISP_FRAME_WIDTH * 4)

extern void disp_task(void *pvParameters);

#endif /* INC_USER_DISP_H_ */
