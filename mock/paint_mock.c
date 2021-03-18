/*
 * Arilla - Computer Architecture project, spring 2021.
 * 
 * paint_mock.c 
 * Paint program mock-up for prototyping purposes
 *
*/

// The smallest addressable word is 16 bit, represented in C by short

// ================================================
// DRAWING ROUTINES 

// The canvas
// Resolution 640x400, 4 pixels per word in a continual block of memory
// 640 x 400 = 256 000 pixels
// 256 000 / 4 = 64 000 words

const short CANVAS_SIZE = 64000;

// A pixel consists of 4 bits, each represnting one of 16 colors from a palette
// These 16 colors will be mapped in the registers of the GPU
// The mapping of these colors will be done using GPU instructions
// A suggestion for the default palette: https://en.wikipedia.org/wiki/ZX_Spectrum_graphic_modes

// 160 words per horizontal line
// 400 horizontal lines
short canvas[CANVAS_SIZE];

// Current mouse coordinates
register short mouse_x, mouse_y;

// Currently selected color, repeated 4 times to fill the whole register
register short current_color;

// Currently selected tool, will be used to map to a array of pointers to routines
register short current_tool;

void (*paint_tools)(void) = { px_1_pen, px_2_pen, px_4_pen, rubber, paint_bucket, fill_canvas };

// GPU refresh instruction
extern void refresh(void);

// Fills entire canvas with selected color
void fill_canvas(void){
    register short i;
    register short fill = current_color;
    for(i = 0; i < CANVAS_SIZE; ++i)
        canvas[i] = fill;
    refresh();
}

// 1 pixel wide pen
void px_1_pen(void){
    register short fill = (current_color & 0xF) << (mouse_x & 3 << 2);
    canvas[400 * mouse_y + mouse_x >> 2] = fill;
    refresh();
}

// 2x2 pixel wide pen
void px_2_pen(void);

// 4x4 pixel wide pen
void px_4_pen(void);

// 2x2 pixel wide rubber
void rubber(void);

// Paint bucket - floods continual pixels of the color hovered by mouse with the selected color
void paint_bucket(void);


// ================================================
// INTERRUPT ROUTINES

extern volatile left_mouse_btn, right_mouse_btn; 

// Program counter
register short PC;

// Register connected to indicator LEDs on the FPGA
// 1 bit aligns to 1 LED
register short leds;

// Register connected to a Binary2BCD 7-segment display controller
// The binary number in this register will be continually displayed on the FPGA's 7 segment display
register short seven_segment;

void interrupt_invalid_opcode(void){
    leds |= 1;
    // Represents a JMP, not a JSR
    goto interrupt_trap; 
}

void interrupt_trap(void){
    seven_segment = PC;
    while(!right_mouse_btn);
}

void interrupt_left_mouse_button(void){
    if (mouse_y < 400) 
        paint_tools[current_tool]();
    else   
        // Toolbox area, todo
}