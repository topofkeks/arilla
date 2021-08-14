#include "peripheral.h"

void drawIcon(unsigned int x,unsigned int y,unsigned int zCol,unsigned int oCol,const unsigned int icon[])
{
    for(int i=0;i<32;i++)
    {
        unsigned int row=icon[i];
        for(int j=31;j>=0;j--)
        {
            gpuDrawPoint_c(x+j,y+i,row%2==0?zCol:oCol);
            row>>=1;
        }
    }
}
