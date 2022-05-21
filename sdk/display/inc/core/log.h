/*
 * log.h
 *
 *  Created on: 2022-05-21 17:32
 *      Author: Jack Chen <redchenjs@live.com>
 */

#ifndef INC_CORE_LOG_H_
#define INC_CORE_LOG_H_

#include <stdio.h>

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

#define LOG_FORMAT(letter, format) LOG_COLOR_ ## letter #letter " (%lu) %s: " format LOG_RESET_COLOR "\r\n"

#define LOG_E(tag, format, ...) printf(LOG_FORMAT(E, format), log_get_timestamp(), tag, ##__VA_ARGS__)
#define LOG_W(tag, format, ...) printf(LOG_FORMAT(W, format), log_get_timestamp(), tag, ##__VA_ARGS__)
#define LOG_I(tag, format, ...) printf(LOG_FORMAT(I, format), log_get_timestamp(), tag, ##__VA_ARGS__)
#define LOG_D(tag, format, ...) printf(LOG_FORMAT(D, format), log_get_timestamp(), tag, ##__VA_ARGS__)
#define LOG_V(tag, format, ...) printf(LOG_FORMAT(V, format), log_get_timestamp(), tag, ##__VA_ARGS__)

extern uint32_t log_get_timestamp(void);

#endif /* INC_CORE_LOG_H_ */
