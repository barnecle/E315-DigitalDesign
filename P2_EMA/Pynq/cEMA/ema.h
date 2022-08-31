#ifndef __POPCOUNT_H__
#define __POPCOUNT_H__

#include <stdint.h>

/** 
    resets  the initial value of the EMA computation
**/
void ema_reset( void );

/** 
    runs a simple EMA filter on a single input value
**/
uint32_t ema_simple(uint32_t num);

#endif
