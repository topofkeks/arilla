# Mouse controller
The PS/2 mouse controller used in Arilla. Inputs and outputs of the controller component correspond with standard Arilla peripheral inputs and outputs.

The mouse has one status register at address `0x10000001`, with the following structure:
- 31..22: The Y coordinate of the mouse
- 21..12: The X coordinate of the mouse
- 11..4: Unused
- 3: Whether the coordinates changed
- 2: Whether the right button is clicked
- 1: Whether the left button is clicked
- 0: Whether the controller is ready

## Movement calculation
- Default mouse resolution is 4 counts per milimiter.
- The screen size is 800x600 pixels, and we should cap our stored values to that.
- You get the amount of inch in a milimiter by dividing the value with 25.4.
- We assume a screen resolution of 72 pixels per inch, which is 72/25.4 pixels per milimeter, and 72/25.4/4 pixels per count.
- This gives us a coefficient of around 0.7087. This is inconvenient, so we approximate 1 pixel to 1 count.

## Documentation
- [PS/2 Mouse/Keyboard Protocol](http://www.burtonsys.com/ps2_chapweske.htm) by Adam Chapweske
- [The PS/2 Mouse Interface](https://isdaman.com/alsos/hardware/mouse/ps2interface.htm) by Adam Chapweske
