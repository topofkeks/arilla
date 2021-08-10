#ifndef _GPU_H_
#define _GPU_H_

#include "io.h"

const int GPU_BASE_ADDRESS = 0x2000 0000;
const int GPU_ENABLE_MASK = 1;
const int GPU_RUN_MASK = 2;
const int GPU_CURSOR_MASK = 4;
const int GPU_READY_MASK = 1;
//const int GPU_OPCODE_DRAW_POINT = 0;
//const int GPU_OPCODE_DRAW_LINE = 1;
//const int GPU_OPCODE_DRAW_RECT = 2;
//const int GPU_OPCODE_FILL_RECT = 3;
//const int GPU_OPCODE_GET_COLOR = 4;
//const int GPU_OPCODE_MASK = 0x3FF;
const int GPU_POSITION_MASK = 0x3FF;
const int GPU_COLOR_MASK = 0xFFF;

void gpuStart();
void gpuStop();

void gpuSetCursor(int cursor);

void gpuSetColor(unsigned int color);

void gpuWaitForReady();

void gpuDrawPoint(unsigned int x,unsigned int y,unsigned int color);
void gpuDrawPoint(unsigned int x,unsigned int y);
void gpuDrawPoint(unsigned int pos);

void gpuDrawLine(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY,unsigned int color);
void gpuDrawLine(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY);
void gpuDrawLine(unsigned int startPos,unsigned int endPos);

void gpuDrawRect(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY,unsigned int color);
void gpuDrawRect(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY);
void gpuDrawRect(unsigned int startPos,unsigned int endPos);

void gpuFillRect(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY,unsigned int color);
void gpuFillRect(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY);
void gpuFillRect(unsigned int startPos,unsigned int endPos);

unsigned int gpuGetColor(unsigned int x,unsigned int y);
unsigned int gpuGetColor(unsigned int pos);

#endif // _GPU_H_

