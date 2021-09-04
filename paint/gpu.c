#include "gpu.h"

const unsigned int GPU_BASE_ADDRESS = 0x20000000;
const unsigned int GPU_ENABLE_MASK = 1;
const unsigned int GPU_RUN_MASK = 2;
const unsigned int GPU_CURSOR_MASK = 4;
const unsigned int GPU_READY_MASK = 1;
const unsigned int GPU_OPCODE_DRAW_POINT = 0;
const unsigned int GPU_OPCODE_DRAW_LINE = 1;
const unsigned int GPU_OPCODE_DRAW_RECT = 2;
const unsigned int GPU_OPCODE_FILL_RECT = 3;
const unsigned int GPU_OPCODE_GET_COLOR = 4;
const unsigned int GPU_OPCODE_MASK = 0xE0;
const unsigned int GPU_POSITION_MASK = 0x3FF;
const unsigned int GPU_COLOR_MASK = 0xFFF;

unsigned int lastControl=0;
unsigned int lastStatus=0;

void gpuStart()
{
    lastControl|=GPU_ENABLE_MASK;
    out(GPU_BASE_ADDRESS,lastControl);
}

void gpuStop()
{
    lastControl&=~GPU_ENABLE_MASK;
    out(GPU_BASE_ADDRESS,lastControl);
}

void gpuSetCursor(unsigned int cursor)
{
    if(cursor)
    {
        lastControl|=GPU_CURSOR_MASK;
        out(GPU_BASE_ADDRESS,lastControl);
    }
    else
    {
        lastControl&=~GPU_CURSOR_MASK;
        out(GPU_BASE_ADDRESS,lastControl);
    }
}

void gpuSetColor(unsigned int color)
{
    gpuWaitForReady();
    lastControl = (color<<20) | (lastControl&0xFF);
    out(GPU_BASE_ADDRESS,lastControl);
}

void gpuWaitForReady()
{
    while(((lastStatus = in(GPU_BASE_ADDRESS+4))&GPU_READY_MASK) != 1){}
}

void gpuDrawPoint_c(unsigned int x,unsigned int y,unsigned int color)
{
    gpuSetColor(color);
    gpuDrawPoint(x,y);
}

void gpuDrawPoint(unsigned int x,unsigned int y)
{
    gpuDrawPoint_p((y<<10)|x);
}

void gpuDrawPoint_p(unsigned int pos)
{
    gpuWaitForReady();
    out(GPU_BASE_ADDRESS+8,pos);
    lastControl=(lastControl&~GPU_OPCODE_MASK)|(GPU_OPCODE_DRAW_POINT<<5);
    out(GPU_BASE_ADDRESS,lastControl|GPU_RUN_MASK);
}

void gpuDrawLine_c(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY,unsigned int color)
{
    gpuSetColor(color);
    gpuDrawLine(startX,startY,endX,endY);
}

void gpuDrawLine(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY)
{
    gpuDrawLine_p((startY<<10)|startX,(endY<<10)|endX);
}

void gpuDrawLine_p(unsigned int startPos,unsigned int endPos)
{
    gpuWaitForReady();
    out(GPU_BASE_ADDRESS+8,startPos);
    out(GPU_BASE_ADDRESS+12,endPos);
    lastControl=(lastControl&~GPU_OPCODE_MASK)|(GPU_OPCODE_DRAW_LINE<<5);
    out(GPU_BASE_ADDRESS,lastControl|GPU_RUN_MASK);
}

void gpuDrawRect_c(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY,unsigned int color)
{
    gpuSetColor(color);
    gpuDrawRect(startX,startY,endX,endY);
}

void gpuDrawRect(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY)
{
    gpuDrawRect_p((startY<<10)|startX,(endY<<10)|endX);
}

void gpuDrawRect_p(unsigned int startPos,unsigned int endPos)
{
    gpuWaitForReady();
    out(GPU_BASE_ADDRESS+8,startPos);
    out(GPU_BASE_ADDRESS+12,endPos);
    lastControl=(lastControl&~GPU_OPCODE_MASK)|(GPU_OPCODE_DRAW_RECT<<5);
    out(GPU_BASE_ADDRESS,lastControl|GPU_RUN_MASK);
}

void gpuFillRect_c(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY,unsigned int color)
{
    gpuSetColor(color);
    gpuFillRect(startX,startY,endX,endY);
}
void gpuFillRect(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY)
{
    gpuFillRect_p((startY<<10)|startX,(endY<<10)|endX);
}

void gpuFillRect_p(unsigned int startPos,unsigned int endPos)
{
    gpuWaitForReady();
    out(GPU_BASE_ADDRESS+8,startPos);
    out(GPU_BASE_ADDRESS+12,endPos);
    lastControl=(lastControl&(~GPU_OPCODE_MASK));
    lastControl|=(GPU_OPCODE_FILL_RECT<<5);
    out(GPU_BASE_ADDRESS,lastControl|GPU_RUN_MASK);
}

unsigned int gpuGetColor(unsigned int x,unsigned int y)
{
    return gpuGetColor_p((y<<10)|x);
}

unsigned int gpuGetColor_p(unsigned int pos)
{
    gpuWaitForReady();
    out(GPU_BASE_ADDRESS+8,pos);
    lastControl=(lastControl&~GPU_OPCODE_MASK)|(GPU_OPCODE_GET_COLOR<<5);
    out(GPU_BASE_ADDRESS,lastControl|GPU_RUN_MASK);
    gpuWaitForReady();
    return lastStatus>>20;
}
