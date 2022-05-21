/*
 * log.h
 *
 *  Created on: 2022-05-21 17:32
 *      Author: Jack Chen <redchenjs@live.com>
 */

#ifndef INC_LOG_H_
#define INC_LOG_H_

#include "xil_printf.h"

#define LOG_COLOR_BLACK   "30"
#define LOG_COLOR_RED     "31"
#define LOG_COLOR_GREEN   "32"
#define LOG_COLOR_BROWN   "33"
#define LOG_COLOR_BLUE    "34"
#define LOG_COLOR_PURPLE  "35"
#define LOG_COLOR_CYAN    "36"
#define LOG_COLOR(COLOR)  "\033[0;" COLOR "m"
#define LOG_BOLD(COLOR)   "\033[1;" COLOR "m"
#define LOG_RESET_COLOR   "\033[0m"
#define LOG_COLOR_E       LOG_COLOR(LOG_COLOR_RED)
#define LOG_COLOR_W       LOG_COLOR(LOG_COLOR_BROWN)
#define LOG_COLOR_I       LOG_COLOR(LOG_COLOR_GREEN)
#define LOG_COLOR_D
#define LOG_COLOR_V

#define LOG_FORMAT(letter, format) LOG_COLOR_ ## letter #letter " (%u) %s: " format LOG_RESET_COLOR "\r\n"
#define LOG_IMPL(tag, format, log_tag_letter, ...) xil_printf(LOG_FORMAT(log_tag_letter, format), log_get_timestamp(), tag, ##__VA_ARGS__);

#define OS_LOGE(tag, format, ...) LOG_IMPL(tag, format, E, ##__VA_ARGS__)
#define OS_LOGW(tag, format, ...) LOG_IMPL(tag, format, W, ##__VA_ARGS__)
#define OS_LOGI(tag, format, ...) LOG_IMPL(tag, format, I, ##__VA_ARGS__)
#define OS_LOGD(tag, format, ...) LOG_IMPL(tag, format, D, ##__VA_ARGS__)
#define OS_LOGV(tag, format, ...) LOG_IMPL(tag, format, V, ##__VA_ARGS__)

extern uint32_t log_get_timestamp(void);

#endif /* INC_LOG_H_ */
