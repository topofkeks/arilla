#ifndef _GPU_H_
#define _GPU_H_

#include "io.h"

extern const unsigned int GPU_BASE_ADDRESS;
extern const unsigned int GPU_ENABLE_MASK;
extern const unsigned int GPU_RUN_MASK;
extern const unsigned int GPU_CURSOR_MASK;
extern const unsigned int GPU_READY_MASK;
extern const unsigned int GPU_OPCODE_DRAW_POINT;
extern const unsigned int GPU_OPCODE_DRAW_LINE;
extern const unsigned int GPU_OPCODE_DRAW_RECT;
extern const unsigned int GPU_OPCODE_FILL_RECT;
extern const unsigned int GPU_OPCODE_GET_COLOR;
extern const unsigned int GPU_OPCODE_MASK;
extern const unsigned int GPU_POSITION_MASK;
extern const unsigned int GPU_COLOR_MASK;

//TODO TMP
extern unsigned int lastControl;

void gpuStart();
void gpuStop();

void gpuSetCursor(unsigned int cursor);

void gpuSetColor(unsigned int color);

void gpuWaitForReady();

void gpuDrawPoint_c(unsigned int x,unsigned int y,unsigned int color);
void gpuDrawPoint(unsigned int x,unsigned int y);
void gpuDrawPoint_p(unsigned int pos);

void gpuDrawLine_c(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY,unsigned int color);
void gpuDrawLine(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY);
void gpuDrawLine_p(unsigned int startPos,unsigned int endPos);

void gpuDrawRect_c(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY,unsigned int color);
void gpuDrawRect(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY);
void gpuDrawRect_p(unsigned int startPos,unsigned int endPos);

void gpuFillRect_c(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY,unsigned int color);
void gpuFillRect(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY);
void gpuFillRect_p(unsigned int startPos,unsigned int endPos);

unsigned int gpuGetColor(unsigned int x,unsigned int y);
unsigned int gpuGetColor_p(unsigned int pos);

#endif // _GPU_H_

