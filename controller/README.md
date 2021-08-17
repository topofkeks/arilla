# Mouse controller
The PS/2 mouse controller used in Arilla. Inputs and outputs of the controller component correspond with standard Arilla peripheral inputs and outputs.

Functional diagram can be found in `Controller.drawio`, microcode in `Controller.mic` and memory initialization file generated using `mic.py` in `Controller.mif`.

## Movement calculation
- Default mouse resolution is 4 counts per milimiter.
- The screen size is 800x600 pixels, and we should cap our stored values to that.
- You get the amount of inch in a milimiter by dividing the value with 25.4.
- We assume a screen resolution of 72 pixels per inch, which is 72/25.4 pixels per milimeter, and 72/25.4/4 pixels per count.
- This gives us a coefficient of around 0.7087. This is inconvenient, so we approximate 1 pixel to 2 counts.
