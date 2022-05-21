/*
 * log.c
 *
 *  Created on: 2022-05-21 17:32
 *      Author: Jack Chen <redchenjs@live.com>
 */

#include "FreeRTOS.h"
#include "task.h"

uint32_t log_get_timestamp(void)
{
    TickType_t tick_count = xTaskGetTickCount();

    return tick_count * (1000 / configTICK_RATE_HZ);
}
