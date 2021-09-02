#define EEG
#define TEXT
//TODO Final version should be aggressively inlined and thus merged into single file, lets keep it separated for now
//TODO Final version should be optimized for memory and variable sizes, lets do that after we get it working
#include "peripheral.h"
#include "font.h"

//Display resolution: 800x600

const unsigned int COLOR_WHITE=0xFFF;
const unsigned int COLOR_GRAY=0xCCC;
const unsigned int COLOR_DARK_GRAY=0x888;
const unsigned int COLOR_BLACK=0x000;

const unsigned int UI_START_Y=600-64;

const char *toolnames[] =  {"Pen", "Rectangle", "Paint bucket", "Line", "Filled", "rectangle"};

unsigned int selectedTool=0;
unsigned int selectedColor=0;
unsigned int lastMouse=0;
unsigned int track=0;
unsigned int colortrack=0;
unsigned int channel=0;
unsigned int ui=0;
#ifdef EEG
unsigned int untouched=1;
#endif
struct point startPoint;

void setup();
void updateColor(unsigned int channel,unsigned int val,unsigned int type);
void DrawSplash();

int main()
{
    setup();

    while (1)
    {
        mouseRead();
        struct point p=mousePos();
        if(mouseChanged())
        {
            //Mouse Move
            if(track){
                //Mouse moved while using pen
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
            if(colortrack)
            {
                int colorindex=(p.x>>5)-2;
                if(colorindex < 0){colorindex =0;}
                if(colorindex >15){colorindex = 15;}
                updateColor(channel,colorindex,0);
            }
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
                #ifdef EEG
                if(p.x>800-32)
                {
                    ui=2;
                }
                #endif
                if(p.x>=64 && p.x<576)
                {
                    int colorindex=(p.x>>5)-2;
                    if(p.y>=UI_START_Y+2 && p.y<UI_START_Y+22)        {colortrack=1;channel=8;updateColor(channel,colorindex,1);}
                    else if(p.y>=UI_START_Y+22 && p.y<UI_START_Y+42)  {colortrack=1;channel=4;updateColor(channel,colorindex,1);}
                    else if(p.y>=UI_START_Y+42 && p.y<UI_START_Y+62)  {colortrack=1;channel=0;updateColor(channel,colorindex,1);}
                }
            }
        }
        if(!mouseLDown() && lastMouse)
        {
            //Mouse Release
            track = 0;
            if(colortrack)
            {
                int colorindex=(p.x>>5)-2;
                if(colorindex < 0){colorindex =0;}
                if(colorindex >15){colorindex = 15;}
                updateColor(channel,colorindex,2);
            }
            colortrack=0;
            if(p.y<(600-64) && !ui)
            {
                switch (selectedTool)
                {
                    case 3:{ gpuDrawLine(startPoint.x,startPoint.y,p.x,p.y); break;}
                    case 1:{ gpuDrawRect(startPoint.x,startPoint.y,p.x,p.y); break;}
                    case 4:{ gpuFillRect(startPoint.x,startPoint.y,p.x,p.y); break;}
                    case 2:{
                        #ifdef EEG
                        untouched=0;
                        #endif
                        floodFill(p.x,p.y,selectedColor);
                        break;}
                    default :{break;}
                }
            }
            else if(p.y>=(600-64) && ui)
            {
                unsigned int ind = p.x>>5;
                if(ind < 2)
                {
                    //Current Color
                    #ifdef EEG
                    if(ui==2 && untouched)
                    {
                        EE();
                    }
                    #endif
                }
                else if(ind < 18)
                {
                }
                else if(ind <21)
                {
                    //Tool Picker
                    ind-=18;
                    ind+=(p.y>=600-32?3:0); //Are we in the second row

                    if(ind==5) //Clear screen cant really be selected
                    {
                        gpuFillRect_c(0,0,799,UI_START_Y-1,COLOR_WHITE);
                        gpuSetColor(selectedColor);
                    }
                    else
                    {
                        selectedTool=ind;
                        #ifdef TEXT
                        if(selectedTool!=4)
                        {
                            gpuFillRect_c(680, UI_START_Y+8, 799, UI_START_Y+23, COLOR_DARK_GRAY);
                            drawStringAligned(toolnames[selectedTool], 85, UI_START_Y/8 + 1, COLOR_BLACK);
                            gpuSetColor(selectedColor);
                        }
                        else
                        {
                            gpuFillRect_c(680, UI_START_Y+8, 799, UI_START_Y+23, COLOR_DARK_GRAY);
                            drawStringAligned(toolnames[selectedTool], 85, UI_START_Y/8 + 1, COLOR_BLACK);
                            drawStringAligned(toolnames[selectedTool+1], 85, UI_START_Y/8 + 2, COLOR_BLACK);
                            gpuSetColor(selectedColor);
                        }
                        #endif
                    }

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
    gpuFillRect_c(0,UI_START_Y,799,599,COLOR_DARK_GRAY);

    DrawSplash();

    //Wait for splash screen dismisal
    do { mouseRead(); } while (!mouseLDown());

    gpuFillRect_c(0,0,799,UI_START_Y-1,COLOR_WHITE);

    //Draw color palette
    for(int j=0;j<16;j++)
    {
        gpuFillRect_c(64+(32*j),UI_START_Y+2,95+(32*j),UI_START_Y+21,j<<8);
    }
    for(int j=0;j<16;j++)
    {
        gpuFillRect_c(64+(32*j),UI_START_Y+22,95+(32*j),UI_START_Y+41,j<<4);
    }
    for(int j=0;j<16;j++)
    {
        gpuFillRect_c(64+(32*j),UI_START_Y+42,95+(32*j),UI_START_Y+61,j);
    }

    gpuFillRect_c(578,UI_START_Y,673,599,COLOR_GRAY);

    drawIconOpt(578,UI_START_Y,COLOR_BLACK,ICON_PEN,1);
    drawIconOpt(610,UI_START_Y,COLOR_BLACK,ICON_RECT,1);
    drawIconOpt(642,UI_START_Y,COLOR_BLACK,ICON_BUCKET,1);
    drawIconOpt(578,UI_START_Y+32,COLOR_BLACK,ICON_LINE,1);
    drawIconOpt(610,UI_START_Y+32,COLOR_BLACK,ICON_FILL_RECT,1);
    drawIconOpt(642,UI_START_Y+32,COLOR_BLACK,ICON_CLEAR,1);

    #ifdef TEXT
    drawStringAligned(toolnames[selectedTool], 85, UI_START_Y/8 + 1, COLOR_BLACK);
    #endif

    drawIconOpt(768,UI_START_Y+32,COLOR_BLACK,ICON_ETF,0);
    AL(704,568,0,1);

    updateColor(0,0,2);
    updateColor(4,0,2);
    updateColor(8,0,2);
}

void updateColor(unsigned int channel,unsigned int val,unsigned int type)
{
    if(type==1)
    {
        unsigned int oldval=(selectedColor>>channel)&0xF;
        if(channel==0)
        {
            gpuDrawRect_c(64+(32*oldval),UI_START_Y+42,95+(32*oldval),UI_START_Y+61,oldval<<channel);
        }
        else if(channel==4)
        {
            gpuDrawRect_c(64+(32*oldval),UI_START_Y+22,95+(32*oldval),UI_START_Y+41,oldval<<channel);
        }
        else if(channel==8)
        {
            gpuDrawRect_c(64+(32*oldval),UI_START_Y+2,95+(32*oldval),UI_START_Y+21,oldval<<channel);
        }
    }
    else if(type==2)
    {
        if(channel==0)
        {
            gpuDrawRect_c(64+(32*val),UI_START_Y+42,95+(32*val),UI_START_Y+61,0xAAA);
        }
        else if(channel==4)
        {
            gpuDrawRect_c(64+(32*val),UI_START_Y+22,95+(32*val),UI_START_Y+41,0xAAA);
        }
        else if(channel==8)
        {
            gpuDrawRect_c(64+(32*val),UI_START_Y+2,95+(32*val),UI_START_Y+21,0xAAA);
        }
    }

    selectedColor=(selectedColor & (~(0xF<<channel))) | (val<<channel);
    gpuFillRect_c(2,UI_START_Y+2,63-2,599-2,selectedColor);
}

void DrawSplash()
{
    unsigned int xpos=208;
    unsigned int ypos=104;
    unsigned int xsize=384;
    unsigned int ysize=256;
    unsigned int endx=xpos+xsize-1;
    unsigned int endy=ypos+ysize-1;
    gpuDrawRect_c(xpos-3,ypos-3,endx+3,endy+3,COLOR_DARK_GRAY);
    gpuDrawRect_c(xpos-2,ypos-2,endx+2,endy+2,COLOR_DARK_GRAY);
    gpuDrawRect_c(xpos-1,ypos-1,endx+1,endy+1,COLOR_DARK_GRAY);
    gpuFillRect_c(xpos,ypos,endx,endy,COLOR_GRAY);
    AL(272,104,2,4);
    drawIconOpt(endx-32,endy-32,COLOR_BLACK,ICON_ETF,0);

    #ifdef TEXT
    drawStringAligned("arilla", 36, 29, COLOR_BLACK);
    drawStringAligned("Paint V2", 36, 30, COLOR_BLACK);
    drawStringAligned("Projekat iz Arhitekture racunara.", 36, 32, COLOR_BLACK);
    drawStringAligned("Aleksa Markovic  2019/0248", 36,34, COLOR_BLACK);
    drawStringAligned("Lazar Premovic   2019/0091", 36, 35, COLOR_BLACK);
    drawStringAligned("Luka Simic       2019/0368", 36, 36, COLOR_BLACK);
    drawStringAligned("Pritisnite levi taster misa da biste nastavili.", 26, 38, COLOR_BLACK);
    drawStringAligned("ETF Beograd, Septembar 2021.", 36, 42, COLOR_BLACK);
    #endif

}

void _start() {
    main();
}
