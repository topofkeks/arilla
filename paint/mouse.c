#include "mouse.h"

const unsigned int MOUSE_BASE_ADDRESS = 0x10000000;
const unsigned int MOUSE_ENABLE_MASK = 1;
const unsigned int MOUSE_LCLICK_MASK = 2;
const unsigned int MOUSE_RCLICK_MASK = 4;
const unsigned int MOUSE_CHANGE_MASK = 8;
const unsigned int MOUSE_POSITION_MASK = 0x3FF;

unsigned int g_mouseStatus=0;

void mouseStart()
{
    out(MOUSE_BASE_ADDRESS,MOUSE_ENABLE_MASK);
}

void mouseStop()
{
    out(MOUSE_BASE_ADDRESS,0);
}

void mouseRead()
{
    g_mouseStatus=in(MOUSE_BASE_ADDRESS+4);
}

unsigned int mouseLDown()
{
    return g_mouseStatus&MOUSE_LCLICK_MASK;
}

unsigned int mouseChanged()
{
    return g_mouseStatus&MOUSE_CHANGE_MASK;
}

point mousePos()
{
    point p;
    p.x=(g_mouseStatus>>12)&MOUSE_POSITION_MASK;
    p.y=g_mouseStatus>>22;
    return p;
}
