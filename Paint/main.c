//TODO Final version should be aggressively inlined and thus merged into single file, lets keep it separated for now
//TODO Final version should be optimized for memory and variable sizes, lets do that after we get it working
#include "peripheral.h"

//Display resolution: 800x600

const unsigned int UI_START_Y=600-64;

unsigned int selectedTool=0;
unsigned int selectedColor=0;
unsigned int lastMouse=0;
unsigned int track=0;
unsigned int ui=0;
struct point startPoint;

void setup();

int main()
{
    setup();

    while (1)
    {
        mouseRead();
        struct point p=mousePos();
        if(mouseChanged() && track)
        {
            //Mouse Move
            if(p.y>=(600-64)){p.y=600-64-1;}
            unsigned int dx=p.x>startPoint.x?p.x-startPoint.x:startPoint.x-p.x;
            unsigned int dy=p.y>startPoint.y?p.y-startPoint.y:startPoint.y-p.y;
            if(dx<2 && dy<2)
            {
                gpuDrawPoint(p.x,p.y);
            }
            else
            {
                gpuDrawLine(startPoint.x,startPoint.y,p.x,p.y);
            }
            startPoint=p;
        }
        if(mouseLDown() && !lastMouse)
        {
            //Mouse Press
            if(p.y<(600-64))
            {
                ui=0;
                if(selectedTool!= 2)
                {
                    if(selectedTool == 0)
                    {
                        track=1;
                        gpuDrawPoint(p.x,p.y);
                    }
                    startPoint=p;
                }
            }
            else
            {
                ui=1;
            }
        }
        if(!mouseLDown() && lastMouse)
        {
            //Mouse Release
            track = 0;
            if(p.y<(600-64) && !ui)
            {
                switch (selectedTool)
                {
                    case 3:{ gpuDrawLine(startPoint.x,startPoint.y,p.x,p.y); break;}
                    case 1:{ gpuDrawRect(startPoint.x,startPoint.y,p.x,p.y); break;}
                    case 4:{ gpuFillRect(startPoint.x,startPoint.y,p.x,p.y); break;}
                    case 2:{ break;}
                    default :{break;}
                }
            }
            else if(p.y>=(600-64) && ui)
            {
                unsigned int ind = p.x>>5;
                if(ind < 2)
                {
                    //Current Color
                }
                else if(ind < 10)
                {
                    //Color Picker
                    ind-=2;
                    ind+=(p.y>=600-32?8:0); //Are we in the second row
                    selectedColor=ind;
                    gpuSetColor(COLOR_LUT[selectedColor]);
                    gpuFillRect(1,UI_START_Y+1,63-1,599-1);
                }
                else if(ind <16)
                {
                    //Tool Picker
                    ind-=10;
                    ind+=(p.y>=600-32?3:0); //Are we in the second row

                    /*switch(selectedTool)
                    {
                        case 0:{ drawIconOpt(320,UI_START_Y,COLOR_BLACK,ICON_PEN,1); break;}
                        case 1:{ drawIconOpt(352,UI_START_Y,COLOR_BLACK,ICON_RECT,1); break;}
                        case 2:{ drawIconOpt(384,UI_START_Y,COLOR_BLACK,ICON_BUCKET,1); break;}
                        case 3:{ drawIconOpt(320,UI_START_Y+32,COLOR_BLACK,ICON_LINE,1); break;}
                        case 4:{ drawIconOpt(352,UI_START_Y+32,COLOR_BLACK,ICON_FILL_RECT,1); break;}
                        case 5:{ drawIconOpt(384,UI_START_Y+32,COLOR_BLACK,ICON_CLEAR,1); break;}
                    }*/

                    if(ind==5) //Clear screen cant really be selected
                    {
                        gpuFillRect_c(0,0,799,UI_START_Y-1,COLOR_WHITE);
                        gpuSetColor(COLOR_LUT[selectedColor]);
                    }
                    else
                    {
                        selectedTool=ind;
                    }

                    /*switch(selectedTool)
                    {
                        case 0:{ drawIconOpt(320,UI_START_Y,COLOR_RED,ICON_PEN,1); break;}
                        case 1:{ drawIconOpt(352,UI_START_Y,COLOR_RED,ICON_RECT,1); break;}
                        case 2:{ drawIconOpt(384,UI_START_Y,COLOR_RED,ICON_BUCKET,1); break;}
                        case 3:{ drawIconOpt(320,UI_START_Y+32,COLOR_RED,ICON_LINE,1); break;}
                        case 4:{ drawIconOpt(352,UI_START_Y+32,COLOR_RED,ICON_FILL_RECT,1); break;}
                        case 5:{ drawIconOpt(384,UI_START_Y+32,COLOR_RED,ICON_CLEAR,1); break;}
                    }*/

                }
            }
        }
        lastMouse=mouseLDown();
    }
    return 0;
}

void setup()
{
    mouseStart();
    gpuStart();
    gpuSetCursor(1);

    //Draw UI

    gpuFillRect_c(0,0,799,UI_START_Y-1,COLOR_WHITE);
    gpuFillRect_c(416,UI_START_Y,799,599,COLOR_DARK_GRAY);
    gpuFillRect_c(1,UI_START_Y+1,63-1,599-1,COLOR_LUT[selectedColor]);
    gpuDrawRect_c(0,UI_START_Y,63,599,0xAAA);

    //Draw color palette

    for(int i=0;i<2;i++)
    {
        for(int j=0;j<8;j++)
        {
            gpuFillRect_c(64+(j*32),UI_START_Y+(i*32),64+31+(j*32),UI_START_Y+31+(i*32),COLOR_LUT[8*i+j]);
        }
    }

    gpuFillRect_c(320,UI_START_Y,415,599,COLOR_GRAY);

    drawIconOpt(320,UI_START_Y,COLOR_BLACK,ICON_PEN,1);
    drawIconOpt(352,UI_START_Y,COLOR_BLACK,ICON_RECT,1);
    drawIconOpt(384,UI_START_Y,COLOR_BLACK,ICON_BUCKET,1);
    drawIconOpt(320,UI_START_Y+32,COLOR_BLACK,ICON_LINE,1);
    drawIconOpt(352,UI_START_Y+32,COLOR_BLACK,ICON_FILL_RECT,1);
    drawIconOpt(384,UI_START_Y+32,COLOR_BLACK,ICON_CLEAR,1);

    gpuSetColor(COLOR_LUT[selectedColor]);
}
