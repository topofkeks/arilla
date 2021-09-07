# Arilla
Arilla - Computer Architecture project, spring 2021.

## About
The project was about running Paint on a Cyclone III FPGA. This included:
- a RISC-V ([rv32i](https://metalcode.eu/2019-12-06-rv32i.html)) CPU,
- a C program compiled using [GCC](https://github.com/riscv-software-src/riscv-gnu-toolchain),
- a GPU (outputting on a VGA display) with the ability to draw a pixel, line or square,
- a module for communication with SDRAM (within the GPU),
- a PS/2 mouse controller, and
- additional tools.

You can read additional information under folders for each of these components.

## Development tools
- [Quartus 13.1 Web Edition](https://fpgasoftware.intel.com/13.1/) (developing for the FPGA)
- ModelSim-Altera Starter Edition (simulating and debugging our components)
- [Code::Blocks](https://codeblocks.org/) (C program development)
- [RARS](https://github.com/TheThirdOne/rars) and [Compiler Explorer](https://godbolt.org/) (RISC-V core debugging)

## Best practices
The following are best practices when developing components for Arilla - they allow easier simulation through ModelSim and make development more consistent:
- Single bit constant signals should not be named `0` and `1`, but `zero` and `one` instead.
    - `0` and `1` are reserved VHDL characters.
- Signals should not be named `IN` or `OUT`, but `I` and `O`.
    - Similarly to the above.
- Identifiers must begin with a letter and should end with a letter (ending with a digit is allowed but discouraged).
- When generating components, generate them in the `components` folder from the `components` project and make sure they are included in that project.
- Generate megafunctions using VHDL and only generate required files (`.vhd` and `.bsf`).
- Microcode memory initialization (`.mif`) files should be placed in the `mic` folder while `.vhd` asynchronous ROM files belong to folder of the project in which they are used.

## Documentation
- [DE0 User Manual](https://rti.etf.bg.ac.rs/rti/oo1pot/labvezbe/DE0_User_manual.pdf)
- [Cocline III Device Handbook](https://rti.etf.bg.ac.rs/rti/oo1pot/labvezbe/cyclone3_handbook.pdf)
