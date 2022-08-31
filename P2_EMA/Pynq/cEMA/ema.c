
#include <stdio.h>
#include <stdlib.h>

#include "ema.h"

static uint32_t y = 1000; //FIXME

void ema_reset( void )
{
    y = 1000;//FIXME
}

uint32_t ema_simple(uint32_t x)
{
    y = (int) x/4 + ((int)y/4+(int)y/2);//FIXME
    //y = (int) x/4 + ((int)y/4+(int)y/2);
    //y = (int) x/4 + ((int)y/4+(int)y/2);
    return y;
}

