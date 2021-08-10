#include "mouse.h"

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
    g_mouseStatus=in(MOUSE_BASE_ADDRESS+1)
}

int mouseLDown()
{
    return g_mouseStatus&MOUSE_LCLICK_MASK;
}

int mouseChanged()
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
