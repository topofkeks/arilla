#ifndef _FONT_H_
#define _FONT_H_

#include "mouse.h"
#include "gpu.h"
#include "colors.h"
#include "icons.h"


extern const unsigned int ASCII_MASK;
extern const unsigned int font8x8_basic[128][8];
void drawCharacterAligned(int character, int row, int column, int color);
void drawStringAligned(const char *string, int row, int column, int color);

#endif