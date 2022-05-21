/*
 * main.c
 *
 *  Created on: 2022-05-21 17:32
 *      Author: Jack Chen <redchenjs@live.com>
 */

#include "FreeRTOS.h"
#include "task.h"

#include "user/disp.h"

int main(void)
{
    xTaskCreate(disp_task, "dispT", configMINIMAL_STACK_SIZE, NULL, tskIDLE_PRIORITY, NULL);

    vTaskStartScheduler();

    return 0;
}
