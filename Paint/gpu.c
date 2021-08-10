#include "gpu.h"

unsigned int lastControl=0;
unsigned int lastStatus=0;

void gpuStart()
{
    lastControl|=GPU_ENABLE_MASK;
    out(GPU_BASE_ADDRESS,lastControl);
}

void gpuStop()
{
    lastControl&=!GPU_ENABLE_MASK;
    out(GPU_BASE_ADDRESS,lastControl);
}

void gpuSetCursor(int cursor)
{
    if(cursor)
    {
        lastControl|=GPU_CURSOR_MASK;
        out(GPU_BASE_ADDRESS,lastControl);
    }
    else
    {
        lastControl&=!GPU_CURSOR_MASK;
        out(GPU_BASE_ADDRESS,lastControl);
    }
}

void gpuSetColor(unsigned int color)
{
    lastControl = (color<<20) | (lastControl&0xF);
    out(GPU_BASE_ADDRESS,lastControl);
}

void gpuWaitForReady()
{
    while(!((lastStatus=in(GPU_BASE_ADDRESS+1))&GPU_READY_MASK)){} //TODO This mess might need to simplified
}

void gpuDrawPoint(unsigned int x,unsigned int y,unsigned int color)
{
    gpuSetColor(color);
    gpuDrawPoint(x,y);
}

void gpuDrawPoint(unsigned int x,unsigned int y)
{
    gpuDrawPoint((y<<10)|x);
}

void gpuDrawPoint(unsigned int pos)
{

}

void gpuDrawLine(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY,unsigned int color)
{
    gpuSetColor(color);
    gpuDrawLine(x,y);
}

void gpuDrawLine(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY)
{
    gpuDrawLine((startY<<10)|startX,(endY<<10)|endX);
}

void gpuDrawLine(unsigned int startPos,unsigned int endPos)
{

}

void gpuDrawRect(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY,unsigned int color)
{
    gpuSetColor(color);
    gpuDrawRect(x,y);
}

void gpuDrawRect(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY)
{
    gpuDrawRect((startY<<10)|startX,(endY<<10)|endX);
}

void gpuDrawRect(unsigned int startPos,unsigned int endPos)
{

}

void gpuFillRect(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY,unsigned int color)
{
    gpuSetColor(color);
    gpuFillRect(x,y);
}
void gpuFillRect(unsigned int startX,unsigned int startY,unsigned int endX,unsigned int endY)
{
    gpuFillRect((startY<<10)|startX,(endY<<10)|endX);
}

void gpuFillRect(unsigned int startPos,unsigned int endPos)
{

}

unsigned int gpuGetColor(unsigned int x,unsigned int y)
{
    gpuGetColor((y<<10)|x);
}

unsigned int gpuGetColor(unsigned int pos)
{
    gpuWaitForReady();
    out(GPU_BASE_ADDRESS+2,pos);
    //out(GPU_BASE_ADDRESS,pos);
    gpuWaitForReady();
}
