#include "io.h"
#ifdef PAINT_TEST

#include <stdio.h>

void out(unsigned int address,unsigned int value)
{
    printf("%#X:%#X\n",address,value);
    fflush(stdout);
}

unsigned int in(unsigned int address)
{
    unsigned int value;
    printf("%#X\n",address);
    fflush(stdout);
    scanf("%x",&value);
    return value;
}

#else

//TODO This needs to be checked further

__attribute__((naked)) void out(unsigned int address,unsigned int value)
{
    asm("sw a1,0(a0)");
    asm("ret");
}

__attribute__((naked)) unsigned int in(unsigned int address)
{
    asm("lw a0,0(a0)");
    asm("ret");
}

#endif // PAINT_TEST
