#ifndef _PERIPHERAL_H_
#define _PERIPHERAL_H_

#include "mouse.h"
#include "gpu.h"
#include "colors.h"
#include "icons.h"

void drawIcon(unsigned int x,unsigned int y,unsigned int zCol,unsigned int oCol,const unsigned int icon[]);
void drawIconOpt(unsigned int x,unsigned int y,unsigned int col,const unsigned int icon[],unsigned int bgVal);
void floodFill(unsigned int x,unsigned int y,unsigned int dst);
void EE();

#endif // _PERIPHERAL_H_
