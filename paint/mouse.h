#ifndef _MOUSE_H_
#define _MOUSE_H_

#include "io.h"

extern const unsigned int MOUSE_BASE_ADDRESS;
extern const unsigned int MOUSE_ENABLE_MASK;
extern const unsigned int MOUSE_LCLICK_MASK;
extern const unsigned int MOUSE_RCLICK_MASK;
extern const unsigned int MOUSE_CHANGE_MASK;
extern const unsigned int MOUSE_POSITION_MASK;

typedef struct point
{
    unsigned int x;
    unsigned int y;
} point;

void mouseStart();
void mouseStop();

void mouseRead();

unsigned int mouseLDown();
unsigned int mouseChanged();

point mousePos();



#endif // _MOUSE_H_
