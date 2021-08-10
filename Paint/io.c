#ifdef TEST

#include <stdio.h>

void out(int address, int value)
{
    printf("%d:%d\n",address,value);
}

int in(int address)
{
    int value;
    printf("%d\n",address);
    scanf("%d",&value);
    return value
}

#else

//TODO This needs to be checked further

__attribute__((naked)) void out(int address, int value)
{
    asm("sw a1,0(a0)");
    asm("ret");
}

__attribute__((naked)) int in(int address)
{
    asm("lw a0,0(a0)");
    asm("ret");
}

#endif // TEST
