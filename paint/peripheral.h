#ifndef _PERIPHERAL_H_
#define _PERIPHERAL_H_

#include "mouse.h"
#include "gpu.h"

extern const unsigned int ICON_PEN;
extern const unsigned int ICON_LINE;
extern const unsigned int ICON_RECT;
extern const unsigned int ICON_FILL_RECT;
extern const unsigned int ICON_BUCKET;
extern const unsigned int ICON_CLEAR;
extern const unsigned int ICON_ETF;
extern const unsigned int ICON_ARILLA;
void drawIconOpt(unsigned int x,unsigned int y,unsigned int col,const unsigned int icon,unsigned int bgVal);
void floodFill(unsigned int x,unsigned int y,unsigned int dst);
void EE();
void AL(unsigned int x,unsigned int y,unsigned int scale,unsigned int scale2);

#endif // _PERIPHERAL_H_
