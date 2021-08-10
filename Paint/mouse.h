#ifndef _MOUSE_H_
#define _MOUSE_H_

#include "io.h"

const int MOUSE_BASE_ADDRESS = 0x1000 0000;
const int MOUSE_ENABLE_MASK = 1;
const int MOUSE_LCLICK_MASK = 2;
const int MOUSE_RCLICK_MASK = 4;
const int MOUSE_CHANGE_MASK = 8;
const int MOUSE_POSITION_MASK = 0x3FF;

typedef struct point
{
    int x;
    int y;
} point;

void mouseStart();
void mouseStop();

void mouseRead();

int mouseLDown();
int mouseChanged();

point mousePos();



#endif // _MOUSE_H_
