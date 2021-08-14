//TODO Final version should be aggressively inlined and thus merged into single file, lets keep it separated for now
//TODO Final version should be optimized for memory and variable sizes, lets do that after we get it working
#include "peripheral.h"

//Display resolution: 800x600

unsigned int selectedTool=0;
unsigned int selectedColor=0;

void setup();
void loop();

int main()
{
    setup();

    while (1)
    {
        loop();
    }
    return 0;
}

void setup()
{
    mouseStart();
    gpuStart();
    gpuSetCursor(1);

    //Draw UI

    const unsigned int UI_START_Y=600-64;

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

    drawIcon(320,UI_START_Y,COLOR_BLACK,COLOR_GRAY,ICON_PEN);
    drawIcon(352,UI_START_Y,COLOR_BLACK,COLOR_GRAY,ICON_RECT);
    drawIcon(384,UI_START_Y,COLOR_BLACK,COLOR_GRAY,ICON_BUCKET);
    drawIcon(320,UI_START_Y+32,COLOR_BLACK,COLOR_GRAY,ICON_LINE);
    drawIcon(352,UI_START_Y+32,COLOR_BLACK,COLOR_GRAY,ICON_FILL_RECT);
    drawIcon(384,UI_START_Y+32,COLOR_BLACK,COLOR_GRAY,ICON_CLEAR);
}

void loop()
{

}
