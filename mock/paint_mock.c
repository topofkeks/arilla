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

const unsigned short CANVAS_SIZE = 64000;

// A pixel consists of 4 bits, each represnting one of 16 colors from a palette
// These 16 colors will be mapped in the registers of the GPU
// The mapping of these colors will be done using GPU instructions
// A suggestion for the default palette: https://en.wikipedia.org/wiki/ZX_Spectrum_graphic_modes

// 160 words per horizontal line
// 400 horizontal lines
short canvas[CANVAS_SIZE];

// Register connected to indicator LEDs on the FPGA
// 1 bit aligns to 1 LED
register short leds;

// Register connected to a Binary2BCD 7-segment display controller
// The binary number in this register will be continually displayed on the FPGA's 7 segment display
register short seven_segment;

// Register connected to switches on the FPGA.
// 1 bit aligns to 1 switch.
register short switches;

// Register connected to buttons on the FPGA.
// 1 bit aligns to 1 switch.
register short buttons;

// Current mouse coordinates
register short mouse_x;
register short mouse_y;

// Current mouse state.
register short mouse_state;

// Flags for extraction of information from mouse state.
const short MOUSE_LEFT_BUTTON_DOWN = 1;
const short MOUSE_RIGHT_BUTTON_DOWN = 2;

// Currently selected color, repeated 4 times to fill the whole register
register short current_color;

// ================================================
// TOOLBOX

typedef void (*Tool)(register short);

// Toolbox vertical position
const short TOOLBOX_Y = 400;

// Amount of tools before colors.
const short TOOL_COUNT = 4;

// Type of event that triggered the tool.
const short NO_EVENT = 0;
const short MOUSE_CLICKED = 1;
const short MOUSE_RELEASED = 2;
const short MOUSE_MOVED = 3;

// GPU refresh instruction
extern void refresh(void);

// Fills entire canvas with selected color
void fill_canvas(register short event) {
    if (event != MOUSE_CLICKED) {
        return;
    }
    register short i;
    register short fill = current_color;
    for (i = 0; i < CANVAS_SIZE; ++i)
        canvas[i] = fill;
}

void pen(register short event) {
    if (switches == 1) {
        px_2_pen();
    } else if (switches == 2) {
        px_4_pen();
    } else {
        px_1_pen();
    }
}

// 1 pixel wide pen
void px_1_pen(void){
    register short fill = (current_color & 0xF) << ((3 - (mouse_x & 3)) << 2);
    canvas[400 * mouse_y + mouse_x >> 2] = fill;
}

// 2x2 pixel wide pen
void px_2_pen(void);

// 4x4 pixel wide pen
void px_4_pen(void);

// 2x2 pixel wide rubber
void rubber(register short event);

// Paint bucket - floods continual pixels of the color hovered by mouse with the selected color
void paint_bucket(register short event);

const Tool paint_tools[] = { pen, rubber, paint_bucket, fill_canvas };

// Currently selected tool, will be used to map to a array of pointers to routines
register Tool current_tool;

// ================================================
// INTERRUPT ROUTINES

// Program counter
register short PC;

// Mouse controller registers with absolute mouse position and state.
extern register short mouse_x_controller;
extern register short mouse_y_controller;
extern register short mouse_state_controller;

// GPU registers with mouse position.
extern register short mouse_x_gpu;
extern register short mouse_y_gpu;

void interrupt_invalid_opcode(void) {
    leds |= 1;
    // Represents a JMP, not a JSR
    goto interrupt_trap;
}

void interrupt_invalid_addressing(void) {
    leds |= 2;
    // Represents a JMP, not a JSR
    goto interrupt_trap;
}

void interrupt_trap(void) {
    seven_segment = PC;
    while ((mouse_state & MOUSE_RIGHT_BUTTON_DOWN) == 0);
}

void interrupt_mouse(void) {
    register short new_mouse_x = mouse_x_controller;
    register short new_mouse_y = mouse_y_controller;
    register short new_mouse_state = mouse_state_controller;
    register short mouse_down = new_mouse_state & MOUSE_LEFT_BUTTON_DOWN;
    register short mouse_was_down = mouse_state & MOUSE_LEFT_BUTTON_DOWN;
    register short mouse_clicked = mouse_down && !mouse_was_down;
    register short mouse_moved = new_mouse_x != mouse_x || new_mouse_y != mouse_y;
    if (new_mouse_y >= TOOLBOX_Y && mouse_clicked) {
        // Calculating toolbox tool position. A toolbox item is 32x32 and the tools
        // are positioned like:
        // 0 2 4 6 8 A C E ...
        // 1 3 5 7 9 B D F ...
        register short tool_pos = (new_mouse_y - TOOLBOX_Y) >> 5 + (new_mouse_x >> 4);
        if (tool_pos >= TOOL_COUNT && tool_pos < TOOL_COUNT + 16) {
            // We selected a color.
            current_color = tool_pos - TOOL_COUNT;
        } else if (tool_pos < TOOL_COUNT) {
            current_tool = paint_tools[tool_pos];
        }
    } else {
        register short event_arg;
        if (mouse_clicked) {
            event_arg = MOUSE_CLICKED;
        } else if (!mouse_down && mouse_was_down) {
            event_arg = MOUSE_RELEASED;
        } else if (mouse_moved) {
            event_arg = MOUSE_MOVED;
        } else {
            event_arg = NO_EVENT;
        }
        if (event_arg != NO_EVENT) {
            current_tool(event_arg);
            refresh();
        }
    }
    if (mouse_moved) {
        mouse_x_gpu = new_mouse_x;
        mouse_y_gpu = new_mouse_y;
    }
    mouse_x = new_mouse_x;
    mouse_y = new_mouse_y;
    mouse_state = new_mouse_state;
}

// ================================================
// MAIN PROCEDURE

int main(void) {
    // TODO: Initialization?
    current_color = 15;
    // This should be set in controller as well.
    mouse_x = 320;
    mouse_y = 240;
    current_tool = pen;
    return 0;
}
