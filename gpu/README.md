# Arilla GPU
The Arilla GPU performs several functions:
- Reading from SDRAM and outputting its contents onto VGA
- Reading mouse X and Y positions and showing its sprite on VGA output
- Taking commands to draw a pixel, line or rectangle from the CPU
- Taking commands to read a pixel from the CPU and caching a sequence of pixels

## Registers
GPU exposes the following registers to the CPU:
- `0x20000000`: Control register
    - 31..20: Color to draw (4 bits for red, green and blue)
    - 19..8: Unused
    - 7..5: Operation code, one of the following:
        - 000: Draw point
        - 001: Draw line
        - 010: Draw rectangle
        - 011: Fill rectangle
        - 100: Get color of pixel
    - 4..3: Unused
    - 2: Whether the cursor should display 
    - 1: Whether to run any commands
    - 0: Whether to show anything on VGA
- `0x20000001`: Status register
    - 31..20: Color that was read from memory (4 bits for red, green and blue)
    - 19..1: Unused
    - 0: Whether the GPU is ready to receive a command
- `0x20000002`: Start point of drawing
    - 31..20: Unused
    - 19..10: Y coordinate of the point
    - 9..0: X coordinate of the point
- `0x20000003`: End point of drawing
    - 31..20: Unused
    - 19..10: Y coordinate of the point
    - 9..0: X coordinate of the point

## Documentation
- `SDRAM Timings.xlsx` for shortened version of memory communication timings
- `VGA timing sketch.drawio` for a visual description of how outputting to VGA works
- [Documentation for the SDRAM chip](http://www.issiusa.com/pdf/42S16400.pdf)
- [Bresenham's algorithm](https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm) which the line drawer uses
